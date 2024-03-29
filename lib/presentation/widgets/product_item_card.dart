import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norq_ecom/presentation/features/cart/model/cart_model.dart';
import 'package:norq_ecom/presentation/features/Products/cubit/home_cubit.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.id,
  });

  final String title;
  final double price;
  final String image;
  final int id;
  @override
  Widget build(BuildContext context) {
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
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ProductsCubit>(context).addToCart(
                    CartItem(
                        productName: title,
                        price: price,
                        image: image,
                        quantity: 1,
                        id: id),
                  );
                },
                child: const Text("Add to Cart"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
