import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:f_testing_template/domain/use_case/ucs.dart';
import '../mocks/uc_test.mocks.mocks.dart';

void main() {
  late MockIUCRepository mockUCRepository;
  late UCs ucUseCase;

  setUp(() {
    mockUCRepository = MockIUCRepository();
    ucUseCase = UCs(mockUCRepository);
  });

  group('authenticateUC', () {
    test('should call authenticateUC on the repository with correct data',
        () async {
      // Arrange
      final String email = 'test@example.com';
      final String password = 'password123';
      when(mockUCRepository.authenticateUC(email, password))
          .thenAnswer((_) async => true);

      // Act
      bool result = await ucUseCase.authenticateUC(email, password);

      // Assert
      verify(mockUCRepository.authenticateUC(email, password)).called(1);
      expect(result, isTrue);
    });

    test('should return false on unsuccessful authentication', () async {
      // Arrange
      final String email = 'test@example.com';
      final String password = 'wrongpassword';
      when(mockUCRepository.authenticateUC(email, password))
          .thenAnswer((_) async => false);

      // Act
      bool result = await ucUseCase.authenticateUC(email, password);

      // Assert
      verify(mockUCRepository.authenticateUC(email, password)).called(1);
      expect(result, isFalse);
    });
  });
}
