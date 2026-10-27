import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/main.dart';
import 'package:test_app/screens/onboarding_screen.dart';

Future<void> pumpHome(WidgetTester tester) async {
  // Keep these flow tests focused on the dashboard and creation screens.
  OnboardingScreen.completedInSession = true;
  await tester.pumpWidget(const VivahBioApp());
  await tester.pumpAndSettle();
}

Future<void> openPersonalDetails(WidgetTester tester) async {
  await tester.tap(find.text('Get started'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('The Classic'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Use This Template'));
  await tester.pumpAndSettle();
}

Future<void> enterNameAndContinue(WidgetTester tester) async {
  await tester.enterText(find.byType(TextFormField).first, 'Aarav Sharma');
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('home dashboard shows the main creation entry point', (tester) async {
    await pumpHome(tester);

    expect(find.text('Vivah Bio'), findsOneWidget);
    expect(find.text('Let’s create your\nbiodata.'), findsOneWidget);
    expect(find.text('Create new biodata'), findsOneWidget);
    expect(find.text('Continue editing'), findsOneWidget);
    expect(find.text('Find your style'), findsOneWidget);
  });

  testWidgets('create biodata opens the template gallery', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('Choose a template'), findsOneWidget);
    expect(find.text('Pick a style—you can change it later.'), findsOneWidget);
    expect(find.text('Use This Template'), findsOneWidget);
    expect(find.text('The Classic'), findsOneWidget);
  });

  testWidgets('template must be selected before continuing', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    final button = tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Use This Template'));
    expect(button.onPressed, isNull);

    await tester.tap(find.text('Modern'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Modern Minimal'));
    await tester.pumpAndSettle();

    final enabledButton = tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Use This Template'));
    expect(enabledButton.onPressed, isNotNull);
    expect(find.text('Template selected'), findsOneWidget);
  });

  testWidgets('template category filters update the gallery', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Traditional'));
    await tester.pumpAndSettle();

    expect(find.text('Floral Grace'), findsOneWidget);
    expect(find.text('Golden Tradition'), findsOneWidget);
    expect(find.text('The Classic'), findsNothing);
  });

  testWidgets('using a template opens personal details and keeps template context', (tester) async {
    await pumpHome(tester);
    await openPersonalDetails(tester);

    expect(find.text('Personal details'), findsOneWidget);
    expect(find.text('The Classic'), findsOneWidget);
    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('Save & Exit'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('personal details requires a full name before continuing', (tester) async {
    await tester.view.setSize(const Size(800, 1400));
    addTearDown(tester.view.resetSize);
    await pumpHome(tester);
    await openPersonalDetails(tester);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your full name.'), findsOneWidget);
  });

  testWidgets('Personal Details Continue opens Family Details', (tester) async {
    await tester.view.setSize(const Size(800, 1400));
    addTearDown(tester.view.resetSize);
    await pumpHome(tester);
    await openPersonalDetails(tester);
    await enterNameAndContinue(tester);

    expect(find.text('Family details'), findsOneWidget);
    expect(find.text('STEP 2 OF 5'), findsOneWidget);
    expect(find.text('PARENTS'), findsOneWidget);
    expect(find.text('SIBLINGS'), findsOneWidget);
    expect(find.text('FAMILY BACKGROUND'), findsOneWidget);
  });

  testWidgets('Family Details Continue opens Education and Career', (tester) async {
    await tester.view.setSize(const Size(800, 1400));
    addTearDown(tester.view.resetSize);
    await pumpHome(tester);
    await openPersonalDetails(tester);
    await enterNameAndContinue(tester);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Education & career'), findsOneWidget);
    expect(find.text('STEP 3 OF 5'), findsOneWidget);
    expect(find.text('Highest qualification'), findsOneWidget);
    expect(find.text('Employment status'), findsOneWidget);
  });

  testWidgets('Education and Career Continue opens optional Partner Preferences', (tester) async {
    await tester.view.setSize(const Size(800, 1400));
    addTearDown(tester.view.resetSize);
    await pumpHome(tester);
    await openPersonalDetails(tester);
    await enterNameAndContinue(tester);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Partner preferences'), findsOneWidget);
    expect(find.text('Include partner preferences'), findsOneWidget);
  });

  testWidgets('Partner Preferences can remain off and continue to Photo and Contact', (tester) async {
    await tester.view.setSize(const Size(800, 1400));
    addTearDown(tester.view.resetSize);
    await pumpHome(tester);
    await openPersonalDetails(tester);
    await enterNameAndContinue(tester);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Photo & contact'), findsOneWidget);
    expect(find.text('Show phone on biodata'), findsOneWidget);
    expect(find.text('Show email on biodata'), findsOneWidget);
  });

  testWidgets('photo and contact can be skipped and preview opens', (tester) async {
    await tester.view.setSize(const Size(800, 1400));
    addTearDown(tester.view.resetSize);
    await pumpHome(tester);
    await openPersonalDetails(tester);
    await enterNameAndContinue(tester);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Review biodata'));
    await tester.pumpAndSettle();

    expect(find.text('Preview biodata'), findsOneWidget);
    expect(find.text('Export biodata'), findsOneWidget);
    expect(find.text('Change template'), findsOneWidget);
  });

  testWidgets('saved biodatas shows a useful empty state', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.text('My biodatas'));
    await tester.pumpAndSettle();

    expect(find.text('My Biodatas'), findsOneWidget);
    expect(find.text('No biodatas yet'), findsOneWidget);
    expect(find.text('Create biodata'), findsOneWidget);
  });
}
