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

  testWidgets('create biodata action explains the next step is not implemented yet', (tester) async {
    await tester.pumpWidget(const VivahBioApp());

    await tester.tap(find.text('Get started'));
    await tester.pump();

    expect(
      find.text('Create biodata will be connected when that screen is implemented.'),
      findsOneWidget,
    );
  });
}
