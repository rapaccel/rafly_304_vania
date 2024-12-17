import 'package:tugas/app/models/customers.dart';
import 'package:vania/vania.dart';
import 'package:tugas/app/models/orders.dart';

class OrdersController extends Controller {
  Future<Response> index() async {
    final orders = await Orders().query().get();
    final cust = await Customers()
        .query()
        .where('cust_id', '=', orders[0]['cust_id'])
        .first();
    return Response.json({
      'message': 'Berhasil Mendapatkan data Orders',
      'data': orders,
      'cust': cust
    });
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    request.validate({
      'order_date': 'required',
      'cust_id': 'required',
    });
    final customer = await Customers()
        .query()
        .where('cust_id', '=', request.input('cust_id'))
        .first();
    if (customer == null) {
      return Response.json({'message': 'Customer tidak ditemukan'});
    }
    await Orders().query().insertGetId({
      'order_date': request.input('order_date'),
      'cust_id': request.input('cust_id'),
    });
    return Response.json({
      'message': 'Berhasil Menambahkan data Orders',
      'data': request.body,
      'customer': customer
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
      'order_date': 'required',
      'cust_id': 'required',
    });
    final customer = await Customers()
        .query()
        .where('cust_id', '=', request.input('cust_id'))
        .first();
    if (customer == null) {
      return Response.json({'message': 'Customer tidak ditemukan'});
    }
    await Orders().query().where('id', id.toString()).update(request.body);
    return Response.json({
      'message': 'Berhasil Mengupdate data Orders',
      'data': request.body,
      'customer': customer
    });
  }

  Future<Response> destroy(int id) async {
    await Orders()
        .query()
        .where('id', '=', id.toString())
        .delete()
        .timeout(Duration(seconds: 10));
    return Response.json(
        {'message': 'Berhasil Menghapus data Orders', 'id': id});
  }
}

final OrdersController ordersController = OrdersController();
