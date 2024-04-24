import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../domain/entities/report.dart';
import '../../domain/use_case/reports.dart';

class ReportController extends GetxController {
  final RxList<Report> _reports = <Report>[].obs;
  ReportController({required this.reportUseCase});
  Reportss reportUseCase;

  List<Report> get reports => _reports;

  @override
  onInit() {
    super.onInit();
    getAllReports();
  }

  Future<void> addReport(report) async {
    logInfo("ReportController -> add reporter");
    await reportUseCase.addReport(report);
    await getAllReports();
  }

  Future<void> getAllReports() async {
    var list = await reportUseCase.getAllReports();
    _reports.value = list;
    _reports.refresh();
  }

  Future<void> deleteReport(id) async {
    logInfo("ReportController -> delete reporter $id");
    await reportUseCase.deleteReport(id);
    await getAllReports();
  }

  Future<void> rateReport(report) async {
    logInfo("ReportController -> updateUser reporter ${report.id}");
    await reportUseCase.rateReport(report);
    await getAllReports();
  }
}
