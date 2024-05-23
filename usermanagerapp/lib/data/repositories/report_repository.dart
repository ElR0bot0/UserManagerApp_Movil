import 'package:loggy/loggy.dart';
import '../../domain/entities/report.dart';
import '../datasources/remote/report_remote_datasource.dart';

class ReportRepository {
  late ReportRemoteDataSource _ReportDatatasource;

  ReportRepository() {
    logInfo("Starting ReportRepository");
    _ReportDatatasource = ReportRemoteDataSource();
  }

  Future<bool> addReport(Report reporti, int status) async {
    try {
      return await _ReportDatatasource.addReport(reporti, status);
    } catch (error) {
      logError('Error adding Report in repository: $error');
      return false;
    }
  }

  Future<List<Report>> getAllReports() async {
    try {
      return await _ReportDatatasource.getAllReports();
    } catch (error) {
      logError('Error getting all Reports in repository: $error');
      return [];
    }
  }

  Future<bool> deleteReport(String id) async {
    try {
      return await _ReportDatatasource.deleteReport(id);
    } catch (error) {
      logError('Error deleting Report in repository: $error');
      return false;
    }
  }

  Future<bool> rateReport(Report reports) async {
    try {
      return await _ReportDatatasource.rateReport(reports);
    } catch (error) {
      logError('Error updating Report in repository: $error');
      return false;
    }
  }
}
