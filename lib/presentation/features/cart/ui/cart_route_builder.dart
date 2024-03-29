import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq_ecom/presentation/features/Products/cubit/home_cubit.dart';
import 'package:norq_ecom/presentation/features/cart/cubit/cart_cubit.dart';
import 'package:norq_ecom/presentation/features/cart/ui/cart_screen.dart';

class CartRouteBuilder {
  Widget call(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(),
        ),
      ],
      child: const CartScreen(),
    );
  }
}
