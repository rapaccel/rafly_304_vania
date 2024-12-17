import 'package:vania/vania.dart';

class CreateProductsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('products', () {
      id();
      string('prod_name', length: 50);
      text('prod_desc');
      integer('prod_price', length: 11);
      char('vend_id', length: 5);
      foreign('vend_id', 'vendor', 'vend_id',
          onDelete: 'cascade', onUpdate: 'cascade');
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('products');
  }
}
