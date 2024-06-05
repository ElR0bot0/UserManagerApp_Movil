import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/report_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/us_remote_datasource.dart';
import 'package:f_testing_template/data/repositories/client_repository.dart';
import 'package:f_testing_template/data/repositories/report_repository.dart';
import 'package:f_testing_template/data/repositories/us_repository.dart';
import 'package:f_testing_template/domain/use_case/clientss.dart';
import 'package:f_testing_template/domain/use_case/reports.dart';
import 'package:f_testing_template/domain/use_case/uss.dart';
import 'package:f_testing_template/ui/controllers/report_controller.dart';
import 'package:f_testing_template/ui/controllers/us_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_testing_template/ui/pages/authentication/createclient.dart';
import 'package:f_testing_template/ui/controllers/client_controller.dart';

void main() {
  // Create a mock client controller
  final clientController = ClientController(
      clientUseCase: Clientss(ClientRepository(ClientRemoteDataSource())));
  final USController usController =
      USController(usUseCase: USs(USRepository(USRemoteDataSource())));
  final reportController = ReportController(
      reportUseCase: Reportss(ReportRepository(ReportRemoteDataSource())));

  setUpAll(() {
    Get.put<ClientController>(clientController);
    Get.put<USController>(usController);
    Get.put<ReportController>(reportController);
  });

  testWidgets(
      'CreateClient page navigates back to HomePageUC when back button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: CreateClient(),
      ),
    );

    final backButton = find.byKey(const Key('BackButton'));
    // Tap the back button
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Verify that the HomePageUC is pushed onto the navigation stack
    expect(find.byKey(const Key('HomePageUC')), findsOneWidget);
  });
}
