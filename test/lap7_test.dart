import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/lap7.dart';

void main() {
  testWidgets('Lab 7: Kiểm tra cốt truyện Destini', (WidgetTester tester) async {
    await tester.pumpWidget(const Destini());
    expect(find.textContaining('xe bị hỏng'), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
  });
}