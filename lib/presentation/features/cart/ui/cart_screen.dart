import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norq_ecom/presentation/features/cart/cubit/cart_cubit.dart';
import 'package:norq_ecom/presentation/features/cart/model/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            final List<CartItem> cartModel = state.model;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Cart"),
                centerTitle: true,
              ),
              body: Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.h,
                    childAspectRatio: .8,
                    crossAxisSpacing: 8.h,
                  ),
                  itemCount: state.model.length,
                  itemBuilder: (context, index) {
                    return CartItemCard(
                      id: cartModel[index].id,
                      image: cartModel[index].image,
                      price: cartModel[index].price,
                      title: cartModel[index].productName,
                      qty: cartModel[index].quantity,
                      index: index,
                    );
                  },
                ),
              ),
              bottomNavigationBar: Container(
                  height: 50.h,
                  alignment: Alignment.center,
                  color: const Color(0XFF2381AA),
                  child: Text(
                    "Total: ${state.totalValue}",
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  )),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.id,
    required this.qty,
    required this.index,
  });

  final String title;
  final double price;
  final String image;
  final int id;
  final int qty;
  final int index;
  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<HomeCubit>(context);
    return Container(
      height: 214.h,
      width: 163.w,
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1.h,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            image,
            height: 98.h,
            width: 78.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3.h),
              Text(
                price.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  QuantityButton(
                    quantity: qty,
                    onIncrement: (qty) {
                      BlocProvider.of<CartCubit>(context)
                          .incrementAndUpdate(index);
                    },
                    onDecrement: (qty) {
                      BlocProvider.of<CartCubit>(context)
                          .decrementAndUpdate(index);
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<CartCubit>(context)
                            .removeItemFromCart(id);
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final int quantity;
  final Function(int) onIncrement;
  final Function(int) onDecrement;

  const QuantityButton({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (quantity > 1) {
              onDecrement(quantity);
            }
          },
        ),
        Text(
          '$quantity',
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            onIncrement(quantity);
          },
        ),
      ],
    );
  }
}
