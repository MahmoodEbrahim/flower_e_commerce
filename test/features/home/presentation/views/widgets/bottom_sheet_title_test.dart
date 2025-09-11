import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/bottom_sheet_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('verify bottomSheetTitle structure', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

        home: ButtomSheetTitle(),
      ),
    );
    expect(find.byType(Padding), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);

    expect(
      find.byWidgetPredicate((widget) {
        if (widget is Text &&
            widget.textAlign is TextAlign &&
            widget.style is TextStyle) {
          final textAlign = widget.textAlign as TextAlign;
          final myStyle = widget.style as TextStyle;

          return textAlign == TextAlign.start &&
              myStyle.color == AppColors.pink &&
              myStyle.fontSize == FontSize.s20 &&
              myStyle.fontWeight == FontWeight.w700;
        }
        return false;
      }),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate((widget) => widget is Padding&& widget.padding==EdgeInsets.symmetric(vertical: 10)&&widget.child is Text
       
      ),
      findsOneWidget,
    );

   
  });
}
