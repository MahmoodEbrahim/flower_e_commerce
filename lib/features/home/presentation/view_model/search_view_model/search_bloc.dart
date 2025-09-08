import 'package:bloc/bloc.dart';
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
      transformer: debounceSwitch(const Duration(milliseconds: 500)),);

    on<ClearSearch>(_onClearSearch);
  }


  Future<void> _onSearchProducts(
      SearchProductsEvent event,
      Emitter<SearchState> emit,
      ) async {
    // Emit loading state
    emit(state.copyWith(
      requestState: RequestState.loading,
      keyword: event.keyword,
    ));


    final result = await _searchProductsUseCase.call(event.keyword);

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
  }


  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }

  // debounceTime --> wait duration before calling API
  // switchMap --> cancel API call if another one request
  EventTransformer<T> debounceSwitch<T>(Duration duration) {
    return (events, mapper) {
      return events
          .debounceTime(duration)
          .switchMap(mapper);
    };
  }
}
