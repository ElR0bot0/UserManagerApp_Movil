import '../../../domain/entities/report.dart';

abstract class IReportRemoteDataSource {
  Future<void> addReport(Report report, int status);
  Future<List<Report>> getAllReports();
  Future<void> deleteReport(String id);
  Future<void> rateReport(Report report);
  Future<void> savePendingRecord(Report report);
  Future<void> uploadToApi(Report report);
  Future<void> uploadPendingRecords();
}
