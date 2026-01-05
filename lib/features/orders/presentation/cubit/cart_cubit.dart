import 'package:e_commerce/core/base/base_cubit.dart';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/orders/domain/entity/cart_item_entity.dart';
import 'package:e_commerce/features/orders/domain/repo/cart_repo.dart';
import 'package:e_commerce/features/orders/presentation/cubit/cart_state.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CartCubit extends BaseCubit<CartState, CartAction, void> {
  CartCubit() : super(CartState());
  final CartRepo _cartRepo = getIt();

  @override
  Future<void> doAction(CartAction action) async {
    switch (action) {
      case AddProductToCart():
        await _addProductToCart(action.productId);
      case DeleteProductFromCart():
        await _removeProductFromCart(action.productId);
      case LoadCartItems():
        await _loadCartItems();
      case UpdateCartItems():
        await _updateCartItems(action.count, action.productId);
    }
  }

  Future<void> _updateCartItems(int count, String productId) async {
    // Update UI immediately - find and update the item in the current list
    final currentItems = state.cartItems.data ?? [];
    final updatedItems = currentItems.map((item) {
      if (item.id == productId) {
        // Create new item with updated count
        return CartItemEntity(
          id: item.id,
          title: item.title,
          price: item.price,
          imageCover: item.imageCover,
          count: count, // Update the count
        );
      }
      return item;
    }).toList();

    // Emit immediately with updated count
    safeEmit(state.copyWith(cartItems: BaseStatus.success(data: updatedItems)));

    // Then make API call
    var response = await _cartRepo.updateCartItem(productId, count.toString());

    switch (response) {
      case Success<List<CartItemEntity>>():
        // Update with server response
        safeEmit(
          state.copyWith(cartItems: BaseStatus.success(data: response.data)),
        );

      case Failure<List<CartItemEntity>>():
        // On failure, reload to get correct state
        await _loadCartItems();
        safeEmit(
          state.copyWith(
            cartItems: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }

  Future<void> _loadCartItems() async {
    safeEmit(
      state.copyWith(cartItems: BaseStatus.loading(data: state.cartItems.data)),
    );
    var response = await _cartRepo.getCartItem();
    switch (response) {
      case Success<List<CartItemEntity>>():
        safeEmit(
          state.copyWith(
            cartItems: BaseStatus.success(data: response.data ?? []),
          ),
        );

      case Failure<List<CartItemEntity>>():
        safeEmit(
          state.copyWith(
            cartItems: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }

  Future<void> _removeProductFromCart(String productId) async {
    // Update UI immediately - remove from current list
    final currentItems = state.cartItems.data ?? [];
    final updatedItems = currentItems
        .where((item) => item.id != productId)
        .toList();

    safeEmit(state.copyWith(cartItems: BaseStatus.success(data: updatedItems)));

    var response = await _cartRepo.deleteCartItem(productId);
    switch (response) {
      case Success<String>():
        safeEmit(
          state.copyWith(
            deleteProductFromCart: BaseStatus.success(data: response.data),
          ),
        );

      case Failure<String>():
        // On failure, reload to get correct state
        await _loadCartItems();
        safeEmit(
          state.copyWith(
            deleteProductFromCart: BaseStatus.failure(
              message: response.message,
            ),
          ),
        );
    }
  }

  Future<void> _addProductToCart(String productId) async {
    // Update UI immediately - add temp item
    final currentItems = state.cartItems.data ?? [];
    final tempItem = CartItemEntity(
      id: productId,
      title: "Loading...",
      price: 0,
      imageCover: "",
      count: 1, // Start with count 1
    );

    final updatedItems = [...currentItems, tempItem];

    safeEmit(state.copyWith(cartItems: BaseStatus.success(data: updatedItems)));

    var response = await _cartRepo.addProductToCart(productId);

    switch (response) {
      case Success<String>():
        // Reload to get actual data
        await _loadCartItems();
        safeEmit(
          state.copyWith(addProduct: BaseStatus.success(data: response.data)),
        );

      case Failure<String>():
        // On failure, remove temp item
        final correctedItems = currentItems
            .where((item) => item.id != productId)
            .toList();
        safeEmit(
          state.copyWith(
            cartItems: BaseStatus.success(data: correctedItems),
            addProduct: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }
}
