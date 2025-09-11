import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'filter_button_test.mocks.dart';

@GenerateMocks([CategoriesViewModel])
void main() {
  testWidgets('verify filterButton structure', (tester) async {
    final mockCategoryViewModel = MockCategoriesViewModel();
    final List<String> filtersApi = [
      "price",
      "-price",
      "new",
      "old",
      "discount",
    ];
    final int index = 0;
    String? catId;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: FilterButtom(
          categoriesViewModel: mockCategoryViewModel,
          filtersApi: filtersApi,
          myIndex: index,
          sendCatId: catId,
        ),
      ),
    );

    expect(find.byType(Row), findsNWidgets(2));
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(Navigator), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Padding &&
            widget.padding == EdgeInsets.all(12) &&
            widget.child is Text,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == 5,
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Icon && widget.icon == Icons.filter_alt_rounded,
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate((widget) {
        if (widget is Row && widget.mainAxisSize == MainAxisSize.min) {
          final children = widget.children;
          return children.length == 3 &&
              children[0] is Icon &&
              children[1] is SizedBox &&
              children[2] is Padding;
        }
        return false;
      }),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate((widget)=> widget is Expanded && widget.child is ElevatedButton),
      findsOneWidget,
    );


    expect(
     find.byWidgetPredicate((widget)=> widget is Row && widget.children[0] is Expanded),
      findsOneWidget,
   );
  });
}
