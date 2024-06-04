import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart';
import 'package:f_testing_template/domain/entities/client.dart';

void main() {
  late ClientRemoteDataSource
      dataSource; // Declared as late, initialized in setUp
  late http.Client httpClient; // Declared as late, initialized in setUp
  late Client newClient; // Client without an ID yet

  setUp(() {
    httpClient = http.Client();
    dataSource = ClientRemoteDataSource(client: httpClient);
    newClient = Client(
      id: '5',
      name: 'Test Client',
    );
  });

  tearDown(() {
    httpClient.close(); // Close the client to clean up resources
  });

  test('Create, Retrieve, Update, and Delete an entry', () async {
    // Step 1: Create an entry
    bool createResult = await dataSource.addClient(newClient);
    expect(createResult, isTrue);

    // Step 2: Retrieve the client to get the ID
    List<Client> clients = await dataSource.getAllClients();
    // Using firstWhere with orElse to handle the case where no client is found
    Client? createdClient =
        clients.firstWhereOrNull((client) => client.name == newClient.name);

    // Check if the client was indeed found
    expect(createdClient, isNotNull);

    // Step 3: Update the entry
    createdClient!.name =
        'Updated Client'; // Safe because createdClient is not null here
    bool updateResult = await dataSource.updateClient(createdClient);
    expect(updateResult, isTrue);

    // Step 4: Delete the entry
    bool deleteResult = await dataSource
        .deleteClient(createdClient.id); // Assert non-null ID with '!'
    expect(deleteResult, isTrue);
  });
}
