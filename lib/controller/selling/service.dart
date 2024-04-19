import 'package:due_kasir/model/item_model.dart';

class CartService {
  final _items = <ItemModel>[];

  Future<List<ItemModel>> loadProducts() =>
      Future.delayed(const Duration(milliseconds: 100) * 10, () => _items);

  void add(ItemModel item) => _items.add(item);

  void remove(ItemModel item) => _items.remove(item);

  void clear() => _items.clear();
}
