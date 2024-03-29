// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:norq_ecom/presentation/features/cart/model/cart_model.dart';
import 'package:norq_ecom/services/api_services/api_client.dart';
import 'package:norq_ecom/services/api_services/models/products_model.dart';
import 'package:norq_ecom/services/hive_services/hive_boxes.dart';
import 'package:norq_ecom/services/hive_services/hive_services.dart';
import 'package:norq_ecom/utils/console_log.dart';

part 'home_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial(model: const [])) {
    init();
  }

  late final ApiClient _apiClient;
  List<ProductModel> _productModel = [];
  List<CartItem> cartData = [];
  late final HiveService hiveService;
  void init() {
    consoleLog("Initialising Home Cubut");
    _apiClient = ApiClient();
    hiveService = HiveService();
    regiseterCartAdapter();
    getInitial();
  }

  void getInitial() async {
    try {
      emit(ProductsLoading());
      consoleLog("Initial Api calling");
      final response = await _apiClient.getRequest("/products");
      await getDataFromBox();
      _productModel = ProductModel.fromList(response);
      emit(ProductsInitial(model: _productModel));
    } catch (error, stackTrace) {
      consoleLog(
        "Error while getting initial data \n ",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void regiseterCartAdapter() {
    HiveService().registerAdapters(CartItemAdapter());
  }

  Future<void> getDataFromBox() async {
    cartData.clear();
    final cartResponse = await HiveService().getAllData(HiveBoxes.cartBox);
    for (int i = 0; i < cartResponse.length; i++) {
      cartData.add(cartResponse[i]);
    }
  }

  void addToCart(CartItem data) async {
    try {
      final index = cartData.indexWhere((item) => item.id == data.id);
      if (index != 1) {
        await hiveService.saveData(HiveBoxes.cartBox, data);
      } else {
        consoleLog("Already In cart");
      }
      await getDataFromBox();
      emit(ProductsInitial(model: _productModel));
    } catch (erorr, stackTrace) {
      emit(ProductsInitial(model: _productModel));
      consoleLog("Error while add to cart: ",
          error: erorr, stackTrace: stackTrace);
    }
  }

  void removeFromCart(int id) async {
    try {
      final index = cartData.indexWhere((item) => item.id == id);
      if (index != -1) {
        // Remove the cart item from the cartData list
        cartData.removeAt(index);
        // Update the Hive box with the new cart data
        await hiveService.updateAllData(HiveBoxes.cartBox, cartData);
        await getDataFromBox();
        // Emit a new state with the updated product model and cart data
        emit(ProductsInitial(model: _productModel));
      }
    } catch (error, statckTrace) {
      consoleLog("Error while removing from cart: ",
          error: error, stackTrace: statckTrace);
    }
  }

  bool isProductInCart(int productId) {
    // Iterate through the list of cart items
    for (var products in cartData) {
      // Check if the current cart item has the same ID as the given product ID
      if (products.id == productId) {
        return true;
      }
    }
    return false;
  }
}
