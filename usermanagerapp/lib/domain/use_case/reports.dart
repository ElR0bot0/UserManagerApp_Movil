import 'package:f_testing_template/domain/repositories/ireportrepository.dart';
import '../entities/report.dart';

class Reportss {
  final IReportRepository _repository;

  Reportss(this._repository);

  Future<bool> addReport(reporti, status) async =>
      await _repository.addReport(reporti, status);

  Future<List<Report>> getAllReports() async =>
      await _repository.getAllReports();

  Future<bool> deleteReport(id) async => await _repository.deleteReport(id);

  Future<bool> rateReport(reporti) async =>
      await _repository.rateReport(reporti);

  Future<int> getPendingCount() async => await _repository.getPendingCount();
}
