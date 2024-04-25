import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loggy/loggy.dart';

import '../../../domain/entities/report.dart';

class ReportRemoteDataSource {
  final String baseUrl = 'https://retoolapi.dev/AgUtyU/data'; // Reemplaza con tu URL de la API
  static int globalId = 1;
  
  Future<void> addReport(Report report) async {
    try {
      report.id = globalId;
      globalId++;
      final response = await http.post(
        Uri.parse('$baseUrl'),
        body: jsonEncode(report.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        logInfo("Remote data source adding Report");
      } else {
        throw Exception('Failed to add Report. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error adding Report: $error');
      throw Exception('Error adding Report: $error');
    }
  }

Future<List<Report>> getAllReports() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl'));

    logInfo('GET All Reports - Response status Code: ${response.statusCode}');
    logInfo('GET All Reports - Response Body: ${response.body}');

    if (response.statusCode == 200) {
      logInfo("Remote data returning getAllReports");
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Report> reportList = jsonResponse.map((data) => Report.fromJson(data)).toList();
      logInfo('GET All Reports - Decoded Report List: $reportList');
      return reportList;
    } else {
      throw Exception('Failed to load Reports. status code: ${response.statusCode}, Body: ${response.body}');
    }
  } catch (error) {
    logError('Error getting all Reports: $error');
    throw Exception('Error getting all Reports: $error');
  }
}

  Future<void> deleteReport(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete Report. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error deleting Report: $error');
      throw Exception('Error deleting Repor: $error');
    }
  }



  Future<void> rateReport(Report reporti) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${reporti.id}'),
        body: jsonEncode(reporti.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update Report. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error updating Report: $error');
      throw Exception('Error updating Report: $error');
    }
  }
}
