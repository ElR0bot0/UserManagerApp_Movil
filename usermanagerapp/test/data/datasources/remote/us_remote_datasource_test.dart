import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:f_testing_template/data/datasources/remote/us_remote_datasource.dart';
import 'package:f_testing_template/domain/entities/us.dart';

import '../../../mocks/us_test.mocks.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late USRemoteDataSource dataSource;
  const String apiUrl =
      'https://retoolapi.dev/sG38Em/data'; // Ensure apiUrl is properly declared

  group('USRemoteDataSource Tests', () {
    final Uri usUri = Uri.parse(apiUrl);
    const String usJson =
        '[{"id":1,"name":"John Doe","email":"john.doe@example.com","password":"password123","reportquantity":1,"ratings":[5],"avgrating":5.0}]';
    final mockHttpClient = MockClient();
    dataSource = USRemoteDataSource(client: mockHttpClient);

    test('getAllUSs returns a list of USs on a successful call', () async {
      when(mockHttpClient.get(usUri))
          .thenAnswer((_) async => http.Response(usJson, 200));

      final result = await dataSource.getAllUSs();

      expect(result, isA<List<US>>());
      expect(result.first.name, equals('John Doe'));
    });

    test('addUS returns true when a US is successfully added', () async {
      final us = US(
        id: '1',
        name: 'Jane Doe',
        email: 'jane.doe@example.com',
        password: 'password123',
        reportquantity: 0,
      );

      when(mockHttpClient.post(usUri,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', 201));

      bool result = await dataSource.addUS(us);

      expect(result, isTrue);
    });

    test('updateUS returns true when a US is successfully updated', () async {
      final us = US(
        id: '1',
        name: 'John Doe Updated',
        email: 'john.doe@example.com',
        password: 'password123',
        reportquantity: 1,
      );

      when(mockHttpClient.put(Uri.parse("https://retoolapi.dev/sG38Em/data/1"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', 200));

      bool result = await dataSource.updateUS(us);

      expect(result, isTrue);
    });

    test('deleteUS returns true when a US is successfully deleted', () async {
      when(mockHttpClient
              .delete(Uri.parse("https://retoolapi.dev/sG38Em/data/1")))
          .thenAnswer((_) async => http.Response('', 200));

      bool result = await dataSource.deleteUS('1');

      expect(result, isTrue);
    });

    test('authenticateUS returns true when the authentication is successful',
        () async {
      final String email = 'test@example.com';
      final String password = 'password123';
      final Uri requestUri = Uri.parse('$apiUrl?email=$email&clave=$password');
      const String jsonResponse = '[{"id":1,"email":"test@example.com"}]';

      when(mockHttpClient.get(requestUri))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      bool result = await dataSource.authenticateUS(email, password);

      expect(result, isTrue);
    });

    test('authenticateUS returns false when the authentication fails',
        () async {
      final String email = 'test@example.com';
      final String password = 'wrongpassword';
      final Uri requestUri = Uri.parse('$apiUrl?email=$email&clave=$password');

      when(mockHttpClient.get(requestUri))
          .thenAnswer((_) async => http.Response('[]', 200));

      bool result = await dataSource.authenticateUS(email, password);

      expect(result, isFalse);
    });

    test('authenticateUS returns false when the status code is not 200',
        () async {
      final String email = 'test@example.com';
      final String password = 'password123';
      final Uri requestUri = Uri.parse('$apiUrl?email=$email&clave=$password');

      when(mockHttpClient.get(requestUri))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      bool result = await dataSource.authenticateUS(email, password);

      expect(result, isFalse);
    });

    test('getUSById returns a US on a successful call', () async {
      when(mockHttpClient.get(Uri.parse("https://retoolapi.dev/sG38Em/data/1")))
          .thenAnswer((_) async => http.Response(
              '{"id":1,"name":"John Doe","email":"john.doe@example.com","password":"password123","reportquantity":1,"ratings":[5],"avgrating":5.0}',
              200));

      final result = await dataSource.getUSById('1');

      expect(result, isA<US>());
      expect(result?.name, equals('John Doe'));
    });

    test('getUSByEmail returns a US on a successful call', () async {
      when(mockHttpClient.get(Uri.parse(
              "https://retoolapi.dev/sG38Em/data?email=john.doe@example.com")))
          .thenAnswer((_) async => http.Response(
              '[{"id":1,"name":"John Doe","email":"john.doe@example.com","password":"password123","reportquantity":1,"ratings":[5],"avgrating":5.0}]',
              200));

      final result = await dataSource.getUSByEmail('john.doe@example.com');

      expect(result, isA<US>());
      expect(result?.name, equals('John Doe'));
    });
  });
}
