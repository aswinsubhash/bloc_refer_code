// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:norq_ecom/services/cloud_services/firebase/autherization.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial(isUserLoggedIn: false));

  final Authentication _auth = Authentication();

  void checkUserLoged() async {
    final bool isLogged = await _auth.isLoggedIn();
    emit(SplashInitial(isUserLoggedIn: isLogged));
  }
}
