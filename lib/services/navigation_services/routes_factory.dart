part of 'navigation.dart';

abstract interface class RoutesFactory {
  Route<dynamic> createSplashPageRoute();
  Route<dynamic> createLoginPageRoute();
  Route<dynamic> createSignUpPageRoute();
  Route<dynamic> createHomePageRoute();
  Route<dynamic> createCartPageRoute();
  Route<dynamic> createProductsPageRoute(ProductModel model);
}
