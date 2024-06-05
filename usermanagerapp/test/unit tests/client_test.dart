import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:f_testing_template/domain/use_case/clientss.dart';
import 'package:f_testing_template/domain/entities/client.dart';
import '../mocks/client_test.mocks.mocks.dart';

void main() {
  late MockIClientRepository mockClientRepository;
  late Clientss clientUseCase;

  setUp(() {
    mockClientRepository = MockIClientRepository();
    clientUseCase = Clientss(mockClientRepository);
  });

  group('getAllClients', () {
    test('should call getAllClients on the repository', () async {
      // Arrange
      when(mockClientRepository.getAllClients())
          .thenAnswer((_) async => <Client>[]);

      // Act
      await clientUseCase.getAllClients();

      // Assert
      verify(mockClientRepository.getAllClients()).called(1);
    });
  });

  group('addClient', () {
    test('should call addClient on the repository with correct data', () async {
      // Arrange
      Client dummyClient = Client(id: '1', name: 'Client1');
      when(mockClientRepository.addClient(dummyClient))
          .thenAnswer((_) async => true);

      // Act
      await clientUseCase.addClient(dummyClient);

      // Assert
      verify(mockClientRepository.addClient(dummyClient)).called(1);
    });
  });

  group('updateClient', () {
    test('should call updateClient on the repository with correct data',
        () async {
      // Arrange
      Client dummyClient = Client(id: '1', name: 'UpdatedClient');
      when(mockClientRepository.updateClient(dummyClient))
          .thenAnswer((_) async => true);

      // Act
      await clientUseCase.updateClient(dummyClient);

      // Assert
      verify(mockClientRepository.updateClient(dummyClient)).called(1);
    });
  });

  group('deleteClient', () {
    test('should return true on successful deletion', () async {
      // Arrange
      String clientId = '1';
      when(mockClientRepository.deleteClient(clientId))
          .thenAnswer((_) async => true);

      // Act
      bool result = await clientUseCase.deleteClient(clientId);

      // Assert
      verify(mockClientRepository.deleteClient(clientId)).called(1);
      expect(result, isTrue);
    });
  });

  group('getClientById', () {
    test('should call getClientById on the repository with correct data',
        () async {
      // Arrange
      String clientId = '1';
      Client dummyClient = Client(id: '1', name: 'Client1');
      when(mockClientRepository.getClientById(clientId))
          .thenAnswer((_) async => dummyClient);

      // Act
      var result = await clientUseCase.getClientById(clientId);

      // Assert
      verify(mockClientRepository.getClientById(clientId)).called(1);
      expect(result, isA<Client>());
      expect(result?.name, equals('Client1'));
    });
  });

  group('getClientByEmail', () {
    test('should call getClientByEmail on the repository with correct data',
        () async {
      // Arrange
      String email = 'client@example.com';
      Client dummyClient = Client(id: '1', name: 'Client1');
      when(mockClientRepository.getClientByEmail(email))
          .thenAnswer((_) async => dummyClient);

      // Act
      var result = await clientUseCase.getClientByEmail(email);

      // Assert
      verify(mockClientRepository.getClientByEmail(email)).called(1);
      expect(result, isA<Client>());
      expect(result?.name, equals('Client1'));
    });
  });
}
