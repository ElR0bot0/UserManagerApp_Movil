import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/entities/report.dart';
import '../local/report_local_datasource.dart';
import 'i_report_remote_datasource.dart';

class ReportRemoteDataSource implements IReportRemoteDataSource {
  final String baseUrl =
      'https://retoolapi.dev/AgUtyU/data'; // Reemplaza con tu URL de la API
  final http.Client httpClient;

  ReportRemoteDataSource({http.Client? client})
      : httpClient = client ?? http.Client();
  @override
  Future<bool> addReport(Report report, int status) async {
    try {
      if (status == 0) {
        await savePendingRecord(report);
        print('status 0');
      } else if (status == 1) {
        await uploadToApi(report);
        print('status 1');
      } else {
        await uploadPendingRecords(report);
        print('status 2');
      }
      return Future.value(true);
    } catch (error) {
      print('Error adding Report: $error');
      throw Exception('Error adding Report: $error');
    }
  }

  @override
  Future<List<Report>> getAllReports() async {
    try {
      final response = await httpClient.get(Uri.parse('$baseUrl'));

      logInfo('GET All Reports - Response status Code: ${response.statusCode}');
      logInfo('GET All Reports - Response Body: ${response.body}');

      if (response.statusCode == 200) {
        logInfo("Remote data returning getAllReports");
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Report> reportList =
            jsonResponse.map((data) => Report.fromJson(data)).toList();
        logInfo('GET All Reports - Decoded Report List: $reportList');
        return Future.value(reportList);
      } else {
        throw Exception(
            'Failed to load Reports. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error getting all Reports: $error');
      throw Exception('Error getting all Reports: $error');
    }
  }

  @override
  Future<bool> deleteReport(String id) async {
    try {
      final response = await httpClient.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to delete Report. status code: ${response.statusCode}, Body: ${response.body}');
      }
      return Future.value(true);
    } catch (error) {
      logError('Error deleting Report: $error');
      throw Exception('Error deleting Repor: $error');
    }
  }

  @override
  Future<bool> rateReport(Report reporti) async {
    try {
      final response = await httpClient.put(
        Uri.parse('$baseUrl/${reporti.id}'),
        body: jsonEncode(reporti.toJson()),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update Report. status code: ${response.statusCode}, Body: ${response.body}');
      }
      return Future.value(true);
    } catch (error) {
      logError('Error updating Report: $error');
      throw Exception('Error updating Report: $error');
    }
  }

  @override
  Future<bool> uploadToApi(Report report) async {
    try {
      final response = await httpClient.post(
        Uri.parse(baseUrl),
        body: jsonEncode(report.toJson()),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        logInfo("Remote data source adding Report");
        return Future.value(true);
      } else {
        throw Exception(
            'Failed to add Report. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      print('Error uploading Report: $error');
      throw Exception('Error uploading Report: $error');
    }
  }

  @override
  Future<void> savePendingRecord(Report report) async {
    try {
      final dbHelper = DatabaseHelper();
      await dbHelper.insertReport(
          report); // Insertar el informe en la base de datos SQLite
    } catch (e) {
      // Manejar errores, si es necesario
      print('Error saving Report in db: $e');
    }
  }

  @override
  Future<void> uploadPendingRecords(Report a) async {
    try {
      final dbHelper = DatabaseHelper();
      List<Report> pendingReports = await dbHelper
          .getReports(); // Obtener los informes pendientes de la base de datos SQLite
      if (pendingReports.isNotEmpty) {
        for (var report in pendingReports) {
          if (report.usid == a.usid) {
            await uploadToApi(report); // Subir el informe a la API
            await dbHelper.deleteReport(report
                .id!); // Eliminar el informe de la base de datos después de subirlo
          }
        }
      }
    } catch (e) {
      // Manejar errores, si es necesario
      print('Error uploading Report: $e');
    }
  }
}
