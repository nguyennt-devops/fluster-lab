import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/lap1.dart';

void main() {
  testWidgets('Lab 1: Kiểm tra tiêu đề I Am Rich', (WidgetTester tester) async {
    await tester.pumpWidget(const IAmRichApp());
    expect(find.text('I Am Rich'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}