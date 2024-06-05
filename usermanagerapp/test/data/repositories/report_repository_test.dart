import 'package:f_testing_template/data/repositories/report_repository.dart';
import 'package:f_testing_template/domain/entities/report.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/report_test.mocks.mocks.dart';

void main() {
  late ReportRepository reportRepository;
  late MockIReportRemoteDataSource mockReportRemoteDataSource;

  setUp(() {
    mockReportRemoteDataSource = MockIReportRemoteDataSource();
    reportRepository = ReportRepository(mockReportRemoteDataSource);
  });

  group('ReportRepository Tests', () {
    test('getAllReports should retrieve reports from the data source',
        () async {
      // Arrange
      when(mockReportRemoteDataSource.getAllReports())
          .thenAnswer((_) async => <Report>[]);

      // Act
      var reports = await reportRepository.getAllReports();

      // Assert
      verify(mockReportRemoteDataSource.getAllReports()).called(1);
      expect(reports, isA<List<Report>>());
    });

    test('addReport should forward the addReport call to the data source',
        () async {
      // Arrange
      Report newReport = Report(
        id: 1,
        clientid: 1,
        usid: 1,
        problem: 'Test Problem',
        desc: 'Test Description',
        duration: '1h',
        rating: 5,
        startDate: DateTime.now(),
      );
      when(mockReportRemoteDataSource.addReport(any, any))
          .thenAnswer((_) async => true);

      // Act
      bool result = await reportRepository.addReport(newReport, 1);

      // Assert
      verify(mockReportRemoteDataSource.addReport(newReport, 1)).called(1);
      expect(result, isTrue);
    });

    test('rateReport should forward the rateReport call to the data source',
        () async {
      // Arrange
      Report updatedReport = Report(
        id: 1,
        clientid: 1,
        usid: 1,
        problem: 'Updated Problem',
        desc: 'Updated Description',
        duration: '1h',
        rating: 5,
        startDate: DateTime.now(),
      );
      when(mockReportRemoteDataSource.rateReport(any))
          .thenAnswer((_) async => true);

      // Act
      bool result = await reportRepository.rateReport(updatedReport);

      // Assert
      verify(mockReportRemoteDataSource.rateReport(updatedReport)).called(1);
      expect(result, isTrue);
    });

    test('deleteReport should forward the deleteReport call to the data source',
        () async {
      // Arrange
      String reportId = '1';
      when(mockReportRemoteDataSource.deleteReport(any))
          .thenAnswer((_) async => true);

      // Act
      bool result = await reportRepository.deleteReport(reportId);

      // Assert
      verify(mockReportRemoteDataSource.deleteReport(reportId)).called(1);
      expect(result, isTrue);
    });
  });
}
