part of 'navigation.dart';

Route<dynamic>? Function(RouteSettings)? onGenerateAppRoute(
    RoutesFactory routesFactory) {
  return (RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return routesFactory.createSplashPageRoute();
      case RouteNames.login:
        return routesFactory.createLoginPageRoute();
      case RouteNames.signUp:
        return routesFactory.createSignUpPageRoute();
      case RouteNames.home:
        return routesFactory.createHomePageRoute();
      case RouteNames.cart:
        return routesFactory.createCartPageRoute();
      case RouteNames.products:
        return routesFactory
            .createProductsPageRoute(settings.arguments as ProductModel);
    }
    return null;
  };
}
