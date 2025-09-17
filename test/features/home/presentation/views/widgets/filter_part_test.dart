import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/bottom_sheet_title.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custum_bootom_sheet.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/dragable_line.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/filter_button.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/filter_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'custum_bootom_sheet_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CategoriesViewModel>()])
void main() {
  late ValueNotifier<String> catId;
  late ValueNotifier<String?> selectedValue;
  late BuildContext mycontext;
  late MockCategoriesViewModel mockCategoryViewModel;
  late AppLocalizations t;

  setUpAll(() {
    catId = ValueNotifier<String>("okwofkwe");
    selectedValue = ValueNotifier<String?>(null);
    mockCategoryViewModel = MockCategoriesViewModel();
  });
  testWidgets('verify filterPart structure', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

        home: BlocProvider<CategoriesViewModel>.value(
          value:mockCategoryViewModel ,
          child: Builder(
            builder: (context) {
              t = AppLocalizations.of(context)!;
              mycontext = context;
              return Scaffold(
                body: Stack(
                  children: [
                    FilterPart(
                      catId: catId,
                      selectedValue: selectedValue,
                      myContext: mycontext,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
    // expect(find.byType(Padding), findsNWidgets(3));
    expect(find.byType(Positioned), findsOneWidget);
    expect(find.byType(Center), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(2));

    expect(
      find.byWidgetPredicate((widget) {
        return widget is Positioned &&
            widget.bottom == 0 &&
            widget.right == 0 &&
            widget.left == 0 &&
            widget.child is Center;
      }),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate((widget) {
        return widget is Positioned &&
            widget.bottom == 0 &&
            widget.right == 0 &&
            widget.left == 0 &&
            widget.child is Center;
      }),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate((widget) {
        if (widget is Row && widget.mainAxisSize == MainAxisSize.min) {
          final children = widget.children;
          return children.length == 3 &&
              children[0] is Icon &&
              children[1] is SizedBox &&
              children[2] is Text;
        }
        return false;
      }),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate((widget) {
        return widget is Icon && widget.icon == Icons.filter_alt_rounded;
      }),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate((widget) {
        return widget is SizedBox && widget.width == 5;
      }),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate((widget) {
        return widget is Text && widget.data == t.filter;
      }),
      findsOneWidget,
    );

    await tester.tap(find.byKey(Key("eleBtn1")));
    await tester.pump();
    expect(find.byType(CustumBootomSheet), findsOneWidget);
  });
}
