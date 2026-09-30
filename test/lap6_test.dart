import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/lap6.dart';

void main() {
  testWidgets('Lab 6: Kiểm tra nút Đúng Sai của Quizzler', (WidgetTester tester) async {
    await tester.pumpWidget(const Quizzler());
    expect(find.text('Đúng'), findsOneWidget);
    expect(find.text('Sai'), findsOneWidget);
  });
}