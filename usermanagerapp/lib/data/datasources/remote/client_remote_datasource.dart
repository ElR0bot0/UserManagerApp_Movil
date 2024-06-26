import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loggy/loggy.dart';

import '../../../domain/entities/client.dart';
import 'i_client_remote_datasource.dart';

class ClientRemoteDataSource implements IClientRemoteDataSource {
  final String baseUrl =
      'https://retoolapi.dev/MAImUm/data'; // Reemplaza con tu URL de la API
  final http.Client httpClient;

  ClientRemoteDataSource({http.Client? client})
      : httpClient = client ?? http.Client();
  @override
  Future<bool> addClient(Client client) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl'),
        body: jsonEncode(client.toJson()),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 201) {
        logInfo("Remote data source adding Client");
        return Future.value(true);
      } else {
        throw Exception(
            'Failed to add Client. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error adding Client: $error');
      throw Exception('Error adding Client: $error');
    }
  }

  @override
  Future<List<Client>> getAllClients() async {
    try {
      final response = await httpClient.get(Uri.parse('$baseUrl'));

      logInfo('GET All Clients - Response status Code: ${response.statusCode}');
      logInfo('GET All Clients - Response Body: ${response.body}');

      if (response.statusCode == 200) {
        logInfo("Remote data returning getAllClients");
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Client> clientList =
            jsonResponse.map((data) => Client.fromJson(data)).toList();
        logInfo('GET All Clients - Decoded Client List: $clientList');
        return Future.value(clientList);
      } else {
        throw Exception(
            'Failed to load Clients. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error getting all Clients: $error');
      throw Exception('Error getting all Clients: $error');
    }
  }

  @override
  Future<bool> deleteClient(String id) async {
    try {
      final response = await httpClient.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to delete Client. status code: ${response.statusCode}, Body: ${response.body}');
      }
      return Future.value(true);
    } catch (error) {
      logError('Error deleting Client: $error');
      throw Exception('Error deleting Client: $error');
    }
  }

  @override
  Future<bool> updateClient(Client clienti) async {
    try {
      final response = await httpClient.put(
        Uri.parse('$baseUrl/${clienti.id}'),
        body: jsonEncode(clienti.toJson()),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update Client. status code: ${response.statusCode}, Body: ${response.body}');
      }
      return Future.value(true);
    } catch (error) {
      logError('Error updating Client: $error');
      throw Exception('Error updating Client: $error');
    }
  }

  @override
  Future<Client?> getClientById(String id) async {
    try {
      final response = await httpClient.get(Uri.parse('$baseUrl/$id'));

      logInfo(
          'GET Client by ID - Response status Code: ${response.statusCode}');
      logInfo('GET Client by ID - Response Body: ${response.body}');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        Client? client =
            jsonResponse != null ? Client.fromJson(jsonResponse) : null;
        logInfo('GET Client by ID - Decoded Client: $client');
        return Future.value(client);
      } else {
        throw Exception(
            'Failed to get Client by ID. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error getting Client by ID: $error');
      throw Exception('Error getting Client by ID: $error');
    }
  }

  @override
  Future<Client?> getClientByEmail(String email) async {
    try {
      final response = await httpClient.get(Uri.parse('$baseUrl?email=$email'));

      logInfo(
          'GET Client by Email - Response status Code: ${response.statusCode}');
      logInfo('GET Client by Email - Response Body: ${response.body}');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        Client? client =
            jsonResponse.isNotEmpty ? Client.fromJson(jsonResponse[0]) : null;
        logInfo('GET Client by Email - Decoded Client: $client');
        return Future.value(client);
      } else {
        throw Exception(
            'Failed to get Client by Email. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error getting Client by Email: $error');
      throw Exception('Error getting Client by Email: $error');
    }
  }
}
