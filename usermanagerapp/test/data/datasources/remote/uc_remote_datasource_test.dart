import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:f_testing_template/data/datasources/remote/uc_remote_datasource.dart';

import '../../../mocks/uc_test.mocks.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late UCRemoteDatasource dataSource;
  const String apiUrl =
      'https://retoolapi.dev/Nlayzp/data/'; // Ensure apiUrl is properly declared

  group('UCRemoteDatasource Tests', () {
    final mockHttpClient = MockClient();
    dataSource = UCRemoteDatasource(client: mockHttpClient);

    test('authenticateUC returns true when the authentication is successful',
        () async {
      final String email = 'test@example.com';
      final String password = 'password123';
      final Uri requestUri = Uri.parse('$apiUrl?email=$email&clave=$password');
      const String jsonResponse = '[{"id":1,"email":"test@example.com"}]';

      when(mockHttpClient.get(requestUri))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      bool result = await dataSource.authenticateUC(email, password);

      expect(result, isTrue);
    });

    test('authenticateUC returns false when the authentication fails',
        () async {
      final String email = 'test@example.com';
      final String password = 'wrongpassword';
      final Uri requestUri = Uri.parse('$apiUrl?email=$email&clave=$password');

      when(mockHttpClient.get(requestUri))
          .thenAnswer((_) async => http.Response('[]', 200));

      bool result = await dataSource.authenticateUC(email, password);

      expect(result, isFalse);
    });

    test('authenticateUC returns false when the status code is not 200',
        () async {
      final String email = 'test@example.com';
      final String password = 'password123';
      final Uri requestUri = Uri.parse('$apiUrl?email=$email&clave=$password');

      when(mockHttpClient.get(requestUri))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      bool result = await dataSource.authenticateUC(email, password);

      expect(result, isFalse);
    });
  });
}
