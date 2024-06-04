import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:f_testing_template/domain/use_case/reports.dart';
import 'package:f_testing_template/domain/entities/report.dart';
import '../mocks/report_test.mocks.mocks.dart';

void main() {
  late MockIReportRepository mockReportRepository;
  late Reportss reportUseCase;

  setUp(() {
    mockReportRepository = MockIReportRepository();
    reportUseCase = Reportss(mockReportRepository);
  });

  group('getAllReports', () {
    test('should call getAllReports on the repository', () async {
      // Arrange
      when(mockReportRepository.getAllReports())
          .thenAnswer((_) async => <Report>[]);

      // Act
      await reportUseCase.getAllReports();

      // Assert
      verify(mockReportRepository.getAllReports()).called(1);
    });
  });

  group('addReport', () {
    test('should call addReport on the repository with correct data', () async {
      // Arrange
      Report dummyReport = Report(
        id: 1,
        clientid: 1,
        usid: 1,
        problem: 'Test Problem',
        desc: 'Test Description',
        duration: '1h',
        rating: 5,
        startDate: DateTime.now(),
      );
      int status = 1;
      when(mockReportRepository.addReport(dummyReport, status))
          .thenAnswer((_) async => true);

      // Act
      await reportUseCase.addReport(dummyReport, status);

      // Assert
      verify(mockReportRepository.addReport(dummyReport, status)).called(1);
    });
  });

  group('rateReport', () {
    test('should call rateReport on the repository with correct data',
        () async {
      // Arrange
      Report dummyReport = Report(
        id: 1,
        clientid: 1,
        usid: 1,
        problem: 'Updated Problem',
        desc: 'Updated Description',
        duration: '1h',
        rating: 5,
        startDate: DateTime.now(),
      );
      when(mockReportRepository.rateReport(dummyReport))
          .thenAnswer((_) async => true);

      // Act
      await reportUseCase.rateReport(dummyReport);

      // Assert
      verify(mockReportRepository.rateReport(dummyReport)).called(1);
    });
  });

  group('deleteReport', () {
    test('should return true on successful deletion', () async {
      // Arrange
      String reportId = '1';
      when(mockReportRepository.deleteReport(reportId))
          .thenAnswer((_) async => true);

      // Act
      bool result = await reportUseCase.deleteReport(reportId);

      // Assert
      verify(mockReportRepository.deleteReport(reportId)).called(1);
      expect(result, isTrue);
    });
  });
}
