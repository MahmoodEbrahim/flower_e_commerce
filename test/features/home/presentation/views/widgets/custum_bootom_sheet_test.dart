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

  setUpAll(() {
    catId = ValueNotifier<String>("okwofkwe");
    selectedValue = ValueNotifier<String?>(null);
    mockCategoryViewModel = MockCategoriesViewModel();
  });
  testWidgets('verify custumBottomSheet structure', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

        home: BlocProvider<CategoriesViewModel>.value(
          value: mockCategoryViewModel,
          child: Builder(
            builder: (context) {
              mycontext = context;
              return Scaffold(
                body: CustumBootomSheet(
                  catId: catId,
                  selectedValue: selectedValue,
                  mycontext: mycontext,
                  t: AppLocalizations.of(context)!,
                ),
              );
            },
          ),
        ),
      ),
    );
    // expect(find.byType(Padding), findsNWidgets(3));
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(DraagableLine), findsOneWidget);
    expect(find.byType(ButtomSheetTitle), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(4));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(6));
    expect(find.byType(RadioListTile<String>), findsNWidgets(5));
    expect(find.byType(Text), findsNWidgets(7));
    expect(find.byType(FilterButtom), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    // await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate((widget) {
        return widget is SizedBox &&
            widget.height == 300 &&
            widget.child is ListView;
      }),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate((widget) {
        if (widget is Container && widget.decoration is BoxDecoration) {
          final box = widget.decoration as BoxDecoration;
          final boxShadow = box.boxShadow;
          if (boxShadow == null || boxShadow.isEmpty) return false;

          return box.borderRadius == BorderRadius.circular(10) &&
              widget.margin == const EdgeInsets.symmetric(vertical: 5) &&
              boxShadow[0].color == AppColors.blackColor[10]! &&
              boxShadow[0].spreadRadius == 1 &&
              boxShadow[0].blurRadius == 6 &&
              boxShadow[0].offset == const Offset(0, 2) &&
              box.color == AppColors.whiteColor[10] &&
              widget.child is RadioListTile<String>;
        }
        return false;
      }),
      findsNWidgets(5),
    );

    expect(
      find.byWidgetPredicate((widget) {
        return widget is RadioListTile<String> &&
            widget.fillColor?.resolve({}) == AppColors.pink &&
            widget.title is Text;
      }),
      findsWidgets,
    );

    final radioTile = find.byKey(Key("firstTile 0"));
    await tester.tap(radioTile);
    await tester.pump();

    expect(selectedValue.value, isNotNull);

    expect(
      find.byWidgetPredicate((widget) {
        if (widget is Text && widget.style is TextStyle) {
          final myStyle = widget.style as TextStyle;
          final expectedStyle = getBoldStyle(
            color: AppColors.black,
            fontSize: FontSize.s16,
          );
          return myStyle.fontSize == expectedStyle.fontSize &&
              myStyle.color == expectedStyle.color;
        }
        return false;
      }),
      findsWidgets,
    );
  });
}
