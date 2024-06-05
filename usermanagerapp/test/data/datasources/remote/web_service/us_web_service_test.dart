import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:f_testing_template/data/datasources/remote/us_remote_datasource.dart';
import 'package:f_testing_template/domain/entities/us.dart';

void main() {
  late USRemoteDataSource dataSource; // Declared as late, initialized in setUp
  late http.Client httpClient; // Declared as late, initialized in setUp
  late US newUser; // US without an ID yet

  setUp(() {
    httpClient = http.Client();
    dataSource = USRemoteDataSource(client: httpClient);
    newUser = US(
      id: '1',
      name: 'Test User',
      email: 'test.user@example.com',
      password: 'password123',
      reportquantity: 0,
      ratings: [],
      avgrating: 0.0,
    );
  });

  tearDown(() {
    httpClient.close(); // Close the client to clean up resources
  });

  test('Create, Retrieve, Update, and Delete an entry', () async {
    // Step 1: Create an entry
    bool createResult = await dataSource.addUS(newUser);
    expect(createResult, isTrue);

    // Step 2: Retrieve the user to get the ID
    List<US> users = await dataSource.getAllUSs();
    // Using firstWhere with orElse to handle the case where no user is found
    US? createdUser =
        users.firstWhereOrNull((user) => user.email == newUser.email);

    // Check if the user was indeed found
    expect(createdUser, isNotNull);

    // Step 3: Update the entry
    createdUser!.name =
        'Updated User'; // Safe because createdUser is not null here
    bool updateResult = await dataSource.updateUS(createdUser);
    expect(updateResult, isTrue);

    // Step 4: Delete the entry
    bool deleteResult = await dataSource
        .deleteUS(createdUser.id); // Assert non-null ID with '!'
    expect(deleteResult, isTrue);
  });
}
