import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/search_products_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

@Injectable()
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;
  SearchBloc(this._searchProductsUseCase) : super(const SearchState()) {


    on<SearchProductsEvent>(_onSearchProducts,
      transformer: debounceSwitch(const Duration(milliseconds: 300)),);

    on<ClearSearch>(_onClearSearch,
      transformer: debounceSwitch(const Duration(milliseconds: 300)),);
  }

  CancelToken? _cancelToken;
  Future<void> _onSearchProducts(
      SearchProductsEvent event,
      Emitter<SearchState> emit,
      ) async {
    // cancel previous search (API call) before send another request
    _cancelToken?.cancel();

    // create new token for the current request
    _cancelToken = CancelToken();

    if (event.keyword == '') {
      emit(const SearchState());
      return;
    }

    // Emit loading state
    emit(state.copyWith(
      requestState: RequestState.loading,
      keyword: event.keyword,
    ));

    try {
      final result = await _searchProductsUseCase.call(
        event.keyword,
        cancelToken: _cancelToken,
      );

      // ensure if the current request is not cancelled before emit
      if (_cancelToken!.isCancelled) return;

      switch (result) {
        case ApiSucessResult<List<ProductsEntity>>():
          emit(
            state.copyWith(
              requestState: RequestState.success,
              products: result.sucessResult,
              errorMessage: '',
              keyword: event.keyword,
            ),
          );

        case ApiFailedResult<List<ProductsEntity>>():
          emit(
            state.copyWith(
              requestState: RequestState.error,
              products: [],
              errorMessage: result.errorMessage,
              keyword: event.keyword,
            ),
          );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        // ignore the exception caused by cancel
        return;
      }
      emit(
        state.copyWith(
          requestState: RequestState.error,
          products: [],
          errorMessage: e.message ?? 'Unexpected error',
          keyword: event.keyword,
        ),
      );
    }
  }


  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    _cancelToken?.cancel();
    emit(const SearchState());
  }

  // debounceTime --> wait duration before calling API
  // switchMap --> cancel previous event if another one added
  EventTransformer<T> debounceSwitch<T>(Duration duration) {
    return (events, mapper) {
      return events
          .debounceTime(duration)
          .switchMap(mapper);
    };
  }

}
