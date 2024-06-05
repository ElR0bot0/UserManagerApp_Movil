import 'dart:convert';

import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart';
import 'package:f_testing_template/domain/entities/client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../mocks/client_test.mocks.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ClientRemoteDataSource dataSource;
  const String apiKey = 'MAImUm'; // Ensure apiKey is properly declared

  group('ClientRemoteDataSource Tests', () {
    final Uri baseUri = Uri.parse("https://retoolapi.dev/$apiKey/data");
    const String clientsJson =
        '[{"id":"1","name":"Client1"},{"id":"2","name":"Client2"}]';
    final mockHttpClient = MockClient();
    dataSource = ClientRemoteDataSource(client: mockHttpClient);

    test('getAllClients returns a list of clients on a successful call',
        () async {
      when(mockHttpClient.get(baseUri))
          .thenAnswer((_) async => http.Response(clientsJson, 200));

      final result = await dataSource.getAllClients();

      expect(result, isA<List<Client>>());
      expect(result.first.name, equals('Client1'));
    });

    test('addClient returns true when a client is successfully added',
        () async {
      final client = Client(id: '3', name: 'Client3');

      when(mockHttpClient.post(
        baseUri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(client.toJson()),
      )).thenAnswer((_) async => http.Response('', 201));

      bool result = await dataSource.addClient(client);

      expect(result, isTrue);
    });

    test('updateClient returns true when a client is successfully updated',
        () async {
      final client = Client(id: '1', name: 'UpdatedClient');

      when(mockHttpClient.put(
        Uri.parse("https://retoolapi.dev/$apiKey/data/1"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(client.toJson()),
      )).thenAnswer((_) async => http.Response('', 200));

      bool result = await dataSource.updateClient(client);

      expect(result, isTrue);
    });
    test('deleteClient returns true when a client is successfully deleted',
        () async {
      when(mockHttpClient.delete(
          Uri.parse("https://retoolapi.dev/$apiKey/data/1"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          })).thenAnswer((_) async => http.Response('', 200));

      bool result = await dataSource.deleteClient('1');

      expect(result, isTrue);
    });

    test('getClientById returns a client on a successful call', () async {
      when(mockHttpClient
              .get(Uri.parse("https://retoolapi.dev/$apiKey/data/1")))
          .thenAnswer(
              (_) async => http.Response('{"id":"1","name":"Client1"}', 200));

      final result = await dataSource.getClientById('1');

      expect(result, isA<Client>());
      expect(result?.name, equals('Client1'));
    });

    test('getClientByEmail returns a client on a successful call', () async {
      when(mockHttpClient.get(Uri.parse(
              "https://retoolapi.dev/$apiKey/data?email=client@example.com")))
          .thenAnswer(
              (_) async => http.Response('[{"id":"1","name":"Client1"}]', 200));

      final result = await dataSource.getClientByEmail('client@example.com');

      expect(result, isA<Client>());
      expect(result?.name, equals('Client1'));
    });
  });
}
