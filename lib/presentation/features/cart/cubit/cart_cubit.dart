import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:norq_ecom/presentation/features/cart/model/cart_model.dart';
import 'package:norq_ecom/services/hive_services/hive_boxes.dart';
import 'package:norq_ecom/services/hive_services/hive_services.dart';
import 'package:norq_ecom/utils/console_log.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial(model: const [], totalValue: 0.0)) {
    init();
  }

  late final HiveService hiveService;
  List<CartItem> cartData = [];
  void init() {
    hiveService = HiveService();
    getDataFromBox();
  }

  Future<void> getDataFromBox() async {
    try {
      cartData.clear();
      emit(CartLoading());
      final response = await HiveService().getAllData(HiveBoxes.cartBox);

      for (int i = 0; i < response.length; i++) {
        cartData.add(response[i]);
      }
      emit(CartInitial(model: cartData, totalValue: getTotalCartValue()));
      consoleLog(cartData.toString());
    } catch (error, stackTrace) {
      consoleLog("Error while loading cart items",
          error: error, stackTrace: stackTrace);
    }
  }

  void removeItemFromCart(int id) async {
    try {
      final index = cartData.indexWhere((item) => item.id == id);
      if (index != -1) {
        // Remove the cart item from the cartData list
        cartData.removeAt(index);
        // Update the Hive box with the new cart data
        await hiveService.updateAllData(HiveBoxes.cartBox, cartData);
        await getDataFromBox();
        // Emit a new state with the updated product model and cart data
        emit(CartInitial(model: cartData, totalValue: getTotalCartValue()));
      }
    } catch (error, statckTrace) {
      consoleLog("Error while removing from cart: ",
          error: error, stackTrace: statckTrace);
    }
  }

  void incrementAndUpdate(int index) async {
    try {
      cartData[index].quantity++;
      await hiveService.updateAllData(HiveBoxes.cartBox, cartData);
      await getDataFromBox();
      emit(CartInitial(model: cartData, totalValue: getTotalCartValue()));
    } catch (error, stackTrace) {
      consoleLog("Error while incrementing qty: ",
          error: error, stackTrace: stackTrace);
    }
  }

  double getTotalCartValue() {
    double totalValue = 0;
    for (var item in cartData) {
      totalValue += item.price * item.quantity;
    }
    return totalValue.roundToDouble();
  }

  void decrementAndUpdate(int index) async {
    try {
      if (cartData[index].quantity > 1) {
        cartData[index].quantity--;
        await hiveService.updateAllData(HiveBoxes.cartBox, cartData);
        await getDataFromBox();
        emit(CartInitial(model: cartData, totalValue: getTotalCartValue()));
      }
    } catch (error, stackTrace) {
      consoleLog("Error while decrementing qty: ",
          error: error, stackTrace: stackTrace);
    }
  }
}
