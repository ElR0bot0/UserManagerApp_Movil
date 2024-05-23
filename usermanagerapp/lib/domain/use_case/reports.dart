import 'package:get/get.dart';

import '../../data/repositories/report_repository.dart';
import '../entities/report.dart';

class Reportss {
  final ReportRepository _repository = Get.find();
  Reportss(find);

  Future<bool> addReport(reporti, status) async =>
      await _repository.addReport(reporti, status);

  Future<List<Report>> getAllReports() async =>
      await _repository.getAllReports();

  Future<bool> deleteReport(id) async => await _repository.deleteReport(id);

  Future<bool> rateReport(reporti) async =>
      await _repository.rateReport(reporti);
}
