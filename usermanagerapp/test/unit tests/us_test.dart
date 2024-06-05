import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:f_testing_template/domain/use_case/uss.dart';
import 'package:f_testing_template/domain/entities/us.dart';
import '../mocks/us_test.mocks.mocks.dart';

void main() {
  late MockIUSRepository mockUSRepository;
  late USs usUseCase;

  setUp(() {
    mockUSRepository = MockIUSRepository();
    usUseCase = USs(mockUSRepository);
  });

  group('getAllUSs', () {
    test('should call getAllUSs on the repository', () async {
      // Arrange
      when(mockUSRepository.getAllUSs()).thenAnswer((_) async => <US>[]);

      // Act
      await usUseCase.getAllUSs();

      // Assert
      verify(mockUSRepository.getAllUSs()).called(1);
    });
  });

  group('addUS', () {
    test('should call addUS on the repository with correct data', () async {
      // Arrange
      US dummyUS = US(
        id: '1',
        name: 'John Doe',
        email: 'johndoe@example.com',
        password: 'password123',
        reportquantity: 1,
      );
      when(mockUSRepository.addUS(dummyUS)).thenAnswer((_) async => true);

      // Act
      await usUseCase.addUS(dummyUS);

      // Assert
      verify(mockUSRepository.addUS(dummyUS)).called(1);
    });
  });

  group('updateUS', () {
    test('should call updateUS on the repository with correct data', () async {
      // Arrange
      US dummyUS = US(
        id: '1',
        name: 'John Smith',
        email: 'johnsmith@example.com',
        password: 'password123',
        reportquantity: 1,
      );
      when(mockUSRepository.updateUS(dummyUS)).thenAnswer((_) async => true);

      // Act
      await usUseCase.updateUS(dummyUS);

      // Assert
      verify(mockUSRepository.updateUS(dummyUS)).called(1);
    });
  });

  group('deleteUS', () {
    test('should return true on successful deletion', () async {
      // Arrange
      String usId = '1';
      when(mockUSRepository.deleteUS(usId)).thenAnswer((_) async => true);

      // Act
      bool result = await usUseCase.deleteUS(usId);

      // Assert
      verify(mockUSRepository.deleteUS(usId)).called(1);
      expect(result, isTrue);
    });
  });

  group('authenticateUS', () {
    test('should call authenticateUS on the repository with correct data',
        () async {
      // Arrange
      final String email = 'test@example.com';
      final String password = 'password123';
      when(mockUSRepository.authenticateUS(email, password))
          .thenAnswer((_) async => true);

      // Act
      bool result = await usUseCase.authenticateUS(email, password);

      // Assert
      verify(mockUSRepository.authenticateUS(email, password)).called(1);
      expect(result, isTrue);
    });

    test('should return false on unsuccessful authentication', () async {
      // Arrange
      final String email = 'test@example.com';
      final String password = 'wrongpassword';
      when(mockUSRepository.authenticateUS(email, password))
          .thenAnswer((_) async => false);

      // Act
      bool result = await usUseCase.authenticateUS(email, password);

      // Assert
      verify(mockUSRepository.authenticateUS(email, password)).called(1);
      expect(result, isFalse);
    });
  });

  group('getUSById', () {
    test('should call getUSById on the repository with correct data', () async {
      // Arrange
      String usId = '1';
      US dummyUS = US(
        id: '1',
        name: 'John Doe',
        email: 'johndoe@example.com',
        password: 'password123',
        reportquantity: 1,
      );
      when(mockUSRepository.getUSById(usId)).thenAnswer((_) async => dummyUS);

      // Act
      var result = await usUseCase.getUSById(usId);

      // Assert
      verify(mockUSRepository.getUSById(usId)).called(1);
      expect(result, isA<US>());
      expect(result?.name, equals('John Doe'));
    });
  });
}
