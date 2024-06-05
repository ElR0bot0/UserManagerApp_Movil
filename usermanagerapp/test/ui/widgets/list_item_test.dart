import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/report_remote_datasource.dart';
import 'package:f_testing_template/data/repositories/client_repository.dart';
import 'package:f_testing_template/data/repositories/report_repository.dart';
import 'package:f_testing_template/domain/entities/client.dart';
import 'package:f_testing_template/domain/use_case/clientss.dart';
import 'package:f_testing_template/domain/use_case/reports.dart';
import 'package:f_testing_template/ui/controllers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_testing_template/ui/controllers/client_controller.dart';
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
  final reportUseCase = Reportss(ReportRepository(ReportRemoteDataSource()));
  // Initialize GetX bindings
  setUpAll(() {
    Get.testMode = true; // Enable test mode for GetX
    Get.put<ClientController>(clientController);
    Get.put(ReportController(reportUseCase: reportUseCase));
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
      GetMaterialApp(
        home: ListItem(client),
      ),
    );

    final cRButton = find.byKey(const ValueKey('ClientReports_Button'));
    // Tap the Reports button
    await tester.tap(cRButton);
    await tester.pumpAndSettle();

    // Verify that the ClientReports page is pushed onto the navigation stack
    expect(find.byKey(const Key('ClientReports')), findsOneWidget);
  });

  testWidgets(
      'ListItem navigates to ClientDetailPage when Edit button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: ListItem(client),
      ),
    );

    final cDButton = find.byKey(const ValueKey('ClientDetail_Button'));
    // Tap the Edit button
    await tester.tap(cDButton);
    await tester.pumpAndSettle();

    // Verify that the ClientDetailPage is pushed onto the navigation stack
    expect(find.byKey(const Key('ClientDetailPage')), findsOneWidget);
  });
}
