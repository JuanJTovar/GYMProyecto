import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_kart/model/Product.dart';
import 'package:flutter_kart/model/hotel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsModel extends Model {
  List<Hotel> _hotelList = [];
  List<Product> _products = [];
  List<Product> _cartList = [];
  final baseUrl = 'http://api.flutterapp.in/api/';

  ProductsModel() {
    _products.add(Product(
      'Suplemento GOLD',
      '24g de proteína de suero de leche por porción',
      1100.00,
      'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRAXTLQrfdoUlE9WFgOcJK-5txHxLbhsCRKWMhheA4hV_388wkk7uibpY5Allm4JOY2jE_jYSmI1iwgO60Fq9Px3BrCpxfcNPG-NBH4bk7OPaXUfWIKs6mioA&usqp=CAY',
    ));

    _products.add(Product(
      'Suplemento Chocolate',
      'Aporta 18 gr de Proteína por porción',
      142.00,
      'https://cdn.shopify.com/s/files/1/1437/8626/products/MintChocolate_d7eac5df-6108-4a43-b331-895c3d9e5073_2048x.png?v=1559369114',
    ));


    _products.add(Product(
      'Suplemento TRIBULUS FIT',
      '120 Recuento para MuscleFit',
      940.00,
      'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcS6cMUeNx68mMzeOjpXCu1EJSBN5fnEWNJ7P9hnXRD8dOYEGKuA6QIS2wrs1RgXi03Y9svbRNiBkg7M7sTHzA81RXIvzhD7XxFNyHPfdYMjKhq91fR3j72x&usqp=CAY',
    ));

    _products.add(Product(
      'Suplemento Optimum nutrition',
      '30 g de proteína',
      1320.00,
      'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQD8eKCOhLWC7dqQDV5O2oEQcmAhSoS5fqFzMtOKWNPIThuqcZtP8OYKO3Axi6kr_bka6MyBuB17ifjmeCpZQmBUkgrTCWeZrtKRyNf-JqRry-y3SEgX1Cg&usqp=CAY',
    ));

    _products.add(Product(
      'Suplemento Super Multivitaminico',
      'El consumo de este producto es responsabilidad de quien lo consume',
      100,
      'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcR5qbJpNoW2vdf0uKIYvvPcvMCV10DwBkkjOzWmi4YOwFBvW1DSkR4lVHaNecqibFzqukg64b_Z4B-YDlTMZiaSYuSBBYyIjRVodRErw0xDWiqf-qsbRJ1P&usqp=CAY',
    ));

    _hotelList.add(Hotel(
        'GYM Tovar',
        'https://www.suplementoscdmx.com.mx/wp-content/uploads/2017/04/NEWBANERF-1260x420.jpg',
        'Cuahuatemoc, México',
        '20-30 Mins',
        4.2,
        500));

    _hotelList.add(Hotel(
        'GYM Leonardo',
        'https://www.suplementoscdmx.com.mx/wp-content/uploads/2016/10/suplementos-gym.jpg',
        'Madero, México',
        '30-40 Mins',
        4.3,
        500));

    _hotelList.add(Hotel(
        'GYM Carolina',
        'https://pbs.twimg.com/media/CvOrrWpUIAAt_SC.jpg:large',
        'Miguel Hidalgo, México',
        '25-30 Mins',
        4.0,
        500));

  }

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get getCartList {
    return List.from(_cartList);
  }

  List<Hotel> get getHotelList {
    return List.from(_hotelList);
  }

  double get getCartPrice {
    double price = 0;
    getCartList.forEach((Product pro) {
      price += pro.price;
    });
    return price;
  }

  void addProduct(Product product) {
    final Map<String, dynamic> productMap = {
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image':
          'https://www.dinneratthezoo.com/wp-content/uploads/2016/10/veggie-fried-rice-6-500x500.jpg',
    };

    http.post(
      baseUrl + 'products',
      body: json.encode(productMap),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then(
      (response) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      },
    );
    _products.add(product);
    notifyListeners();
  }

 getProductList() async {
  final data = await  http
        .get(
      baseUrl + 'products',
    )
        .then(
      (response) {
       
      },
    );
    
  }

  void addToCart(Product product) {
    _cartList.add(product);
    notifyListeners();
  }
}
