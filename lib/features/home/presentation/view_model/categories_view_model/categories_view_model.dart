// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/get_products_by_category_id._usecase.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/get_search_products_usecase.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_event.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class CategoriesViewModel extends Bloc<CategoriesEvent, CategoryState> {
  final GetProductsByCategoryIdUseCase _getProductsByCategoryIdUseCase;
  final GetSearchProductsUsecase _getSearchProductsUsecase;
  CategoriesViewModel(
    this._getProductsByCategoryIdUseCase,
    this._getSearchProductsUsecase,
  ) : super(CategoryState()) {
    on<GetAllProductsOfCategoriesEvent>(_getProductsById);
    on<GetAllProductsEvent>(_getAllProducts);
    on<SelectCatIndexEvent>(_selectIndex);
    on<GetSearchProductsEvent>(_getSearchProducts);
  }

  void _getProductsById(
    GetAllProductsOfCategoriesEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final res = await _getProductsByCategoryIdUseCase.getProductsByCategoryId(
      event.catId,
    );

    switch (res) {
      case ApiSucessResult<List<ProductsEntity>>():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            products: res.sucessResult,
            categories: event.categories,
          ),
        );
      case ApiFailedResult<List<ProductsEntity>>():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: res.errorMessage,
            products: null,
          ),
        );
    }
  }

  void _getAllProducts(GetAllProductsEvent event, Emitter emit) {
    emit(state.copyWith(isLoading: true));

    emit(
      state.copyWith(
        products: event.products,
        errorMessage: null,
        isLoading: false,
        categories: event.categories,
        allProducts: event.allproducts,
      ),
    );
  }

  void _selectIndex(SelectCatIndexEvent event, Emitter emit) {
    emit(state.copyWith(index: event.index));
  }

  void _getSearchProducts(GetSearchProductsEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    final res = await _getSearchProductsUsecase.getSearchProducts(
      event.filter,
      event.catId,
    );

    switch (res) {
      case ApiSucessResult<List<ProductsEntity>>():
        emit(
          state.copyWith(
            products: res.sucessResult,
            errorMessage: null,
            isLoading: false,
          ),
        );
      case ApiFailedResult<List<ProductsEntity>>():
        emit(state.copyWith(errorMessage: res.errorMessage, isLoading: false));
    }
  }
}
