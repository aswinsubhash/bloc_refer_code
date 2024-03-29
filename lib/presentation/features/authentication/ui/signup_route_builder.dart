import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq_ecom/presentation/features/authentication/cubit/auth_cubit.dart';
import 'package:norq_ecom/presentation/features/authentication/ui/signup_screen.dart';

class SignupRouteBuilder {
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: const SignupScreen(),
    );
  }
}
