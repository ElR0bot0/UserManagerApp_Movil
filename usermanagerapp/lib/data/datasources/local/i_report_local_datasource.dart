import '../../../domain/entities/report.dart';

abstract class IReportDataSource {
  Future<int> insertReport(Report report);
  Future<List<Report>> getReports();
  Future<int> updateReport(Report report);
  Future<int> deleteReport(int id);
}