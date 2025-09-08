part of 'search_bloc.dart';

@immutable
class SearchState extends Equatable {
  final RequestState requestState;
  final List<ProductsEntity> products;
  final String errorMessage;
  final String keyword;

  const SearchState({
    this.requestState = RequestState.init,
    this.products = const [],
    this.errorMessage = '',
    this.keyword=''
  });

  SearchState copyWith({
    RequestState? requestState,
    List<ProductsEntity>? products,
    String? errorMessage,
    String? keyword,
  }) {
    return SearchState(
      requestState: requestState ?? this.requestState,
      products: products ?? this.products,
      errorMessage: errorMessage??this.errorMessage,
      keyword: keyword??''
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [requestState, products, errorMessage,keyword];
}
