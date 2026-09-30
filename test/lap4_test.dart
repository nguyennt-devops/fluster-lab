import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/lap4.dart';

void main() {
  testWidgets('Lab 4: Kiểm tra BallPage', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: BallPage()));
    expect(find.text('Ask Me Anything'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });
}