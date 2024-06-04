import 'package:f_testing_template/data/repositories/uc_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/uc_test.mocks.mocks.dart';

void main() {
  late UCRepository ucRepository;
  late MockIUCRemoteDatasource mockUcRemoteDatasource;

  setUp(() {
    mockUcRemoteDatasource = MockIUCRemoteDatasource();
    ucRepository = UCRepository(mockUcRemoteDatasource);
  });

  group('UCRepository Tests', () {
    test(
        'authenticateUC should forward the authenticateUC call to the data source',
        () async {
      // Arrange
      final String email = 'test@example.com';
      final String password = 'password123';
      when(mockUcRemoteDatasource.authenticateUC(any, any))
          .thenAnswer((_) async => true);

      // Act
      bool result = await ucRepository.authenticateUC(email, password);

      // Assert
      verify(mockUcRemoteDatasource.authenticateUC(email, password)).called(1);
      expect(result, isTrue);
    });

    test('authenticateUC should return false when authentication fails',
        () async {
      // Arrange
      final String email = 'test@example.com';
      final String password = 'wrongpassword';
      when(mockUcRemoteDatasource.authenticateUC(any, any))
          .thenAnswer((_) async => false);

      // Act
      bool result = await ucRepository.authenticateUC(email, password);

      // Assert
      verify(mockUcRemoteDatasource.authenticateUC(email, password)).called(1);
      expect(result, isFalse);
    });
  });
}
