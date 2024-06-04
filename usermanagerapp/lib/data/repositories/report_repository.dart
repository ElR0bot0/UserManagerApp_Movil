import 'package:loggy/loggy.dart';
import '../../domain/entities/report.dart';
import '../../domain/repositories/ireportrepository.dart';
import '../datasources/local/report_local_datasource.dart';
import '../datasources/remote/report_remote_datasource.dart';

class ReportRepository implements IReportRepository {
  late ReportRemoteDataSource _reportDatasource;
  late DatabaseHelper report_local_datasource;

  ReportRepository() {
    logInfo("Starting ReportRepository");
    _reportDatasource = ReportRemoteDataSource();
  }

  @override
  Future<bool> addReport(Report report, int status) async {
    try {
      await _reportDatasource.addReport(report, status);
      return true;
    } catch (error) {
      logError('Error adding Report in repository: $error');
      return false;
    }
  }

  @override
  Future<List<Report>> getAllReports() async {
    try {
      return await _reportDatasource.getAllReports();
    } catch (error) {
      logError('Error getting all Reports in repository: $error');
      return [];
    }
  }

  @override
  Future<void> deleteReport(String id) async {
    try {
      await _reportDatasource.deleteReport(id);
    } catch (error) {
      logError('Error deleting Report in repository: $error');
    }
  }

  @override
  Future<void> rateReport(Report report) async {
    try {
      await _reportDatasource.rateReport(report);
    } catch (error) {
      logError('Error updating Report in repository: $error');
    }
  }

    @override
  Future<int> getPendingCount() async {
    try {
      int count = await report_local_datasource.getPendingCount();
      return count;
    } catch (error) {
      logError('Error updating Report in repository: $error');
      return 0;
    }
  }
}
