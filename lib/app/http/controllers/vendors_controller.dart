import 'dart:math';

import 'package:tugas/app/models/vendors.dart';
import 'package:vania/vania.dart';

class VendorsController extends Controller {
  Future<Response> index() async {
    final vendors = await Vendors().query().get();
    return Response.json(
        {'message': 'Berhasil Mendapatkan data Vendors', 'data': vendors});
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    request.validate({
      'vend_name': 'required',
      'vend_address': 'required',
      'vend_kota': 'required',
      'vend_state': 'required',
      'vend_zip': 'required',
      'vend_country': 'required',
    });
    final data = {
      // create random vend_id with format number
      'vend_id': '${Random().nextInt(1000)}',
      'vend_name': request.input('vend_name'),
      'vend_address': request.input('vend_address'),
      'vend_kota': request.input('vend_kota'),
      'vend_state': request.input('vend_state'),
      'vend_zip': request.input('vend_zip'),
      'vend_country': request.input('vend_country'),
    };
    await Vendors().query().insert(data);
    return Response.json(
        {'message': 'Berhasil Menambahkan data Vendors', 'data': data});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    request.validate({
      'vend_name': 'required',
      'vend_address': 'required',
      'vend_kota': 'required',
      'vend_state': 'required',
      'vend_zip': 'required',
      'vend_country': 'required',
      'vend_telp': 'required',
    });
    final data = {
      'vend_name': request.input('vend_name'),
      'vend_address': request.input('vend_address'),
      'vend_kota': request.input('vend_kota'),
      'vend_state': request.input('vend_state'),
      'vend_zip': request.input('vend_zip'),
      'vend_country': request.input('vend_country'),
    };
    await Vendors()
        .query()
        .where('vend_id'.toString(), '=', '$id')
        .update(data);
    return Response.json(
        {'message': 'Berhasil Mengupdate data Vendors', 'data': data});
  }

  Future<Response> destroy(int id) async {
    await Vendors().query().where('vend_id', '=', id.toString()).delete();
    return Response.json(
        {'message': 'Berhasil Menghapus data Vendors dengan id $id'});
  }
}

final VendorsController vendorsController = VendorsController();
