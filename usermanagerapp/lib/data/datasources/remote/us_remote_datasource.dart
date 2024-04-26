import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loggy/loggy.dart';

import '../../../domain/entities/us.dart';

class USRemoteDataSource {
  final String baseUrl = 'https://retoolapi.dev/sG38Em/data'; // Reemplaza con tu URL de la API
  Future<void> addUS(US us) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl'),
        body: jsonEncode(us.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        logInfo("Remote data source adding US");
      } else {
        throw Exception('Failed to add US. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error adding US: $error');
      throw Exception('Error adding US: $error');
    }
  }

Future<List<US>> getAllUSs() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl'));

    //print('GET All USs - Response Status Code: ${response.statusCode}');
    //print('GET All USs - Response Body: ${response.body}');

    if (response.statusCode == 200) {
      //print("Remote data returning getAllUSs");
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<US> usList = jsonResponse.map((data) => US.fromJson(data)).toList();
      print('exito por fin');
      logInfo('GET All USs - Decoded US List: $usList');
      return usList;
    } else {
      throw Exception('Failed to load USs. Status code: ${response.statusCode}, Body: ${response.body}');
    }
  } catch (error) {
    logError('Error getting all USs: $error');
    throw Exception('Error getting all USs: $error');
  }
}

  Future<void> deleteUS(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete US. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error deleting US: $error');
      throw Exception('Error deleting US: $error');
    }
  }

  Future<void> updateUS(US usi) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${usi.id}'),
        body: jsonEncode(usi.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update US. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error updating US: $error');
      throw Exception('Error updating US: $error');
    }
  }

    Future<bool> authenticateUS(String email, String password) async {
    try {
        final response = await http.get(
          Uri.parse('$baseUrl?email=$email&clave=$password'),
        );

        if (response.statusCode == 200) {
          // Verificar el contenido del JSON de respuesta
          dynamic jsonResponse = json.decode(response.body);

          if (jsonResponse is List) {
            // Si el JSON de respuesta es una lista y no está vacía, retorna true
            return jsonResponse.isNotEmpty;
          } else if (jsonResponse is Map<String, dynamic>) {
            // Si el JSON de respuesta es un mapa y no está vacío, retorna true
            return jsonResponse.isNotEmpty;
          } else {
            // Si el JSON de respuesta no es ni una lista ni un mapa, retorna false
            return false;
          }
        } else {
          // Si el código de estado no es 200, retorna false
          return false;
        }
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir durante la solicitud
      print('Error: $e');
      return false;
    }
  }
  Future<US?> getUSById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      logInfo('GET US by ID - Response Status Code: ${response.statusCode}');
      logInfo('GET US by ID - Response Body: ${response.body}');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        US? us = jsonResponse != null ? US.fromJson(jsonResponse) : null;
        logInfo('GET US by ID - Decoded US: $us');
        return us;
      } else {
        throw Exception('Failed to get US by ID. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error getting US by ID: $error');
      throw Exception('Error getting US by ID: $error');
    }
  }

  Future<US?> getUSByEmail(String email) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?email=$email'));

      logInfo('GET US by Email - Response Status Code: ${response.statusCode}');
      logInfo('GET US by Email - Response Body: ${response.body}');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        US? us = jsonResponse.isNotEmpty ? US.fromJson(jsonResponse[0]) : null;
        logInfo('GET US by Email - Decoded US: $us');
        return us;
      } else {
        throw Exception('Failed to get US by Email. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error getting US by Email: $error');
      throw Exception('Error getting US by Email: $error');
    }
  }
}
