import 'package:tugas/app/models/customers.dart';
import 'package:vania/vania.dart';

class CustomersController extends Controller {
  Future<Response> index() async {
    final customers = await Customers().query().get();
    return Response.json(
        {'message': 'Berhasil Mendapatkan data Customers', 'data': customers});
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    request.validate({
      'cust_name': 'required',
      'cust_address': 'required',
      'cust_city': 'required',
      'cust_state': 'required',
      'cust_zip': 'required',
      'cust_country': 'required',
      'cust_telp': 'required',
    });
    await Customers().query().insert(request.body);
    return Response.json({
      'message': 'Berhasil Menambahkan data Customers',
      'data': request.body
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
      'cust_name': 'required',
      'cust_address': 'required',
      'cust_city': 'required',
      'cust_state': 'required',
      'cust_zip': 'required',
      'cust_country': 'required',
      'cust_telp': 'required',
      'id_user': 'required',
    });

    await Customers()
        .query()
        .where('cust_id', id.toString())
        .update(request.body);
    return Response.json({
      'message': 'Berhasil Mengupdate data Customers',
      'data': request.body
    });
  }

  Future<Response> destroy(int id) async {
    await Customers()
        .query()
        .where('cust_id', '=', id.toString())
        .delete()
        .timeout(Duration(seconds: 5));
    return Response.json({
      'message': 'Berhasil Menghapus data Customers',
    });
  }
}

final CustomersController customersController = CustomersController();
