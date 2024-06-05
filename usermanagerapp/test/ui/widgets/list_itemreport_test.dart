import 'package:f_testing_template/data/datasources/remote/report_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/us_remote_datasource.dart';
import 'package:f_testing_template/data/repositories/report_repository.dart';
import 'package:f_testing_template/data/repositories/us_repository.dart';
import 'package:f_testing_template/domain/use_case/reports.dart';
import 'package:f_testing_template/domain/use_case/uss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_testing_template/ui/widgets/list_itemreport.dart';
import 'package:f_testing_template/domain/entities/report.dart';
import 'package:f_testing_template/ui/controllers/report_controller.dart';
import 'package:f_testing_template/ui/controllers/us_controller.dart';

void main() {
  // Mock Report and Controllers
  final report = Report(
      id: 1,
      problem: 'Test Problem',
      usid: 12,
      desc: '3',
      clientid: 456,
      duration: '5',
      rating: 1,
      startDate: DateTime.now());
  final reportController = ReportController(
      reportUseCase: Reportss(ReportRepository(ReportRemoteDataSource())));
  final usController =
      USController(usUseCase: USs(USRepository(USRemoteDataSource())));
  setUpAll(() {
    Get.put<ReportController>(reportController);
    Get.put(usController);
  });

  testWidgets(
      'ListItemReport navigates to ReportDetailPage when "more" button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: ListItemReport(report),
      ),
    );

    final moreButton = find.text('more');
    // Tap the "more" button
    await tester.tap(moreButton);
    await tester.pumpAndSettle();

    // Verify that the ReportDetailPage is pushed onto the navigation stack
    expect(find.byKey(const Key('ReportDetailPage')), findsOneWidget);
    // Verify the report problem is shown correctly
    expect(find.text(report.problem), findsOneWidget);
  });
}
