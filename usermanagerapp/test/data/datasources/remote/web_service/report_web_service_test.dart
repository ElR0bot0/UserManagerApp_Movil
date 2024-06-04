import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:f_testing_template/data/datasources/remote/report_remote_datasource.dart';
import 'package:f_testing_template/domain/entities/report.dart';

void main() {
  late ReportRemoteDataSource
      dataSource; // Declared as late, initialized in setUp
  late http.Client httpClient; // Declared as late, initialized in setUp
  late Report newReport; // Report without an ID yet

  setUp(() {
    httpClient = http.Client();
    dataSource = ReportRemoteDataSource(client: httpClient);
    newReport = Report(
      id: 5,
      clientid: 1,
      usid: 1,
      problem: 'Test Problem',
      desc: 'Test Description',
      duration: '1h',
      rating: 5,
      startDate: DateTime.now(),
    );
  });

  tearDown(() {
    httpClient.close(); // Close the client to clean up resources
  });

  test('Create, Retrieve, Update, and Delete an entry', () async {
    // Step 1: Create an entry
    await dataSource.uploadToApi(newReport);

    // Step 2: Retrieve the report to get the ID
    List<Report> reports = await dataSource.getAllReports();
    // Using firstWhere with orElse to handle the case where no report is found
    Report? createdReport = reports
        .firstWhereOrNull((report) => report.problem == newReport.problem);

    // Check if the report was indeed found
    expect(createdReport, isNotNull);

    // Step 3: Update the entry
    createdReport!.problem =
        'Updated Problem'; // Safe because createdReport is not null here
    bool updateResult = await dataSource.rateReport(createdReport);
    expect(updateResult, isTrue);

    // Step 4: Delete the entry
    bool deleteResult = await dataSource.deleteReport(
        createdReport.id.toString()); // Assert non-null ID with '!'
    expect(deleteResult, isTrue);
  });
}
