import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/report_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/uc_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/us_remote_datasource.dart';
import 'package:f_testing_template/data/repositories/client_repository.dart';
import 'package:f_testing_template/data/repositories/report_repository.dart';
import 'package:f_testing_template/data/repositories/uc_repository.dart';
import 'package:f_testing_template/data/repositories/us_repository.dart';
import 'package:f_testing_template/domain/use_case/clientss.dart';
import 'package:f_testing_template/domain/use_case/reports.dart';
import 'package:f_testing_template/domain/use_case/ucs.dart';
import 'package:f_testing_template/domain/use_case/uss.dart';
import 'package:f_testing_template/ui/controllers/client_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_testing_template/ui/pages/authentication/login.dart';
import 'package:f_testing_template/ui/controllers/uc_controller.dart';
import 'package:f_testing_template/ui/controllers/us_controller.dart';
import 'package:f_testing_template/ui/controllers/report_controller.dart';
import 'package:mockito/mockito.dart';

void main() {
  // Mock UCController, USController, and ReportController
  final ucController =
      UCController(ucUseCase: UCs(UCRepository(UCRemoteDatasource())));
  final usController =
      USController(usUseCase: USs(USRepository(USRemoteDataSource())));
  final reportController = ReportController(
      reportUseCase: Reportss(ReportRepository(ReportRemoteDataSource())));
  final clientController = ClientController(
      clientUseCase: Clientss(ClientRepository(ClientRemoteDataSource())));

  setUpAll(() {
    Get.put<UCController>(ucController);
    Get.put<USController>(usController);
    Get.put<ReportController>(reportController);
    Get.put<ClientController>(clientController);
  });

  group('LoginScreen Page Navigation Tests', () {
    testWidgets(
        'LoginScreen navigates to HomePageUC when UC credentials are valid',
        (WidgetTester tester) async {
      when(ucController.authenticateUC('uc@example.com', 'password'))
          .thenAnswer((_) async => true);
      when(usController.authenticateUS('uc@example.com', 'password'))
          .thenAnswer((_) async => false);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: LoginScreen(email: 'uc@example.com', password: 'password'),
        ),
      );

      final emailField = find.byKey(const Key('TextFormFieldLoginEmail'));
      final passwordField = find.byKey(const Key('TextFormFieldLoginPassword'));
      final submitButton = find.byKey(const Key('ButtonLoginSubmit'));

      // Enter valid UC credentials
      await tester.enterText(emailField, 'uc@example.com');
      await tester.enterText(passwordField, 'password');

      // Tap the submit button
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Verify that the HomePageUC is pushed onto the navigation stack
      expect(find.byKey(const Key('HomePageUC')), findsOneWidget);
    });

    testWidgets(
        'LoginScreen navigates to HomePageUS when US credentials are valid',
        (WidgetTester tester) async {
      when(ucController.authenticateUC('us@example.com', 'password'))
          .thenAnswer((_) async => false);
      when(usController.authenticateUS('us@example.com', 'password'))
          .thenAnswer((_) async => true);
      when(reportController.getPendingCount()).thenAnswer((_) async => 0);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: LoginScreen(email: 'us@example.com', password: 'password'),
        ),
      );

      final emailField = find.byKey(const Key('TextFormFieldLoginEmail'));
      final passwordField = find.byKey(const Key('TextFormFieldLoginPassword'));
      final submitButton = find.byKey(const Key('ButtonLoginSubmit'));

      // Enter valid US credentials
      await tester.enterText(emailField, 'us@example.com');
      await tester.enterText(passwordField, 'password');

      // Tap the submit button
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Verify that the HomePageUS is pushed onto the navigation stack
      expect(find.byKey(const Key('HomePageUS')), findsOneWidget);
    });

    testWidgets('LoginScreen shows error message when credentials are invalid',
        (WidgetTester tester) async {
      when(ucController.authenticateUC('', '')).thenAnswer((_) async => false);
      when(usController.authenticateUS('', '')).thenAnswer((_) async => false);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: LoginScreen(email: '', password: ''),
        ),
      );

      final emailField = find.byKey(const Key('TextFormFieldLoginEmail'));
      final passwordField = find.byKey(const Key('TextFormFieldLoginPassword'));
      final submitButton = find.byKey(const Key('ButtonLoginSubmit'));

      // Enter invalid credentials
      await tester.enterText(emailField, 'invalid@example.com');
      await tester.enterText(passwordField, 'wrongpassword');

      // Tap the submit button
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Verify that the error message is displayed
      expect(find.text('Wrong email or password'), findsOneWidget);
    });
  });

  group('LoginScreen Form Validation Tests', () {
    testWidgets(
        'LoginScreen shows validation errors when fields are empty or invalid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: LoginScreen(email: '', password: ''),
        ),
      );

      final submitButton = find.byKey(const Key('ButtonLoginSubmit'));
      // Tap the submit button
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Verify that validation errors are displayed
      expect(find.text('Enter email'), findsOneWidget);
      expect(find.text('Enter password'), findsOneWidget);

      // Enter invalid email and password
      await tester.enterText(
          find.byKey(const Key('TextFormFieldLoginEmail')), 'invalidemail');
      await tester.enterText(
          find.byKey(const Key('TextFormFieldLoginPassword')), '123');
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Verify that validation errors for email and password are displayed
      expect(find.text('Enter valid email address'), findsOneWidget);
      expect(find.text('Password should have at least 6 characters'),
          findsOneWidget);
    });
  });

  group('LoginScreen Form Submission Tests', () {
    testWidgets(
        'LoginScreen submits form and navigates to HomePageUC with valid UC credentials',
        (WidgetTester tester) async {
      when(ucController.authenticateUC('uc@example.com', 'password'))
          .thenAnswer((_) async => true);
      when(usController.authenticateUS('uc@example.com', 'password'))
          .thenAnswer((_) async => false);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: LoginScreen(email: 'uc@example.com', password: 'password'),
        ),
      );

      final emailField = find.byKey(const Key('TextFormFieldLoginEmail'));
      final passwordField = find.byKey(const Key('TextFormFieldLoginPassword'));
      final submitButton = find.byKey(const Key('ButtonLoginSubmit'));

      // Enter valid UC credentials
      await tester.enterText(emailField, 'uc@example.com');
      await tester.enterText(passwordField, 'password');

      // Tap the submit button
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Verify that the HomePageUC is pushed onto the navigation stack
      expect(find.byKey(const Key('HomePageUC')), findsOneWidget);
    });

    testWidgets(
        'LoginScreen submits form and navigates to HomePageUS with valid US credentials',
        (WidgetTester tester) async {
      when(ucController.authenticateUC('us@example.com', 'password'))
          .thenAnswer((_) async => false);
      when(usController.authenticateUS('us@example.com', 'password'))
          .thenAnswer((_) async => true);
      when(reportController.getPendingCount()).thenAnswer((_) async => 0);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: LoginScreen(email: 'us@example.com', password: 'password'),
        ),
      );

      final emailField = find.byKey(const Key('TextFormFieldLoginEmail'));
      final passwordField = find.byKey(const Key('TextFormFieldLoginPassword'));
      final submitButton = find.byKey(const Key('ButtonLoginSubmit'));

      // Enter valid US credentials
      await tester.enterText(emailField, 'us@example.com');
      await tester.enterText(passwordField, 'password');

      // Tap the submit button
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Verify that the HomePageUS is pushed onto the navigation stack
      expect(find.byKey(const Key('HomePageUS')), findsOneWidget);
    });
  });
}
