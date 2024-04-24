import 'package:collection/collection.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/controller/selling/events.dart';
import 'package:due_kasir/controller/selling/service.dart';
import 'package:due_kasir/enum/payment_enum.dart';
import 'package:due_kasir/model/card_model.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/model/pembeli_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class SellingController {
  SellingController(this._cartService);
  final CartService _cartService;
  final isSearch = Signal(false);
  final tipeBayar = Signal(TypePayment.qris);
  final pelanggan = Signal<PembeliModel?>(null);
  final kasir = Signal<UserModel?>(null);
  final selectedPrint = Signal<String?>(null);

  late final _cart = signal<AsyncState<Cart>>(AsyncLoading());
  ReadonlySignal<AsyncState<Cart>> get cart => _cart;

  Future<void> dispatch(CartEvent event) async {
    switch (event) {
      case CartStarted():
        _cart.value = AsyncLoading();
        _cartService
            .loadProducts()
            .then((items) => _cart.value = AsyncData(Cart(items: [...items])))
            // ignore: invalid_return_type_for_catch_error
            .catchError((e, s) => _cart.set(AsyncError(e, s)));

      case CartItemAdded(:final item):
        if (_cart.value case AsyncData<Cart>(:final value)) {
          try {
            final isSame = _cart.value.value?.items
                .firstWhereOrNull((val) => val.code == item.code);
            _cartService.add(item);
            if (isSame != null) {
              _cart.value = AsyncData(Cart(items: [...value.items, item]));
              _cart.value = AsyncData(
                Cart(
                  items: [...value.items]..remove(event.item),
                ),
              );
            } else {
              _cart.value = AsyncData(Cart(items: [...value.items, item]));
            }
          } catch (e, s) {
            _cart.value = AsyncError(e, s);
          }
        }

      case CartItemRemoved(:final item):
        if (_cart.value case AsyncData<Cart>(:final value)) {
          try {
            _cartService.remove(item);
            _cart.value = AsyncData(
              Cart(
                items: [...value.items]..remove(event.item),
              ),
            );
          } catch (e, s) {
            _cart.value = AsyncError(e, s);
          }
        }

      case CartPaid():
        _cart.value = AsyncLoading();
        _cartService.clear();
        _cart.value = AsyncData(const Cart());
    }
  }

  Future<void> updateBatch(List<ItemModel> items) async {
    await Future.forEach<ItemModel>(items, (i) async {
      final item = i..jumlahBarang = i.jumlahBarang - i.quantity;
      await Database().updateInventory(item);
    });
    Future.delayed(Durations.short1).then((_) {
      Database().searchInventorys('').then((val) {
        inventoryController.inventorySearch.clear();
        inventoryController.inventorySearch.addAll(val);
      });
    });
  }
}
