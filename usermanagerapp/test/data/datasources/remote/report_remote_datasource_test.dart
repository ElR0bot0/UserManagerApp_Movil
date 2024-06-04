import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:f_testing_template/data/datasources/remote/report_remote_datasource.dart';
import 'package:f_testing_template/domain/entities/report.dart';

import '../../../mocks/report_test.mocks.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ReportRemoteDataSource dataSource;
  const String apiKey = 'AgUtyU'; // Ensure apiKey is properly declared

  group('ReportRemoteDataSource Tests', () {
    final Uri reportsUri = Uri.parse("https://retoolapi.dev/$apiKey/data");
    const String reportsJson =
        '[{"id":1,"clientid":1,"usid":1,"problem":"Test Problem","desc":"Test Description","duration":"1h","rating":5,"startDate":"2024-01-01T00:00:00.000Z"},{"id":2,"clientid":2,"usid":2,"problem":"Another Problem","desc":"Another Description","duration":"2h","rating":4,"startDate":"2024-02-01T00:00:00.000Z"}]';
    final mockHttpClient = MockClient();
    dataSource = ReportRemoteDataSource(client: mockHttpClient);

    test('getAllReports returns a list of reports on a successful call',
        () async {
      when(mockHttpClient.get(reportsUri))
          .thenAnswer((_) async => http.Response(reportsJson, 200));

      final result = await dataSource.getAllReports();

      expect(result, isA<List<Report>>());
      expect(result.first.problem, equals('Test Problem'));
    });

    test('addReport returns true when a report is successfully added',
        () async {
      final report = Report(
        id: null,
        clientid: 1,
        usid: 1,
        problem: 'Test Problem',
        desc: 'Test Description',
        duration: '1h',
        rating: 5,
        startDate: DateTime.now(),
      );

      when(mockHttpClient.post(reportsUri,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', 201));

      bool result = await dataSource.uploadToApi(report);

      expect(result, isTrue);
    });

    test('updateReport returns true when a report is successfully updated',
        () async {
      final report = Report(
        id: 1,
        clientid: 1,
        usid: 1,
        problem: 'Updated Problem',
        desc: 'Updated Description',
        duration: '1h',
        rating: 5,
        startDate: DateTime.now(),
      );

      when(mockHttpClient.put(Uri.parse("https://retoolapi.dev/$apiKey/data/1"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', 200));

      bool result = await dataSource.rateReport(report);

      expect(result, isTrue);
    });

    test('deleteReport returns true when a report is successfully deleted',
        () async {
      when(mockHttpClient
              .delete(Uri.parse("https://retoolapi.dev/$apiKey/data/1")))
          .thenAnswer((_) async => http.Response('', 200));

      bool result = await dataSource.deleteReport('1');

      expect(result, isTrue);
    });
  });
}
