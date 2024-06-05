import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/report_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/us_remote_datasource.dart';
import 'package:f_testing_template/data/repositories/client_repository.dart';
import 'package:f_testing_template/data/repositories/report_repository.dart';
import 'package:f_testing_template/data/repositories/us_repository.dart';
import 'package:f_testing_template/domain/use_case/clientss.dart';
import 'package:f_testing_template/domain/use_case/reports.dart';
import 'package:f_testing_template/domain/use_case/uss.dart';
import 'package:f_testing_template/ui/controllers/client_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_testing_template/ui/pages/authentication/CreateUS.dart';
import 'package:f_testing_template/ui/controllers/us_controller.dart';
import 'package:f_testing_template/ui/controllers/report_controller.dart';

void main() {
  // Mock USController and ReportController
  final usController =
      USController(usUseCase: USs(USRepository(USRemoteDataSource())));
  final reportController = ReportController(
      reportUseCase: Reportss(ReportRepository(ReportRemoteDataSource())));
  final clientController = ClientController(
      clientUseCase: Clientss(ClientRepository(ClientRemoteDataSource())));

  setUpAll(() {
    Get.put<USController>(usController);
    Get.put<ReportController>(reportController);
    Get.put<ClientController>(clientController);
  });

  group('CreateUS Page Navigation Tests', () {
    testWidgets(
        'CreateUS page navigates back to HomePageUC when back button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: CreateUS(),
        ),
      );

      final backButton = find.byType(IconButton);
      // Tap the back button
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Verify that the HomePageUC is pushed onto the navigation stack
      expect(find.byKey(const Key('HomePageUC')), findsOneWidget);
    });
  });
}
