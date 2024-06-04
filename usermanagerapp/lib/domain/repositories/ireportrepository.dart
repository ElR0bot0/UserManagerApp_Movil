import '../entities/report.dart';

abstract class IReportRepository {
  Future<bool> addReport(Report report, int status);
  Future<List<Report>> getAllReports();
  Future<void> deleteReport(String id);
  Future<void> rateReport(Report report);
  Future<int> getPendingCount();
}
