import 'package:f_testing_template/data/repositories/us_repository.dart';
import 'package:f_testing_template/domain/entities/us.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/us_test.mocks.mocks.dart';

void main() {
  late USRepository usRepository;
  late MockIUSRemoteDataSource mockIUSRemoteDataSource;

  setUp(() {
    mockIUSRemoteDataSource = MockIUSRemoteDataSource();
    usRepository = USRepository(mockIUSRemoteDataSource);
  });

  group('USRepository Tests', () {
    test('getAllUSs should retrieve USs from the data source', () async {
      // Arrange
      when(mockIUSRemoteDataSource.getAllUSs()).thenAnswer((_) async => <US>[]);

      // Act
      var uss = await usRepository.getAllUSs();

      // Assert
      verify(mockIUSRemoteDataSource.getAllUSs()).called(1);
      expect(uss, isA<List<US>>());
    });

    test('addUS should forward the addUS call to the data source', () async {
      // Arrange
      US newUs = US(
        id: '1',
        name: 'John Doe',
        email: 'johndoe@example.com',
        password: 'password123',
        reportquantity: 1,
      );
      when(mockIUSRemoteDataSource.addUS(any)).thenAnswer((_) async => true);

      // Act
      bool result = await usRepository.addUS(newUs);

      // Assert
      verify(mockIUSRemoteDataSource.addUS(newUs)).called(1);
      expect(result, isTrue);
    });

    test('updateUS should forward the updateUS call to the data source',
        () async {
      // Arrange
      US updatedUs = US(
        id: '1',
        name: 'John Smith',
        email: 'johnsmith@example.com',
        password: 'password123',
        reportquantity: 1,
      );
      when(mockIUSRemoteDataSource.updateUS(any)).thenAnswer((_) async => true);

      // Act
      bool result = await usRepository.updateUS(updatedUs);

      // Assert
      verify(mockIUSRemoteDataSource.updateUS(updatedUs)).called(1);
      expect(result, isTrue);
    });

    test('deleteUS should forward the deleteUS call to the data source',
        () async {
      // Arrange
      String usId = '1';
      when(mockIUSRemoteDataSource.deleteUS(any)).thenAnswer((_) async => true);

      // Act
      bool result = await usRepository.deleteUS(usId);

      // Assert
      verify(mockIUSRemoteDataSource.deleteUS(usId)).called(1);
      expect(result, isTrue);
    });

    test(
        'authenticateUS should forward the authenticateUS call to the data source',
        () async {
      // Arrange
      final String email = 'test@example.com';
      final String password = 'password123';
      when(mockIUSRemoteDataSource.authenticateUS(any, any))
          .thenAnswer((_) async => true);

      // Act
      bool result = await usRepository.authenticateUS(email, password);

      // Assert
      verify(mockIUSRemoteDataSource.authenticateUS(email, password)).called(1);
      expect(result, isTrue);
    });

    test('getUSById should retrieve a US by ID from the data source', () async {
      // Arrange
      US us = US(
        id: '1',
        name: 'John Doe',
        email: 'johndoe@example.com',
        password: 'password123',
        reportquantity: 1,
      );
      when(mockIUSRemoteDataSource.getUSById(any)).thenAnswer((_) async => us);

      // Act
      var result = await usRepository.getUSById('1');

      // Assert
      verify(mockIUSRemoteDataSource.getUSById('1')).called(1);
      expect(result, isA<US>());
      expect(result?.name, equals('John Doe'));
    });

    test('getUSByEmail should retrieve a US by email from the data source',
        () async {
      // Arrange
      US us = US(
        id: '1',
        name: 'John Doe',
        email: 'johndoe@example.com',
        password: 'password123',
        reportquantity: 1,
      );
      when(mockIUSRemoteDataSource.getUSByEmail(any))
          .thenAnswer((_) async => us);

      // Act
      var result = await usRepository.getUSByEmail('johndoe@example.com');

      // Assert
      verify(mockIUSRemoteDataSource.getUSByEmail('johndoe@example.com'))
          .called(1);
      expect(result, isA<US>());
      expect(result?.name, equals('John Doe'));
    });
  });
}
