import 'package:get/get.dart';
import '../../data/repositories/report_repository.dart';
import '../entities/report.dart';

class Reports {
  final ReportRepository _repository = Get.find();
  Reports(find);
  Future<void> addReport(report) async => await _repository.addReport(report);
  Future<List<Report>> getAllReports() async => await _repository.getAllReports();
  Future<void> deleteReport(id) async => await _repository.deleteReport(id);
  Future<void> rateReport(report) async => await _repository.rateReport(report);
}