import 'package:flutter_test/flutter_test.dart';
import 'package:climate_app/main.dart';

void main() {
  testWidgets('Activity monitor app loads initial screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TelefonoApp());

    expect(find.text('Monitor de Actividad'), findsOneWidget);
    expect(find.text('Conecta tu wearable'), findsOneWidget);
    expect(find.text('Buscar wearable'), findsOneWidget);
  });
}
