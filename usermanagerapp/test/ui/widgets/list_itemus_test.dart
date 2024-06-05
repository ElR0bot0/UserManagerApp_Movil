import 'package:f_testing_template/data/datasources/remote/report_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/us_remote_datasource.dart';
import 'package:f_testing_template/data/repositories/report_repository.dart';
import 'package:f_testing_template/data/repositories/us_repository.dart';
import 'package:f_testing_template/domain/use_case/reports.dart';
import 'package:f_testing_template/domain/use_case/uss.dart';
import 'package:f_testing_template/ui/controllers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_testing_template/ui/widgets/list_itemus.dart';
import 'package:f_testing_template/domain/entities/us.dart';
import 'package:f_testing_template/ui/controllers/us_controller.dart';

void main() {
  // Mock US and Controller
  final us = US(
      id: '1',
      name: 'Test User',
      email: 'test@example.com',
      password: 'password',
      reportquantity: 5);
  final usController =
      USController(usUseCase: USs(USRepository(USRemoteDataSource())));

  final reportUseCase = Reportss(ReportRepository(ReportRemoteDataSource()));
  setUpAll(() {
    Get.put<USController>(usController);
    Get.put(ReportController(reportUseCase: reportUseCase));
  });

  testWidgets(
      'ListItemUS navigates to USReports when "Reports" button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: ListItemUS(us),
      ),
    );

    final reportsButton = find.text('Reports');
    // Tap the "Reports" button
    await tester.tap(reportsButton);
    await tester.pumpAndSettle();

    // Verify that the USReports page is pushed onto the navigation stack
    expect(find.byKey(const Key('USReports')), findsOneWidget);
  });
}
