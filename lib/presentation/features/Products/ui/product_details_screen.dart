import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norq_ecom/presentation/features/Products/cubit/home_cubit.dart';
import 'package:norq_ecom/presentation/features/cart/model/cart_model.dart';
import 'package:norq_ecom/services/api_services/models/products_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final ProductsCubit cubit = BlocProvider.of<ProductsCubit>(context);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsInitial) {
            return Scaffold(
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    Image.network(productModel.image),
                    const SizedBox(height: 24),
                    Text(
                      productModel.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Price: ${productModel.price}",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: 50.h,
                color: const Color(0XFF2381AA),
                child: TextButton(
                  onPressed: () {
                    if (cubit.isProductInCart(productModel.id)) {
                      cubit.removeFromCart(productModel.id);
                    } else {
                      cubit.addToCart(
                        CartItem(
                            productName: productModel.title,
                            price: productModel.price,
                            image: productModel.image,
                            quantity: 1,
                            id: productModel.id),
                      );
                    }
                  },
                  child: cubit.isProductInCart(productModel.id)
                      ? const Text(
                          "Remove",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                      : const Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
