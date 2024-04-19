import 'package:due_kasir/model/item_model.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  const Cart({this.items = const <ItemModel>[]});

  final List<ItemModel> items;

  double get totalPrice {
    return items.fold(0, (total, current) => total + current.hargaJual);
  }

  @override
  List<Object> get props => [items];
}
