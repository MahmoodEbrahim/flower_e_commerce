import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_view_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/search_view_model/search_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_page_test.mocks.dart';

@GenerateMocks([SearchBloc])
class FakeCartViewModel extends Fake implements CartViewModel {}

void main() {
  late MockSearchBloc mockSearchBloc;

  setUpAll(() {
    getIt.registerFactory<SearchBloc>(() => mockSearchBloc);
    getIt.registerFactory<CartViewModel>(() => FakeCartViewModel());
  });

  setUp(() {
    mockSearchBloc = MockSearchBloc();
    when(mockSearchBloc.state).thenReturn(SearchState());
    when(
      mockSearchBloc.stream,
    ).thenAnswer((_) => Stream.fromIterable([SearchState()]));
  });

  Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<SearchBloc>.value(
        value: mockSearchBloc,
        child: const SearchPage(),
      ),
    );
  }

  group("test search behaviour", () {
    testWidgets("Verify search Initial State", (WidgetTester tester) async {
      when(mockSearchBloc.state).thenReturn(SearchState());
      when(
        mockSearchBloc.stream,
      ).thenAnswer((_) => Stream.fromIterable([SearchState()]));

      await tester.pumpWidget(prepareWidget());

      expect(find.byKey(Key("empty_state")), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Icon &&
              widget.color == AppColors.midGray &&
              widget.icon == Icons.search &&
              widget.size == 60,
        ),
        findsOneWidget,
      );
    });

    testWidgets("Verify search error state", (WidgetTester tester) async {
      const errorMessage = "Something went wrong";
      when(mockSearchBloc.state).thenReturn(
        SearchState(
          requestState: RequestState.error,
          errorMessage: errorMessage,
        ),
      );
      when(mockSearchBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([
          SearchState(),
          SearchState(
            requestState: RequestState.error,
            errorMessage: errorMessage,
          ),
        ]),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byKey(Key("error_state")), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Icon &&
              widget.color == AppColors.midGray &&
              widget.icon == Icons.error_outline &&
              widget.size == 60,
        ),
        findsOneWidget,
      );
      expect(find.byKey(Key("error_message")), findsOneWidget);
    });

    testWidgets("Verify search when no products matches keyword ", (
      WidgetTester tester,
    ) async {
      when(mockSearchBloc.state).thenReturn(
        SearchState(
          requestState: RequestState.success,
          products: [],
          keyword: "keyword",
        ),
      );
      when(mockSearchBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([
          SearchState(),
          SearchState(
            requestState: RequestState.success,
            products: [],
            keyword: "keyword",
          ),
        ]),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byKey(Key("no_results_state")), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Icon &&
              widget.color == AppColors.gray &&
              widget.icon == Icons.sentiment_very_dissatisfied &&
              widget.size == 40,
        ),
        findsOneWidget,
      );
      expect(find.byKey(Key('no_results_message')), findsOneWidget);
    });

    testWidgets("Verify search when products is found", (
      WidgetTester tester,
    ) async {
      final fakeProducts = ProductsEntity(
        id: "1",
        title: "Rose Bouquet",
        imgCover: "https://fakeimg.pl/200x200",
        price: 100,
        priceAfterDiscount: 80,
      );

      when(mockSearchBloc.state).thenReturn(
        SearchState(
          products: [fakeProducts],
          requestState: RequestState.success,
          keyword: "Rose",
        ),
      );

      when(mockSearchBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([
          SearchState(
            products: [fakeProducts],
            requestState: RequestState.success,
            keyword: "Rose",
          ),
        ]),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byKey(Key("success_results_state")), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SliverGrid &&
              widget.gridDelegate
                  is SliverGridDelegateWithFixedCrossAxisCount &&
              widget.delegate is SliverChildBuilderDelegate,
        ),
        findsOneWidget,
      );
    });

    testWidgets("Verify Loading State shows loader", (
      WidgetTester tester,
    ) async {
      when(
        mockSearchBloc.state,
      ).thenReturn(SearchState(requestState: RequestState.loading));
      when(mockSearchBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([
          SearchState(requestState: RequestState.loading),
        ]),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byKey(Key("loading_state")), findsOneWidget);
      expect(find.byType(LoadingAnimationWidget), findsNothing);
    });

    testWidgets("Verify AppBar exists", (WidgetTester tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byKey(Key("search_appbar")), findsOneWidget);
    });
  });
}
