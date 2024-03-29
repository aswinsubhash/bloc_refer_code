// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:norq_ecom/services/cloud_services/firebase/autherization.dart';
import 'package:norq_ecom/utils/console_log.dart';

part 'auth_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuhtInitial(success: false, message: "")) {
    init();
  }

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final Authentication _authentication;
  late final GlobalKey<FormState> formKey;

  void init() {
    consoleLog("initializing login cubit");
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _authentication = Authentication();
    formKey = GlobalKey<FormState>();
  }

  void loginWithEmail() async {
    try {
      consoleLog(
          "Login with email:${emailController.text} password: ${passwordController.text}");
      emit(AuthLoading());
      final response = await _authentication.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      consoleLog("response_body: $response");
      emit(AuhtInitial(
          success: response['success'], message: response['message']));
    } catch (error, stackTrace) {
      consoleLog("Failed To Login with Email",
          error: error, stackTrace: stackTrace);
    }
  }

  void signUpWithEmai() async {
    try {
      emit(AuthLoading());
      consoleLog(
          "Signup with email:${emailController.text} password: ${passwordController.text}");
      final response = await _authentication.signUpWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      consoleLog("response_body: $response");
      emit(AuhtInitial(
          success: response['success'], message: response['message']));
    } catch (error, stackTrace) {
      consoleLog("Failed To Signup with Email",
          error: error, stackTrace: stackTrace);
    }
  }

  void logOutUser() async {
    try {
      emit(AuthLoading());
      await _authentication.signOut();
      emit(UserLoggedOut());
    } catch (error, stackTrace) {
      consoleLog("Error while logging out: ",
          error: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> close() {
    consoleLog("closing login cubit");
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
