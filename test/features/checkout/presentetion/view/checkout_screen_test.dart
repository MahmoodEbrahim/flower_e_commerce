import 'package:flower_e_commerce/features/checkout/presentation/views/checkout-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Gift switch should be disabled when payment is cash', (tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: CheckoutScreen(subTotal: 100, deliveryFee: 10),
      ),
    );

    // Act
    final switchFinder = find.byType(Switch);

    // Assert
    final Switch giftSwitch = tester.widget(switchFinder);
    expect(giftSwitch.onChanged, isNull);
  });
  testWidgets('Gift switch should be enabled when payment is card', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CheckoutScreen(subTotal: 100, deliveryFee: 10),
      ),
    );

    // credit card
    await tester.tap(find.text("Credit card"));
// تستنى animations أو setState تخلص.
    await tester.pumpAndSettle();

    final switchFinder = find.byType(Switch);
    final Switch giftSwitch = tester.widget(switchFinder);

    expect(giftSwitch.onChanged, isNotNull);
  });
  testWidgets('Gift fields appear when switch is turned on', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CheckoutScreen(subTotal: 100, deliveryFee: 10),
      ),
    );

    // credit card
    await tester.tap(find.text("Credit card"));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(TextField), findsNWidgets(2)); // Name + Phone
  });
  testWidgets('Total should equal subtotal + delivery fee', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CheckoutScreen(subTotal: 100, deliveryFee: 10),
      ),
    );

    expect(find.text("110\$"), findsOneWidget); // 100 + 10
  });

}
