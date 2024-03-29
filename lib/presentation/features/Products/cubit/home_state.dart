part of 'home_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {
  final List<ProductModel> model;

  ProductsInitial({required this.model});
}

final class ProductsLoading extends ProductsState {}
