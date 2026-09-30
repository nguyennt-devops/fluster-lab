import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/lap8.dart';

void main() {
  group('Kiểm tra giao diện Lab 8 (Widget Tests)', () {

    testWidgets('1. Kiểm tra tiêu đề và các thành phần chính', (WidgetTester tester) async {
      await tester.pumpWidget(const BMICalculator());

      expect(find.text('BMI CALCULATOR'), findsOneWidget);

      expect(find.text('HEIGHT'), findsOneWidget);
      expect(find.text('WEIGHT'), findsOneWidget);
      expect(find.text('AGE'), findsOneWidget);

      expect(find.text('CALCULATE'), findsOneWidget);
    });

    testWidgets('2. Kiểm tra điều hướng sang trang kết quả', (WidgetTester tester) async {
      await tester.pumpWidget(const BMICalculator());

      await tester.tap(find.text('CALCULATE'));

      await tester.pumpAndSettle();

      expect(find.text('Your Result'), findsOneWidget);
      expect(find.text('RE-CALCULATE'), findsOneWidget);
    });
  });

  group('Kiểm tra logic tính toán (Unit Tests)', () {
    test('3. Kiểm tra công thức BMI từ CalculatorBrain', () {
      final calc = CalculatorBrain(height: 180, weight: 70);

      String result = calc.calculateBMI();

      expect(result, '21.6');
      expect(calc.getResult(), 'Normal');
    });

    test('4. Kiểm tra phân loại thừa cân', () {
      final calc = CalculatorBrain(height: 160, weight: 90);

      calc.calculateBMI();
      expect(calc.getResult(), 'Overweight');
    });
  });
}