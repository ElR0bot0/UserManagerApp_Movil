import 'package:f_testing_template/data/datasources/local/us_local_datasource.dart';
import 'package:loggy/loggy.dart';
import '../../../domain/entities/report.dart';

class ReportLocalDataSource {
  List<Report> reports = <Report>[];
  static int globalId = 0;
  late USLocalDataSource usLocalDataSource;

  ReportLocalDataSource() {
    logInfo("Starting USRepository");
    usLocalDataSource = USLocalDataSource();
  }

  addReport(Report report) {
    report.id = globalId;
    globalId++;
    logInfo("Local data source adding Report");
    reports.add(report);
    report.us.reportquantity++;
    usLocalDataSource.updateUS(report.us);
  }

  Future<List<Report>> getAllReports() async {
    logInfo("Local data returning getAllReports " + reports.length.toString());
    return reports;
  }

  Future<void> deleteReport(id) async {
    reports.removeWhere((element) => element.id == id);
  }

  Future<void> rateReport(reporte) async {
    Report oldReport = reports.singleWhere((element) => element.id == reporte.id);
    reports[reports.indexOf(oldReport)] = reporte;
    reporte.us.ratings.add(reporte.rating);
    int suma = 0;
    for(int rating in reporte.us.ratings){
      suma += rating;
    }
    double avg = suma / reporte.us.ratings.length;
    reporte.us.avgrating = avg;
    usLocalDataSource.updateUS(reporte.us);
  }
}
