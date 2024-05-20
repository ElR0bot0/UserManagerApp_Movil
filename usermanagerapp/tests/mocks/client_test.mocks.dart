// Import the necessary Mockito and Build Runner packages
import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart';
import 'package:f_testing_template/data/repositories/client_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

// run the build runner with the command:
// flutter pub run build_runner build

@GenerateMocks([ClientRemoteDataSource])
@GenerateMocks([ClientRepository])
@GenerateMocks([http.Client])
void main() {}
