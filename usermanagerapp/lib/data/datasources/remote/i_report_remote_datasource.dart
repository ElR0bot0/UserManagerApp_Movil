import '../../../domain/entities/report.dart';

abstract class IReportRemoteDataSource {
  Future<bool> addReport(Report report, int status);
  Future<List<Report>> getAllReports();
  Future<bool> deleteReport(String id);
  Future<bool> rateReport(Report report);
  Future<void> savePendingRecord(Report report);
  Future<void> uploadToApi(Report report);
  Future<void> uploadPendingRecords(Report a);
}
