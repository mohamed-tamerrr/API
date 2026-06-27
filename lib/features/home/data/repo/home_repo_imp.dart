import 'package:API/core/network/api_exceptions.dart';
import 'package:API/core/network/api_service.dart';
import 'package:API/features/home/data/models/product_model.dart';
import 'package:API/features/home/data/repo/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImp implements HomeRepo {
  final ApiService apiService;

  HomeRepoImp({required this.apiService});

  @override
  Future<Either<Failure, List<ProductModel>>>
  getProducts() async {
    try {
      var data = await apiService.get(endPoint: 'products');
      return right(
        (data['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList(),
      );
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductFromPost>> postProducts() async {
    try {
      var data = await apiService.post(
        endPoint: 'products/add',
        data: {
          'title': 'Tamer Post',
        }, // Here You Should take DATA From User !!!!!
      );

      return Right(ProductFromPost.fromJson(data));
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductFromPost>>
  updateProduct() async {
    try {
      var data = await apiService.put(
        endPoint: 'products/1',
        data: {
          'title': 'Tamer Post',
        }, // Here You Should take DATA From User !!!!!
      );

      return Right(ProductFromPost.fromJson(data));
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      await apiService.delete(endpoint: 'products/$id');

      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(errorMessage: e.toString()));
    }
  }
}
