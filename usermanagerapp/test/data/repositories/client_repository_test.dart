import 'package:f_testing_template/data/repositories/client_repository.dart';
import 'package:f_testing_template/domain/entities/client.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/client_test.mocks.mocks.dart';

void main() {
  late ClientRepository clientRepository;
  late MockIClientRemoteDataSource mockClientRemoteDataSource;

  setUp(() {
    mockClientRemoteDataSource = MockIClientRemoteDataSource();
    clientRepository = ClientRepository(mockClientRemoteDataSource);
  });

  group('ClientRepository Tests', () {
    test('getAllClients should retrieve clients from the data source',
        () async {
      // Arrange
      when(mockClientRemoteDataSource.getAllClients())
          .thenAnswer((_) async => <Client>[]);

      // Act
      var clients = await clientRepository.getAllClients();

      // Assert
      verify(mockClientRemoteDataSource.getAllClients()).called(1);
      expect(clients, isA<List<Client>>());
    });

    test('addClient should forward the addClient call to the data source',
        () async {
      // Arrange
      Client newClient = Client(id: '1', name: 'Client1');
      when(mockClientRemoteDataSource.addClient(any))
          .thenAnswer((_) async => true);

      // Act
      bool result = await clientRepository.addClient(newClient);

      // Assert
      verify(mockClientRemoteDataSource.addClient(newClient)).called(1);
      expect(result, isTrue);
    });

    test('updateClient should forward the updateClient call to the data source',
        () async {
      // Arrange
      Client updatedClient = Client(id: '1', name: 'UpdatedClient');
      when(mockClientRemoteDataSource.updateClient(any))
          .thenAnswer((_) async => true);

      // Act
      bool result = await clientRepository.updateClient(updatedClient);

      // Assert
      verify(mockClientRemoteDataSource.updateClient(updatedClient)).called(1);
      expect(result, isTrue);
    });

    test('deleteClient should forward the deleteClient call to the data source',
        () async {
      // Arrange
      String clientId = '1';
      when(mockClientRemoteDataSource.deleteClient(any))
          .thenAnswer((_) async => true);

      // Act
      bool result = await clientRepository.deleteClient(clientId);

      // Assert
      verify(mockClientRemoteDataSource.deleteClient(clientId)).called(1);
      expect(result, isTrue);
    });

    test('getClientById should retrieve a client by ID from the data source',
        () async {
      // Arrange
      Client client = Client(id: '1', name: 'Client1');
      when(mockClientRemoteDataSource.getClientById(any))
          .thenAnswer((_) async => client);

      // Act
      var result = await clientRepository.getClientById('1');

      // Assert
      verify(mockClientRemoteDataSource.getClientById('1')).called(1);
      expect(result, isA<Client>());
      expect(result?.name, equals('Client1'));
    });

    test(
        'getClientByEmail should retrieve a client by email from the data source',
        () async {
      // Arrange
      Client client = Client(id: '1', name: 'Client1');
      when(mockClientRemoteDataSource.getClientByEmail(any))
          .thenAnswer((_) async => client);

      // Act
      var result =
          await clientRepository.getClientByEmail('client@example.com');

      // Assert
      verify(mockClientRemoteDataSource.getClientByEmail('client@example.com'))
          .called(1);
      expect(result, isA<Client>());
      expect(result?.name, equals('Client1'));
    });
  });
}
