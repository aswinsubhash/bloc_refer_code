import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq_ecom/presentation/features/authentication/cubit/auth_cubit.dart';
import 'package:norq_ecom/presentation/features/authentication/ui/logn_screen.dart';

class LoginRouteBuilder {
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: const LoginScreen(),
    );
  }
}
