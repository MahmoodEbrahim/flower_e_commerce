part of 'search_bloc.dart';

@immutable
class SearchEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class SearchProductsEvent extends SearchEvent {
  final String keyword;
  SearchProductsEvent(this.keyword);

  @override
  List<Object?> get props => [keyword];
}

class ClearSearch extends SearchEvent {
  @override
  List<Object?> get props => [];
}

