import 'package:f_testing_template/domain/entities/report.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../domain/use_case/reports.dart';

class ReportController extends GetxController {
  final RxList<Report> _reports = <Report>[].obs;
  ReportController({required this.reportUseCase});
  Reports reportUseCase;

  List<Report> get reports => _reports;

  @override
  onInit() {
    super.onInit();
    getAllReports();
  }

  Future<void> addReport(report) async {
    logInfo("ReportController -> add user");
    await reportUseCase.addReport(report);
    await getAllReports();
  }

  Future<void> getAllReports() async {
    var list = await reportUseCase.getAllReports();
    logInfo("ReportController -> getAllUsers got " + list.length.toString());
    _reports.value = list;
    _reports.refresh();
  }

  Future<void> deleteReport(id) async {
    logInfo("ReportController -> delete user $id");
    await reportUseCase.deleteReport(id);
    await getAllReports();
  }

  Future<void> rateReport(report) async {
    logInfo("ReportController -> rateUser user ${report.id}");
    await reportUseCase.rateReport(report);
    await getAllReports();
  }
}
