import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/main.dart';

void main() {
  testWidgets('home dashboard shows the main creation entry point', (tester) async {
    await tester.pumpWidget(const VivahBioApp());

    expect(find.text('Vivah Bio'), findsOneWidget);
    expect(find.text('Let’s create your\nbiodata.'), findsOneWidget);
    expect(find.text('Create new biodata'), findsOneWidget);
    expect(find.text('Continue editing'), findsOneWidget);
    expect(find.text('Find your style'), findsOneWidget);
  });

  testWidgets('create biodata opens the template gallery', (tester) async {
    await tester.pumpWidget(const VivahBioApp());

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('Choose a template'), findsOneWidget);
    expect(find.text('Pick a style—you can change it later.'), findsOneWidget);
    expect(find.text('Use This Template'), findsOneWidget);
    expect(find.text('The Classic'), findsOneWidget);
  });

  testWidgets('template must be selected before continuing', (tester) async {
    await tester.pumpWidget(const VivahBioApp());
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
    await tester.pumpWidget(const VivahBioApp());
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Traditional'));
    await tester.pumpAndSettle();

    expect(find.text('Floral Grace'), findsOneWidget);
    expect(find.text('Golden Tradition'), findsOneWidget);
    expect(find.text('The Classic'), findsNothing);
  });
}
