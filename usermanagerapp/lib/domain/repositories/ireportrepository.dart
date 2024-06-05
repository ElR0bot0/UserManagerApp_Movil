import '../entities/report.dart';

abstract class IReportRepository {
  Future<bool> addReport(Report report, int status);
  Future<List<Report>> getAllReports();
  Future<bool> deleteReport(String id);
  Future<bool> rateReport(Report report);
  Future<int> getPendingCount();
}
