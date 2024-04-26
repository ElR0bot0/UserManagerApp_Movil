import 'package:get/get.dart';

import '../../data/repositories/report_repository.dart';
import '../entities/report.dart';

class Reportss {
  final ReportRepository _repository = Get.find();
  Reportss(find);

  Future<void> addReport(reporti, status) async => await _repository.addReport(reporti, status);

  Future<List<Report>> getAllReports() async => await _repository.getAllReports();

  Future<void> deleteReport(id) async => await _repository.deleteReport(id);

  Future<void> rateReport(reporti) async => await _repository.rateReport(reporti);
}