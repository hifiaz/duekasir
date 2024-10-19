import 'package:due_kasir/model/inventory_model.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  const Cart({this.items = const <Inventory>[]});

  final List<Inventory> items;

  int get totalItem {
    return items.fold(0, (total, current) => total + current.quantity!.toInt());
  }

  double get totalPrice {
    return items.fold(
        0,
        (total, current) =>
            total +
            (current.diskonPersen == null
                ? (current.quantity!.toInt() * current.hargaJual!.toDouble())
                : (current.quantity!.toInt() *
                    (current.hargaJual!.toDouble() -
                        current.hargaJual!.toDouble() *
                            (current.diskonPersen! / 100)))));
  }

  @override
  List<Object> get props => [items];
}
