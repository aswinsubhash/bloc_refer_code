import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq_ecom/presentation/features/Products/cubit/home_cubit.dart';
import 'package:norq_ecom/presentation/features/Products/ui/product_details_screen.dart';
import 'package:norq_ecom/services/api_services/models/products_model.dart';

class ProductDetailsBuilder {
  final ProductModel model;

  ProductDetailsBuilder({required this.model});
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(),
      child: ProductDetailsScreen(
        productModel: model,
      ),
    );
  }
}
