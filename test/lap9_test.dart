import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/lap9.dart';

void main() {
  group('Kiểm tra Logic WeatherModel', () {
    final weatherModel = WeatherModel();

    test('1. Kiểm tra icon trả về đúng mã code WeatherAPI', () {
      expect(weatherModel.getWeatherIcon(1000), '☀️');
      expect(weatherModel.getWeatherIcon(1183), '☔️');
      expect(weatherModel.getWeatherIcon(1135), '🌫');
    });

    test('2. Kiểm tra thông điệp theo nhiệt độ', () {
      expect(weatherModel.getMessage(30), contains('🍦'));
      expect(weatherModel.getMessage(15), contains('🧥'));
    });
  });

  group('Kiểm tra Luồng Giao diện Lab 9', () {

    testWidgets('3. Kiểm tra trạng thái Loading và các nút bấm chính', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(const Clima());

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pump(const Duration(seconds: 2));

        expect(find.byIcon(Icons.near_me), findsWidgets);
        expect(find.byIcon(Icons.location_city), findsWidgets);
      });
    });

    testWidgets('4. Kiểm tra luồng chuyển màn hình CityScreen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(const Clima());

        await tester.pump(const Duration(seconds: 2));

        await tester.tap(find.byIcon(Icons.location_city));

        await tester.pumpAndSettle();

        expect(find.byType(TextField), findsOneWidget);
        expect(find.text('Nhập tên thành phố (vd: Hanoi)'), findsOneWidget);

        expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
      });
    });
  });
}