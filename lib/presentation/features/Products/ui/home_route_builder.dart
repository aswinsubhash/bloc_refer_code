import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq_ecom/presentation/features/authentication/cubit/auth_cubit.dart';
import 'package:norq_ecom/presentation/features/Products/cubit/home_cubit.dart';
import 'package:norq_ecom/presentation/features/Products/ui/home_screen.dart';

class HomeScreenBuilder {
  Widget call(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit(),
        ),
        BlocProvider(
          create: (context) => AuthenticationCubit(),
        ),
      ],
      child: const HomeScreen(),
    );
  }
}
