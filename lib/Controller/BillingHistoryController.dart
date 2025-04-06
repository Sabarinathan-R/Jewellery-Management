// controllers/billing_history_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/BillingRecord.dart';

class BillingHistoryController extends GetxController {
  RxList<BillingRecord> allRecords = <BillingRecord>[].obs;
  RxList<BillingRecord> displayedRecords = <BillingRecord>[].obs;
  RxBool hasMore = true.obs;

  int perPage = 10;
  int currentPage = 1;
  DateTime? startDate;
  DateTime? endDate;
  String searchQuery = '';

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('billing_history');
    if (data != null) {
      allRecords.value = BillingRecord.decode(data);
      applyFilters();
    }
  }

  Future<void> addRecord(BillingRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    allRecords.insert(0, record); // newest first
    await prefs.setString('billing_history', BillingRecord.encode(allRecords));
    applyFilters();
  }

  void loadMore() {
    currentPage++;
    applyFilters();
  }

  void search(String query) {
    searchQuery = query.toLowerCase();
    currentPage = 1;
    applyFilters();
  }

  RxBool isAscending = true.obs;

  void toggleSortByTotal() {
    isAscending.value = !isAscending.value;
    sortByTotal(isAscending.value);
  }

  void sortByTotal(bool ascending) {
    allRecords.sort((a, b) =>
        ascending ? a.total.compareTo(b.total) : b.total.compareTo(a.total));
    currentPage = 1;
    applyFilters();
  }

  void filterByDate(DateTime? start, DateTime? end) {
    startDate = start;
    endDate = end;
    currentPage = 1;
    applyFilters();
  }

  void resetFilter() {
    searchQuery = '';
    startDate = null;
    endDate = null;
    currentPage = 1;
    applyFilters();
  }

  void applyFilters() {
    List<BillingRecord> filtered = allRecords;

    if (startDate != null || endDate != null) {
      filtered = filtered.where((record) {
        final ts = record.timestamp;
        final endInclusive = endDate
            ?.add(const Duration(days: 1))
            .subtract(const Duration(seconds: 1));

        if (startDate != null && ts.isBefore(startDate!)) {
          return false;
        }
        if (endInclusive != null && ts.isAfter(endInclusive)) {
          return false;
        }
        return true;
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((record) {
        return record.items.any(
            (item) => item.product.name.toLowerCase().contains(searchQuery));
      }).toList();
    }

    final start = 0;
    final end = (currentPage * perPage).clamp(0, filtered.length);
    displayedRecords.value = filtered.sublist(start, end);
    hasMore.value = end < filtered.length;
  }

  int getTotalProducts() {
    final allItems = allRecords.expand((e) => e.items).toList();
    return allItems.map((e) => e.product.name).toSet().length;
  }

  int getTodayRevenue() {
    final today = DateTime.now();
    return allRecords
        .where((record) =>
            record.timestamp.year == today.year &&
            record.timestamp.month == today.month &&
            record.timestamp.day == today.day)
        .fold(0.0, (sum, record) => sum + record.total)
        .toInt();
  }

  List<BillingRecord> get getRecentRecordsbills {
    final sorted = [...allRecords];
    sorted.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.length > 4 ? sorted.take(4).toList() : sorted;
  }
}
