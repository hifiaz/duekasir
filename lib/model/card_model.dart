import 'package:due_kasir/model/item_model.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  const Cart({this.items = const <ItemModel>[]});

  final List<ItemModel> items;

  int get totalItem {
    return items.fold(0, (total, current) => total + current.quantity);
  }

  double get totalPrice {
    return items.fold(
        0,
        (total, current) =>
            total +
            (current.diskonPersen == null || current.diskonPersen == 0.0
                ? (current.quantity * current.hargaJual)
                : (current.quantity * (current.hargaJual - current.hargaJual * (current.diskonPersen! / 100)))));
  }

  @override
  List<Object> get props => [items];
}
