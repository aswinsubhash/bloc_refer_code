import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq_ecom/constants/images_assets.dart';
import 'package:norq_ecom/presentation/features/splash/cubit/splash_cubit.dart';
import 'package:norq_ecom/services/navigation_services/navigation_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<SplashCubit>(context).checkUserLoged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashInitial) {
          if (state.isUserLoggedIn) {
            NavigationServices().createHomePageRoute(context);
          } else {
            NavigationServices().createLoginPageRoute(context);
          }
        }
      },
      child: Scaffold(
        body: Container(
          color: const Color(0xff2382AA),
          alignment: Alignment.center,
          child:
              Image.asset(ImageAssets.splashIcon, alignment: Alignment.center),
        ),
      ),
    );
  }
}
