part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  String errorMessage;
  HomeFailure(this.errorMessage);
}

final class GetProductsSuccess extends HomeState {
  final List<ProductModel> products;

  GetProductsSuccess({required this.products});
}

class PostProductSuccess extends HomeState {
  final ProductFromPost product;

  PostProductSuccess(this.product);
}

class UpdateProductSuccess extends HomeState {
  final ProductFromPost product;

  UpdateProductSuccess(this.product);
}

class DeleteProductSuccess extends HomeState {}
