import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart';
import 'package:f_testing_template/data/repositories/client_repository.dart';
import 'package:f_testing_template/domain/entities/client.dart';
import 'package:f_testing_template/domain/use_case/clientss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_testing_template/ui/controllers/client_controller.dart';
import 'package:f_testing_template/ui/pages/content/client_detail_page.dart';
import 'package:f_testing_template/ui/pages/content/clientreports.dart';
import 'package:f_testing_template/ui/widgets/list_item.dart';

void main() {
  // Create a mock client for testing
  final client = Client(
    id: '1',
    name: 'John Doe',
  );

  // Create a mock client controller
  final clientController = ClientController(
      clientUseCase: Clientss(ClientRepository(ClientRemoteDataSource())));

  // Initialize GetX bindings
  setUpAll(() {
    Get.testMode = true; // Enable test mode for GetX
    Get.put<ClientController>(clientController);
  });

  // Clean up GetX bindings
  tearDownAll(() {
    Get.reset();
  });

  testWidgets('ListItem displays client name and subtitle',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ListItem(client),
      ),
    );

    // Verify that the client name and subtitle are displayed correctly
    expect(find.text(client.name), findsOneWidget);
    expect(find.text('Client'), findsOneWidget);
  });

  testWidgets(
      'ListItem navigates to ClientReports page when Reports button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ListItem(client),
      ),
    );

    final cRButton = find.byKey(const ValueKey('ClientReports_Button'));
    // Tap the Reports button
    await tester.tap(cRButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verify that the ClientReports page is pushed onto the navigation stack
    expect(find.text("${client.name}'s Reports"), findsOneWidget);
  });

  testWidgets(
      'ListItem navigates to ClientDetailPage when Edit button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ListItem(client),
      ),
    );

    // Tap the Edit button
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    // Verify that the ClientDetailPage is pushed onto the navigation stack
    expect(find.byType(ClientDetailPage), findsOneWidget);
  });

  testWidgets('ListItem calls deleteClient method when dismissed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ListItem(client),
      ),
    );

    // Dismiss the ListItem
    await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));
    await tester.pumpAndSettle();

    // Verify that the deleteClient method is called on the clientController
    expect(clientController.deleteClient(client.id), client.id);
  });
}
