import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/lap3.dart';

void main() {
  testWidgets('Lab 3: Kiểm tra nút bấm Xúc xắc', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: DicePage())));
    expect(find.byType(TextButton), findsNWidgets(2));
  });
}