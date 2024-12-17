import 'package:tugas/app/models/order_items.dart';
import 'package:tugas/app/models/orders.dart';
import 'package:tugas/app/models/products.dart';
import 'package:vania/vania.dart';

class OrderItemsController extends Controller {
  Future<Response> index() async {
    final orderItems = await OrderItems().query().get();
    return Response.json({
      'message': 'Berhasil Mendapatkan data OrderItems',
      'data': orderItems
    });
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    request.validate({
      'order_num': 'required',
      'prod_id': 'required',
      'size': 'required',
      'quantity': 'required',
    });
    final order = await Orders()
        .query()
        .where('id', '=', request.input('order_num'))
        .first();
    if (order == null) {
      return Response.json({'message': 'Order tidak ditemukan'});
    }
    final product = await Products()
        .query()
        .where('id', '=', request.input('prod_id'))
        .first();
    if (product == null) {
      return Response.json({'message': 'Product tidak ditemukan'});
    }
    final data = {
      'order_num': request.input('order_num'),
      'prod_id': request.input('prod_id'),
      'size': request.input('size'),
      'quantity': request.input('quantity'),
    };
    await OrderItems().query().insert(data);
    return Response.json({
      'message': 'Berhasil Menambahkan data OrderItems',
      'data': data,
      'order': order,
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
      'order_num': 'required',
      'prod_id': 'required',
      'size': 'required',
      'quantity': 'required',
    });
    final order = await Orders()
        .query()
        .where('id', '=', request.input('order_num'))
        .first();
    if (order == null) {
      return Response.json({'message': 'Order tidak ditemukan'});
    }
    final product = await Products()
        .query()
        .where('id', '=', request.input('prod_id'))
        .first();
    if (product == null) {
      return Response.json({'message': 'Product tidak ditemukan'});
    }
    final data = {
      'order_num': request.input('order_num'),
      'prod_id': request.input('prod_id'),
      'size': request.input('size'),
      'quantity': request.input('quantity'),
    };
    await OrderItems().query().where('id', id.toString()).update(data);
    return Response.json({
      'message': 'Berhasil Mengupdate data OrderItems',
      'data': data,
      'order': order,
      'product': product
    });
  }

  Future<Response> destroy(int id) async {
    await OrderItems().query().where('id', '=', id.toString()).delete();
    return Response.json({'message': 'Berhasil Menghapus data OrderItems'});
  }
}

final OrderItemsController orderItemsController = OrderItemsController();
