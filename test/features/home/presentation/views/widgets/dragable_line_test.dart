import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/dragable_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('verify dragable Line structure', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DraagableLine()));

    expect(find.byType(Align), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);

    expect(
      find.byWidgetPredicate((widget) {
        if (widget is Container && widget.decoration is BoxDecoration) {
          final box = widget.decoration as BoxDecoration;
          return widget.constraints!.minWidth == 100 &&
              widget.constraints!.minHeight == 4 &&
              box.color == AppColors.gray &&
              box.borderRadius == BorderRadius.circular(10);
        }
        return false;
      }),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is MouseRegion &&
            widget.cursor == SystemMouseCursors.click &&
            widget.child is Container,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Align &&
            widget.alignment == Alignment.center &&
            widget.child is MouseRegion,
      ),
      findsOneWidget,
    );
  });





}
