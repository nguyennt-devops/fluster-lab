import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/lap5.dart';

void main() {
  testWidgets('Lab 5: Kiểm tra 7 phím đàn Xylophone', (WidgetTester tester) async {
    await tester.pumpWidget(const XylophoneApp());
    expect(find.byType(TextButton), findsNWidgets(7));
  });
}