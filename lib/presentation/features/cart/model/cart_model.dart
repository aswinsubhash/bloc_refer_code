import 'package:hive_flutter/hive_flutter.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartItem {
  @HiveField(0)
  final String productName;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final String image;
  @HiveField(3)
  int quantity;
  @HiveField(4)
  final int id;

  CartItem({
    required this.id,
    required this.productName,
    required this.price,
    required this.image,
    required this.quantity,
  });
}

class CartModel {
  List<CartItem> items;

  CartModel({required this.items});
}
