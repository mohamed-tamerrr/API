import 'package:API/features/home/data/models/product_model.dart';
import 'package:API/features/home/data/repo/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(HomeInitial());
  final HomeRepo homeRepo;

  /// Get Products
  Future<void> getProducts() async {
    emit(HomeLoading());
    final response = await homeRepo.getProducts();

    response.fold(
      (failure) {
        emit(HomeFailure(failure.errorMessage));
      },
      (res) {
        emit(GetProductsSuccess(products: res));
      },
    );
  }

  Future<void> postProducts() async {
    emit(HomeLoading());
    final response = await homeRepo.postProducts();

    response.fold(
      (failure) => emit(HomeFailure(failure.errorMessage)),
      (res) => emit(PostProductSuccess(res)),
    );
  }

  Future<void> updateProduct({
    required int id,
    required String title,
  }) async {
    final response = await homeRepo.updateProduct();

    response.fold(
      (failure) => emit(HomeFailure(failure.errorMessage)),
      (product) => emit(UpdateProductSuccess(product)),
    );
  }

  Future<void> deleteProduct(int id) async {
    final response = await homeRepo.deleteProduct(id);

    response.fold(
      (failure) {
        emit(HomeFailure(failure.errorMessage));
      },
      (_) {
        emit(DeleteProductSuccess());
      },
    );
  }
}
