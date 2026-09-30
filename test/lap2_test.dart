import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/lap2.dart';


void main() {
  testWidgets('MiCardApp UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MiCardApp());

    expect(find.text('Nguyễn Thái Nguyên'), findsOneWidget);
    expect(find.text('23IT.B142'), findsOneWidget);

    expect(find.text('SINH VIÊN'), findsOneWidget);

    expect(find.text('Bài tập Flutter: 9 Labs'), findsOneWidget);

    expect(find.byIcon(Icons.badge), findsOneWidget);

    expect(find.byIcon(Icons.school), findsOneWidget);

    expect(find.byType(CircleAvatar), findsOneWidget);

    expect(find.byType(Card), findsNWidgets(2));
  });
}
