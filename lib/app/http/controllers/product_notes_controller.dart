import 'package:tugas/app/models/product_notes.dart';
import 'package:tugas/app/models/products.dart';
import 'package:vania/vania.dart';

class ProductNotesController extends Controller {
  Future<Response> index() async {
    final productNotes = await ProductNotes().query().get();
    return Response.json({
      'message': 'Berhasil Mendapatkan data ProductNotes',
      'data': productNotes
    });
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    request.validate({
      'prod_id': 'required',
      'note_date': 'required',
      'note_text': 'required',
    });
    final product = await Products()
        .query()
        .where('id', '=', request.input('prod_id'))
        .first();
    if (product == null) {
      return Response.json({'message': 'Product tidak ditemukan'});
    }
    await ProductNotes().query().insert(request.body);
    return Response.json({
      'message': 'Berhasil Menambahkan data ProductNotes',
      'data': request.body,
      'product': product
    });
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    request.validate({
      'prod_id': 'required',
      'note_date': 'required',
      'note_text': 'required',
    });
    final product = await Products()
        .query()
        .where('id', '=', request.input('prod_id'))
        .first();
    if (product == null) {
      return Response.json({'message': 'Product tidak ditemukan'});
    }
    await ProductNotes()
        .query()
        .where('id', id.toString())
        .update(request.body);
    return Response.json({
      'message': 'Berhasil Mengupdate data ProductNotes',
      'data': request.body,
      'product': product
    });
  }

  Future<Response> destroy(int id) async {
    await ProductNotes().query().where('id', '=', id.toString()).delete();
    return Response.json({'message': 'Berhasil Menghapus data ProductNotes'});
  }
}

final ProductNotesController productNotesController = ProductNotesController();
