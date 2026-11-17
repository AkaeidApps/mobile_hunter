import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_hunter/app.dart';

void main() {
  testWidgets('startup shows the login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MobileHunterApp());

    expect(find.text('Mobile Hunter'), findsOneWidget);
    expect(find.text('Continue with Gmail'), findsOneWidget);
  });
}
