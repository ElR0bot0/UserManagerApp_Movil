import '../entities/report.dart';

abstract class IReportRepository {
  Future<bool> getReport();
  Future<List<Report>> getAllReports();
  Future<void> deleteReport(id);
  Future<void> rateReport(report);
  Future<void> addReport(id);
}