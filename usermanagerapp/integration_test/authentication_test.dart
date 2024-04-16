import 'package:f_testing_template/main.dart';
import 'package:f_testing_template/ui/pages/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  Future<Widget> createHomeScreen() async {
    WidgetsFlutterBinding.ensureInitialized();
    return const MyApp();
  }

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Login -> signup -> creación usuario -> login no exitoso",
      (WidgetTester tester) async {
    // Iniciar en la pantalla de login
  await tester.pumpWidget(const GetMaterialApp(
    home: LoginScreen(
      key: Key('LoginScreen'),
      email: "blank",
      password: "blank",
    ),
  ));

  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);

  // Navegar a la pantalla de signup
  await tester.tap(find.byKey(const Key('ButtonLoginCreateAccount')));
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('SignUpPage')), findsOneWidget);

  // Llenar el formulario de signup con un email válido y contraseña
  await tester.enterText(
    find.byKey(const Key('TextFormFieldSignUpEmail')), 'testuser@test.com');
  
  await tester.enterText(
    find.byKey(const Key('TextFormFieldSignUpPassword')), 'password123');

  await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);
  // Ingresar credenciales incorrectas en el formulario de login
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginEmail')), 'testuser@test.com');
  
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginPassword')), '123456');

  await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
  await tester.pumpAndSettle();

  // Verificar que el mensaje de error es mostrado
 expect(find.byKey(const Key('LoginScreen')), findsOneWidget);
  });

  testWidgets("Login -> signup -> creación usuario -> login exitoso -> logout",
      (WidgetTester tester) async {
      // Iniciar en la pantalla de login
  await tester.pumpWidget(const GetMaterialApp(
    home: LoginScreen(
      key: Key('LoginScreen'),
      email: "blank",
      password: "blank",
    ),
  ));

  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);

  // Navegar a la pantalla de signup
  await tester.tap(find.byKey(const Key('ButtonLoginCreateAccount')));
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('SignUpPage')), findsOneWidget);

  // Llenar el formulario de signup con un email válido y contraseña
  await tester.enterText(
    find.byKey(const Key('TextFormFieldSignUpEmail')), 'testuser@test.com');
  
  await tester.enterText(
    find.byKey(const Key('TextFormFieldSignUpPassword')), 'password123');

  await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);

  // Ingresar credenciales correctas en el formulario de login
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginEmail')), 'testuser@test.com');
  
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginPassword')), 'password123');

  await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
  await tester.pumpAndSettle();

  // Verificar que la pantalla de inicio (home) se muestra después de un login exitoso
  expect(find.byKey(const Key('HomePage')), findsOneWidget);

  // Hacer logout desde la pantalla de inicio (home)
  await tester.tap(find.byKey(const Key('ButtonHomeLogOff')));
  await tester.pumpAndSettle();

  // Verificar que se regresa a la pantalla de login después de hacer logout
  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);
  });

  testWidgets(
      "Login -> signup -> creación usuario -> login éxitoso -> logout -> login exitoso",
      (WidgetTester tester) async {
          // Iniciar en la pantalla de login
  await tester.pumpWidget(const GetMaterialApp(
    home: LoginScreen(
      key: Key('LoginScreen'),
      email: "blank",
      password: "blank",
    ),
  ));

  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);

  // Navegar a la pantalla de signup
  await tester.tap(find.byKey(const Key('ButtonLoginCreateAccount')));
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('SignUpPage')), findsOneWidget);

  // Llenar el formulario de signup con un email válido y contraseña
  await tester.enterText(
    find.byKey(const Key('TextFormFieldSignUpEmail')), 'testuser@test.com');
  
  await tester.enterText(
    find.byKey(const Key('TextFormFieldSignUpPassword')), 'password123');

  await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);

  // Ingresar credenciales correctas en el formulario de login
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginEmail')), 'testuser@test.com');
  
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginPassword')), 'password123');

  await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
  await tester.pumpAndSettle();

  // Verificar que la pantalla de inicio (home) se muestra después de un login exitoso
  expect(find.byKey(const Key('HomePage')), findsOneWidget);

  // Hacer logout desde la pantalla de inicio (home)
  await tester.tap(find.byKey(const Key('ButtonHomeLogOff')));
  await tester.pumpAndSettle();

  // Verificar que se regresa a la pantalla de login después de hacer logout
  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);

  // Ingresar credenciales correctas en el formulario de login después de logout
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginEmail')), 'testuser@test.com');
  
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginPassword')), 'password123');

  await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
  await tester.pumpAndSettle();

  // Verificar que la pantalla de inicio (home) se muestra después de un segundo login exitoso
  expect(find.byKey(const Key('HomePage')), findsOneWidget);
  });

  testWidgets(
      "Login -> signup -> creación usuario -> login éxitoso -> logout -> login no exitoso",
      (WidgetTester tester) async {
      // Iniciar en la pantalla de login
  await tester.pumpWidget(const GetMaterialApp(
    home: LoginScreen(
      key: Key('LoginScreen'),
      email: "blank",
      password: "blank",
    ),
  ));

  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);

  // Navegar a la pantalla de signup
  await tester.tap(find.byKey(const Key('ButtonLoginCreateAccount')));
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('SignUpPage')), findsOneWidget);

  // Llenar el formulario de signup con un email válido y contraseña
  await tester.enterText(
    find.byKey(const Key('TextFormFieldSignUpEmail')), 'testuser@test.com');
  
  await tester.enterText(
    find.byKey(const Key('TextFormFieldSignUpPassword')), 'password123');

  await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);

  // Ingresar credenciales correctas en el formulario de login
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginEmail')), 'testuser@test.com');
  
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginPassword')), 'password123');

  await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
  await tester.pumpAndSettle();

  // Verificar que la pantalla de inicio (home) se muestra después de un login exitoso
  expect(find.byKey(const Key('HomePage')), findsOneWidget);

  // Hacer logout desde la pantalla de inicio (home)
  await tester.tap(find.byKey(const Key('ButtonHomeLogOff')));
  await tester.pumpAndSettle();

  // Verificar que se regresa a la pantalla de login después de hacer logout
  expect(find.byKey(const Key('LoginScreen')), findsOneWidget);

  // Ingresar credenciales correctas en el formulario de login después de logout
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginEmail')), 'testuser@test.com');
  
  await tester.enterText(
    find.byKey(const Key('TextFormFieldLoginPassword')), 'pasrd123');

  await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
  await tester.pumpAndSettle();
  expect(find.text('User or passwor nok'), findsOneWidget);
  // Verificar que la pantalla de inicio (home) se muestra después de un segundo login exitoso
  });
}
