import 'package:tugas/app/http/controllers/customers_controller.dart';
import 'package:tugas/app/http/controllers/order_items_controller.dart';
import 'package:tugas/app/http/controllers/orders_controller.dart';
import 'package:tugas/app/http/controllers/product_controller.dart';
import 'package:tugas/app/http/controllers/product_notes_controller.dart';
import 'package:tugas/app/http/controllers/users_controller.dart';
import 'package:tugas/app/http/controllers/vendors_controller.dart';
import 'package:vania/vania.dart';
import 'package:tugas/app/http/controllers/home_controller.dart';
import 'package:tugas/app/http/middleware/authenticate.dart';
import 'package:tugas/app/http/middleware/home_middleware.dart';
import 'package:tugas/app/http/middleware/error_response_middleware.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');
    Router.get('/customer', customersController.index);
    Router.post('/customer', customersController.store);
    Router.put('/customer/{id}', customersController.update);
    Router.delete('/customer/{id}', customersController.destroy);

    Router.get('/orders', ordersController.index);
    Router.post('/orders', ordersController.store);
    Router.put('/orders/{id}', ordersController.update);
    Router.delete('/orders/{id}', ordersController.destroy);

    Router.get('/vendors', vendorsController.index);
    Router.post('/vendors', vendorsController.store);
    Router.put('/vendors/{id}', vendorsController.update);
    Router.delete('/vendors/{id}', vendorsController.destroy);

    Router.get('/products', productController.index);
    Router.post('/products', productController.store);
    Router.put('/products/{id}', productController.update);
    Router.delete('/products/{id}', productController.destroy);

    Router.get('/order-items', orderItemsController.index);
    Router.post('/order-items', orderItemsController.store);
    Router.put('/order-items/{id}', orderItemsController.update);
    Router.delete('/order-items/{id}', orderItemsController.destroy);

    Router.get('/product-notes', productNotesController.index);
    Router.post('/product-notes', productNotesController.store);
    Router.put('/product-notes/{id}', productNotesController.update);
    Router.delete('/product-notes/{id}', productNotesController.destroy);

    Router.get('/users', usersController.index)
        .middleware([AuthenticateMiddleware()]);
    Router.post('/users', usersController.store);
    Router.put('/users', usersController.update)
        .middleware([AuthenticateMiddleware()]);
    Router.delete('/users', usersController.destroy)
        .middleware([AuthenticateMiddleware()]);
    Router.post('/login', usersController.login);

    Router.get("/home", homeController.index);

    Router.get("/hello-world", () {
      return Response.html('Hello World');
    }).middleware([HomeMiddleware()]);

    // Return error code 400
    Router.get('wrong-request',
            () => Response.json({'message': 'Hi wrong request'}))
        .middleware([ErrorResponseMiddleware()]);

    // Return Authenticated user data
    Router.get("/user", () {
      return Response.json(Auth().user());
    }).middleware([AuthenticateMiddleware()]);
  }
}
