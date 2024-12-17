import 'package:vania/vania.dart';

class CreateOrderItemsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('order_items', () {
      id();
      bigInt('order_num', unsigned: true);
      foreign('order_num', 'orders', 'id',
          onDelete: 'cascade', onUpdate: 'cascade');
      bigInt('prod_id', unsigned: true);
      foreign('prod_id', 'products', 'id',
          onDelete: 'cascade', onUpdate: 'cascade');
      integer('quantity');
      integer('size');
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('order_items');
  }
}
