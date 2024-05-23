// Import the necessary Mockito and Build Runner packages
import 'package:f_testing_template/data/datasources/local/i_report_local_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

// run the build runner with the command:
// flutter pub run build_runner build

@GenerateMocks([IReportDataSource])
@GenerateMocks([http.Client])
void main() {}
