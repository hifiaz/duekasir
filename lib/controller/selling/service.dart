import 'package:collection/collection.dart';
import 'package:due_kasir/model/inventory_model.dart';

class CartService {
  final _items = <Inventory>[];

  Future<List<Inventory>> loadProducts() =>
      Future.delayed(const Duration(milliseconds: 100) * 10, () => _items);

  void add(Inventory item) {
    final isSame = _items.firstWhereOrNull((val) => val.code == item.code);
    if (isSame != null) {
      final data = _items.firstWhere((val) => val.id == item.id);
      data.quantity = data.quantity! + 1;
    } else {
      _items.add(item);
    }
  }

  void update(Inventory item) {
    final isSame = _items.firstWhereOrNull((val) => val.code == item.code);
    if (isSame != null) {
      final data = _items.firstWhere((val) => val.id == item.id);
      data.quantity = data.quantity! + 1;
    }
  }

  void remove(Inventory item) => _items.remove(item);

  void clear() => _items.clear();
}
