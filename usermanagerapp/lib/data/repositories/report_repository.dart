import 'package:loggy/loggy.dart';

import '../../domain/entities/report.dart';
import '../datasources/local/report_local_datasource.dart';

class ReportRepository {

  late ReportLocalDataSource _reportDatatasource;

  ReportRepository() {
    logInfo("Starting ReportRepository");
    _reportDatatasource = ReportLocalDataSource();
  }

  Future<bool> addReport(Report report) async {
    await _reportDatatasource.addReport(report);
    return Future.value(true);
  } 

  Future<List<Report>> getAllReports() async => await _reportDatatasource.getAllReports();

  Future<void> deleteReport(id) async => await _reportDatatasource.deleteReport(id);

  Future<void> rateReport(report) async => await _reportDatatasource.rateReport(report);
}