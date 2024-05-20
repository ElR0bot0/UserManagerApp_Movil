// Import the necessary Mockito and Build Runner packages
import 'package:f_testing_template/data/datasources/remote/us_remote_datasource.dart';
import 'package:f_testing_template/data/repositories/us_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

// run the build runner with the command:
// flutter pub run build_runner build

@GenerateMocks([USRemoteDataSource])
@GenerateMocks([USRepository])
@GenerateMocks([http.Client])
void main() {}
