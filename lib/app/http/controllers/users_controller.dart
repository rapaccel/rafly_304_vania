import 'package:tugas/app/models/user.dart';
import 'package:vania/vania.dart';

class UsersController extends Controller {
  Future<Response> index() async {
    final users = await User().query().get();
    return Response.json(
        {'message': 'Berhasil Mendapatkan data Users', 'data': users});
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> login(Request request) async {
    request.validate({
      'email': 'required|email',
      'password': 'required',
    }, {
      'email.required': 'The email is required',
      'email.email': 'The email is not valid',
      'password.required': 'The password is required',
    });

    String email = request.input('email');
    String password = request.input('password').toString();

    final user = await User().query().where('email', email).first();

    if (user == null) {
      return Response.json({'message': 'User not found'});
    }

    if (!Hash().verify(password, user['password'])) {
      return Response.json({'message': 'Wrong password'});
    }

    Map<String, dynamic> token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(hours: 24), withRefreshToken: true);

    return Response.json(token);
  }

  Future<Response> store(Request request) async {
    request.validate({
      'name': 'required',
      'email': 'required',
      'password': 'required',
    });
    final data = {
      'name': request.input('name'),
      'email': request.input('email'),
      'password': Hash().make(request.input('password').toString()),
    };
    await User().query().insert(data);
    return Response.json(
        {'message': 'Berhasil Menambahkan data Users', 'data': data});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    request.validate({
      'name': 'required',
      'email': 'required',
      'password': 'required',
    });
    final data = {
      'name': request.input('name'),
      'email': request.input('email'),
      'password': Hash().make(request.input('password').toString()),
    };
    await User().query().where('id', id.toString()).update(data);
    return Response.json(
        {'message': 'Berhasil Mengupdate data Users', 'data': data});
  }

  Future<Response> destroy(int id) async {
    await User().query().where('id', '=', id.toString()).delete();
    return Response.json({'message': 'Berhasil Menghapus data Users'});
  }
}

final UsersController usersController = UsersController();
