import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:are_you_free_c_s_c305_second_ver/flutter_flow/flutter_flow_icon_button.dart';
import 'package:are_you_free_c_s_c305_second_ver/flutter_flow/flutter_flow_widgets.dart';
import 'package:are_you_free_c_s_c305_second_ver/flutter_flow/flutter_flow_theme.dart';
import 'package:are_you_free_c_s_c305_second_ver/index.dart';
import 'package:are_you_free_c_s_c305_second_ver/main.dart';
import 'package:are_you_free_c_s_c305_second_ver/flutter_flow/flutter_flow_util.dart';

import 'package:provider/provider.dart';
import 'package:are_you_free_c_s_c305_second_ver/backend/firebase/firebase_config.dart';
import 'package:are_you_free_c_s_c305_second_ver/auth/firebase_auth/auth_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initFirebase();

    await FlutterFlowTheme.initialize();
  });

  setUp(() async {
    await authManager.signOut();
    FFAppState.reset();
    final appState = FFAppState();
    await appState.initializePersistedState();
  });

  testWidgets('Login or Golden Path Test', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: MyApp(
        entryPage: SignUpLogInWidget(),
      ),
    ));

    await tester.pumpAndSettle(Duration(milliseconds: 2000));
    await tester.enterText(
        find.byKey(ValueKey('emailAddress_f65c')), 'automatedEmail@gmail.com');
    await tester.enterText(find.byKey(ValueKey('password_xx5h')), '123456');
    await tester.tap(find.byKey(ValueKey('Button_42dy')));
    expect(find.byKey(ValueKey('Name_mehr')), findsOneWidget);
    await tester.enterText(
        find.byKey(ValueKey('Name_mehr')), 'AutomatedTestName');
    await tester.enterText(
        find.byKey(ValueKey('UserName_bwh3')), 'AutomatedDisplayName');
    await tester.tap(find.byKey(ValueKey('Button_3gn1')));
    await tester.tap(find.byIcon(Icons.home_outlined));
    expect(find.byKey(ValueKey('IconButton_wwly')), findsOneWidget);
  });

  testWidgets('Invalid Sign Up', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: MyApp(
        entryPage: SignUpLogInWidget(),
      ),
    ));

    await tester.pumpAndSettle(Duration(milliseconds: 2000));
    await tester.enterText(
        find.byKey(ValueKey('emailAddress_f65c')), 'this Is wrong');
    await tester.enterText(find.byKey(ValueKey('password_xx5h')), 'bad');
    await tester.tap(find.byKey(ValueKey('Button_42dy')));
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    expect(find.text('Let\'s get started by filling out the form below.'),
        findsOneWidget);
  });
}

// There are certain types of errors that can happen during tests but
// should not break the test.
void _overrideOnError() {
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (errorDetails) {
    if (_shouldIgnoreError(errorDetails.toString())) {
      return;
    }
    originalOnError(errorDetails);
  };
}

bool _shouldIgnoreError(String error) {
  // It can fail to decode some SVGs - this should not break the test.
  if (error.contains('ImageCodecException')) {
    return true;
  }
  // Overflows happen all over the place,
  // but they should not break tests.
  if (error.contains('overflowed by')) {
    return true;
  }
  // Sometimes some images fail to load, it generally does not break the test.
  if (error.contains('No host specified in URI') ||
      error.contains('EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE')) {
    return true;
  }
  // These errors should be avoided, but they should not break the test.
  if (error.contains('setState() called after dispose()')) {
    return true;
  }

  return false;
}
