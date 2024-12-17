import 'package:vania/vania.dart';

class CreateProductNotesTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('product_notes', () {
      id();
      bigInt('prod_id', unsigned: true);
      foreign('prod_id', 'products', 'id',
          onDelete: 'cascade', onUpdate: 'cascade');
      text('note_text');
      date('note_date');
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('product_notes');
  }
}
