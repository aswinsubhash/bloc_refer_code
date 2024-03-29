import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norq_ecom/presentation/features/authentication/cubit/auth_cubit.dart';
import 'package:norq_ecom/presentation/features/cart/model/cart_model.dart';
import 'package:norq_ecom/presentation/features/Products/cubit/home_cubit.dart';
import 'package:norq_ecom/services/api_services/models/products_model.dart';
import 'package:norq_ecom/services/navigation_services/navigation_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<ProductsCubit>(context);
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          isLoading = true;
        } else if (state is UserLoggedOut) {
          isLoading = false;
          context.navigationService.createLoginPageRoute(context);
        }
      },
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                if (!isLoading) {
                  BlocProvider.of<AuthenticationCubit>(context).logOutUser();
                }
              },
              icon: const Icon(Icons.logout)),
          actions: [
            IconButton(
              onPressed: () {
                context.navigationService.createCartPageRoute(context);
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            )
          ],
        ),
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductsInitial) {
                final List<ProductModel> productsModel = state.model;
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.h,
                    childAspectRatio: .8,
                    crossAxisSpacing: 8.h,
                  ),
                  itemCount: state.model.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.navigationService.createProductsPageRoute(
                            context, productsModel[index]);
                      },
                      child: ItemCard(
                        id: productsModel[index].id,
                        image: productsModel[index].image,
                        price: productsModel[index].price,
                        title: productsModel[index].title,
                        isInCart:
                            cubit.isProductInCart(productsModel[index].id),
                        // model,
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      )),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.id,
    required this.isInCart,
  });

  final String title;
  final double price;
  final String image;
  final int id;
  final bool isInCart;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductsCubit>(context);
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
                  if (isInCart) {
                    cubit.removeFromCart(id);
                  } else {
                    cubit.addToCart(
                      CartItem(
                          productName: title,
                          price: price,
                          image: image,
                          quantity: 1,
                          id: id),
                    );
                  }
                },
                child:
                    isInCart ? const Text("Remove") : const Text("Add to Cart"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
