import 'package:API/core/network/api_exceptions.dart';
import 'package:API/features/home/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, ProductFromPost>> postProducts();
  Future<Either<Failure, ProductFromPost>> updateProduct();
  Future<Either<Failure, void>> deleteProduct(int id);
}
