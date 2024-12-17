import 'package:tugas/app/models/products.dart';
import 'package:tugas/app/models/vendors.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  Future<Response> index() async {
    final products = await Products().query().get();
    return Response.json(
        {'message': 'Berhasil Mendapatkan data Products', 'data': products});
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    request.validate({
      'prod_name': 'required',
      'prod_price': 'required',
      'prod_desc': 'required',
      'vend_id': 'required',
    });
    final vendor = await Vendors()
        .query()
        .where('vend_id', '=', request.input('vend_id'))
        .first();
    if (vendor == null) {
      return Response.json({'message': 'Vendor tidak ditemukan'});
    }
    final data = {
      'prod_name': request.input('prod_name'),
      'prod_price': request.input('prod_price'),
      'prod_desc': request.input('prod_desc'),
      'vend_id': request.input('vend_id'),
    };
    await Products().query().insert(data);
    return Response.json({
      'message': 'Berhasil Menambahkan data Products',
      'data': data,
      'vendor': vendor
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
      'prod_name': 'required',
      'prod_price': 'required',
      'prod_desc': 'required',
      'vend_id': 'required',
    });
    final vendor = await Vendors()
        .query()
        .where('vend_id', '=', request.input('vend_id'))
        .first();
    if (vendor == null) {
      return Response.json({'message': 'Vendor tidak ditemukan'});
    }
    final data = {
      'prod_name': request.input('prod_name'),
      'prod_price': request.input('prod_price'),
      'prod_desc': request.input('prod_desc'),
      'vend_id': request.input('vend_id'),
    };
    await Products().query().where('id', id.toString()).update(data);
    return Response.json({
      'message': 'Berhasil Mengupdate data Products',
      'data': data,
      'vendor': vendor
    });
  }

  Future<Response> destroy(int id) async {
    await Products().query().where('id', '=', id.toString()).delete();
    return Response.json({'message': 'Berhasil Menghapus data Products'});
  }
}

final ProductController productController = ProductController();
