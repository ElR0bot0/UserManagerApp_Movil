import 'package:loggy/loggy.dart';
import '../../domain/entities/report.dart';
import '../../domain/repositories/ireportrepository.dart';
import '../datasources/local/report_local_datasource.dart';
import '../datasources/remote/i_report_remote_datasource.dart';

class ReportRepository implements IReportRepository {
  final IReportRemoteDataSource _reportDatasource;
  late DatabaseHelper report_local_datasource;

  ReportRepository(this._reportDatasource);

  @override
  Future<bool> addReport(Report report, int status) async {
    try {
      return await _reportDatasource.addReport(report, status);
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
  Future<bool> deleteReport(String id) async {
    try {
      return await _reportDatasource.deleteReport(id);
    } catch (error) {
      logError('Error deleting Report in repository: $error');
      return false;
    }
  }

  @override
  Future<bool> rateReport(Report report) async {
    try {
      return await _reportDatasource.rateReport(report);
    } catch (error) {
      logError('Error updating Report in repository: $error');
      return false;
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
