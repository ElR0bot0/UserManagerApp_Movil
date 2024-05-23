import 'dart:convert';
import 'package:http/http.dart' as http;

import 'i_uc_remote_datasource.dart';

class UCRemoteDatasource implements IUCRemoteDatasource{

  @override
  Future<bool> authenticateUC(String email, String password) async {
    const String apiUrl = 'https://retoolapi.dev/Nlayzp/data/';

    try {
        final response = await http.get(
          Uri.parse('$apiUrl?email=$email&clave=$password'),
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
      return false;
    }
  }
}




