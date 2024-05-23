import 'package:collection/collection.dart';
import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart';
import 'package:f_testing_template/domain/entities/client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  late ClientRemoteDataSource
      dataSource; // Declared as late, initialized in setUp
  late http.Client httpClient; // Declared as late, initialized in setUp
  late Client newClient; // User without an ID yet

  setUp(() {
    httpClient = http.Client();
    dataSource = ClientRemoteDataSource();
    newClient = Client(id: "1", name: 'Jane');
  });

  tearDown(() {
    httpClient.close(); // Close the client to clean up resources
  });

  test('Create, Retrieve, Update, and Delete an entry', () async {
    // Step 1: Create an entry
    bool createResult = await dataSource.addClient(newClient);
    expect(createResult, isTrue);

    // Step 2: Retrieve the user to get the ID
    List<Client> users = await dataSource.getAllClients();
    // Using firstWhere with orElse to handle the case where no user is found
    Client? createdclient =
        users.firstWhereOrNull((user) => user.id == newClient.id);

    // // Check if the user was indeed found
    expect(createdclient, isNotNull);

    // // Step 3: Update the entry
    createdclient!.name =
        'Updated'; // Safe because createdUser is not null here
    bool updateResult = await dataSource.updateClient(createdclient);
    expect(updateResult, isTrue);
    // Step 4: Delete the entry
    bool deleteResult = await dataSource
        .deleteClient(createdclient.id); // Assert non-null ID with '!'
    expect(deleteResult, isTrue);
  });
}
