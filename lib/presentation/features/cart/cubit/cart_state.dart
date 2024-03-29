part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {
  final List<CartItem> model;
  final double totalValue;
  CartInitial({
    required this.totalValue,
    required this.model,
  });
}

final class CartLoading extends CartState {}
