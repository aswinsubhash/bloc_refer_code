import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq_ecom/presentation/features/splash/cubit/splash_cubit.dart';
import 'package:norq_ecom/presentation/features/splash/ui/splash_screen.dart';

class SplashScreenRouteBuilder {
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: const SplashScreen(),
    );
  }
}
