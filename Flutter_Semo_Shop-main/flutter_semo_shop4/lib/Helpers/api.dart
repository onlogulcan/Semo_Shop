import 'dart:convert';
import 'dart:io';

import 'package:flutter_semo_shop4/models/Basket.dart';
import 'package:flutter_semo_shop4/models/Kategoriler.dart';
import 'package:flutter_semo_shop4/models/Orders.dart';
import 'package:flutter_semo_shop4/models/Urun.dart';
import 'package:flutter_semo_shop4/models/Users.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseurl = 'http://192.168.1.118:5000/api';
  static String token='';

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
  _getHeder(){
    return {
    'Content-type': 'application/json',
    'Accept': 'application/json'
    };
  }
  _getHederWithToken(){
    print('TokenDatas:'+Api.token);
    Map<String, String> q = {
      HttpHeaders.contentTypeHeader : 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer ${Api.token}'
    };
    return q;
  }
  Future<bool> login(String username, String password) async {
    print('login');
    final response = await http.post(Uri.parse(baseurl + '/Auth/login'),
        headers: _getHeder(),
        body: jsonEncode({
          "userName": username,
          "password": password,
        }));
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.statusCode);
      print(response.body);
      Api.token=jsonDecode(response.body);
      requestHeaders.addAll({ 'Authorization': 'Bearer $token',});
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data!');
    }
  }
  Future<bool>getRegister(String username,String password,String email, String phone,) async {

    final response = await http.post(Uri.parse(baseurl + '/Auth/register'),headers: _getHederWithToken(),body: jsonEncode({
      "username": username,
      "password": password,
      "email": email,
      "phone": phone,
    }) );
    print(response.body);
    if(response.statusCode==200) {
      print(response.statusCode);
      return true ;
    }
      else{
        print(response.statusCode);
        throw Exception('Failed to load data!');
      }

  }
  Future<List<Categories>> getCategory() async {
    return http
        .get(
      Uri.parse(baseurl + '/Categories/getall'),
    )
        .then((data) {
          print("getcategory:  ${data.statusCode}");
      print(json.decode(data.body));
      if (data.statusCode == 200) {
        List<Categories> a = [];
        Iterable list = json.decode(data.body);

        a = list.map((model) => Categories.fromJson(model)).toList();

        return a;
      }
      return null;
    });
  }
  Future<Categories> getCategori(int id) async {
    return http
        .get(
      Uri.parse(baseurl + '/Categories/getbyid?id=' + id.toString()),
    )
        .then((data) {
      print("getcategori:  ${data.statusCode}");
      print(json.decode(data.body));
      if (data.statusCode == 200) {
        Categories categories = Categories.fromJson(json.decode(data.body));

        return categories;
      }
      return null;
    });
  }
  Future<List<Urun>> getUrun() async {
    return http
        .get(
      Uri.parse(baseurl+ '/Products/getall'),
    )
        .then((data) {
      print("geturun:  ${data.statusCode}");
      print(json.decode(data.body));
      if (data.statusCode == 200) {
        List<Urun> a = [];
        Iterable list = json.decode(data.body);

        a = list.map((model) => Urun.fromJson(model)).toList();

        return a;
      }
      return null;
    });
  }
  Future<Urun> getidliUrun(int id) async {
    return http
        .get(
      Uri.parse(baseurl + '/Products/getall' + id.toString()),
    )
        .then((data) {
      print("getidliUrun:  ${data.statusCode}");
      print(json.decode(data.body));
      if (data.statusCode == 200) {
        Urun urun = Urun.fromJson(json.decode(data.body));

        return urun;
      }
      return null;
    });
  }

  Future<List<GetUSer>> getUser() async {
    return http
        .get(
      Uri.parse(baseurl+ '/Users/getall'),
      headers: _getHederWithToken(),
    )
        .then((data) {
      print("getUser:  ${data.statusCode}");
      print(json.decode(data.body));
      if (data.statusCode == 200) {
        List<GetUSer> a = [];
        Iterable list = json.decode(data.body);

        a = list.map((model) => GetUSer.fromJson(model)).toList();

        return a;
      }
      return null;
    });
  }
  Future<GetUSer> getUSers(int id) async {
    return http
        .get(
      Uri.parse(baseurl + '/Users/getall' + id.toString()),
      headers: _getHederWithToken(),
    )
        .then((data) {
      print("getidliUser:  ${data.statusCode}");
      print(json.decode(data.body));
      if (data.statusCode == 200) {
        GetUSer urun = GetUSer.fromJson(json.decode(data.body));

        return urun;
      }
      return null;
    });
  }



  Future<List<GetKategori>> getKategorist() async {
    return http
        .get(
      Uri.parse(baseurl+ '/Products/getbycategory'),
    )
        .then((data) {
      print("getKategorist:  ${data.statusCode}");
      print(json.decode(data.body));
     // print(json.encode(data.body));
      if (data.statusCode == 200) {
        List<GetKategori> a = [];
        Iterable list = json.decode(data.body);

        a = list.map((model) => GetKategori.fromJson(model)).toList();

        return a;
      }
      return null;
    });
  }

  Future<GetKategori> getKategori(int id) async {
    return http
        .get(
      Uri.parse(baseurl + '/Products/getbycategory' + id.toString()),
    )
        .then((data) {
      print("getKategori:  ${data.statusCode}");
      print(json.decode(data.body));
      if (data.statusCode == 200) {
        GetKategori b = GetKategori.fromJson(json.decode(data.body));

        return b;
      }
      return null;
    });
  }

  Future<List<Urun>>getKategoriurun( int id){
    return http
        .get(
      Uri.parse(baseurl+ '/Products/getbycategory?id=$id'),
    )
        .then((data) {
      print(data.body);
      // print("getKategoriurun:  ${data.statusCode}");
      print(json.decode(data.body));
      // print(json.encode(data.body));
      if (data.statusCode == 200) {
        List<Urun> a = [];
        Iterable list = json.decode(data.body);

        a = list.map((model) => Urun.fromJson(model)).toList();

        return a;
      }
      return null;
    });
  }
  Future<bool> addBasket(int quantity,double price,int productid, ) async {
    final response = await http.post(Uri.parse(baseurl + '/Baskets/addbasket'),
        headers: _getHederWithToken(),
        body: jsonEncode({
          "quantity": quantity,
          "totalprice" : price,
          "productid" : productid,
        }));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 ) {
      print(response.statusCode);
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data!');
    }
  }

  Future<bool>addQuantity (int quantity,double price,int productid, ) async {
    final response = await http.put(Uri.parse(baseurl + '/Baskets/addquantity'),
        headers: _getHederWithToken(),
        body: jsonEncode({
          "quantity": quantity,
          "totalprice" : price,
          "productid" : productid,

        }));
    print(response.body);
    print("add quantity : ${response.statusCode}");
    print("addquantity price :  $price");
    if (response.statusCode == 200 ) {
      print(response.statusCode);
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data!');
    }
  }
  Future<bool>removeQuantity (int quantity,double price,int productid, ) async {
    final response = await http.put(Uri.parse(baseurl + '/Baskets/removequantity'),
        headers: _getHederWithToken(),
        body: jsonEncode({
          "quantity": quantity,
          "totalPrice" : price,
          "productId" : productid,
        }));
    print(response.body);
    print("remove quantity : ${response.statusCode}");
    if (response.statusCode == 200 ) {
      print(response.statusCode);
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data!');
    }
  }

  Future<List<Basket>> deleteBasket() async {
    return http
        .delete(
      Uri.parse(baseurl + '/Baskets/deleteall'),
    )
        .then((data) {
      print("deleteBasket:  ${data.statusCode}");
      print('silindi');
      return null;
    });
  }

  Future<List<Basket>>deleteBasketProduct(int id , int productid,int quantity,int clientid,double totalprice,String deviceid) async {
    return http
        .delete(
      Uri.parse(baseurl + '/Baskets/deleteproduct'),
      headers: _getHederWithToken(),
      body:jsonEncode({
        "id": id,
        "productId": productid,
        "clientId": clientid,
        "quantity": quantity,
        "totalPrice": totalprice,
        "deviceId": deviceid,
      }),
    )
        .then((data) {
      print("deleteBasket:  ${data.statusCode}");
      print('silindi');
      return null;
    });
  }

  Future<List<Basket>>getBasket(){
    print(Uri.parse(baseurl+ '/Baskets/getall'));
    return http
        .get(
      Uri.parse(baseurl+ '/Baskets/getall'),
      headers: _getHederWithToken(),
    )
        .then((data) {
      print(data.body);
      print("get basket :  ${data.statusCode}");
      // print(json.encode(data.body));
      if (data.statusCode == 200) {
        List<Basket> a = [];
        Iterable list = json.decode(data.body);

        a = list.map((model) => Basket.fromJson(model)).toList();

        return a;
      }
      return null;
    });
  }

  //en son burda kaldın
  Future<Urun> getsepetiUrun(int id) async {
    return http
        .get(
      Uri.parse(baseurl + '/Products/getbyid?id=$id'),
    )
        .then((data) {
      print("getbyid:  ${data.statusCode}");
      print(json.decode(data.body));
      if (data.statusCode == 200) {
        Urun urun = Urun.fromJson(json.decode(data.body));

        return urun;
      }
      return null;
    });
  }

  Future<int>addOrder(int userid ,double totalprice , int ispaid,String date, String adress, int vade ) async {

    final response = await http.post(Uri.parse(baseurl + '/Orders/addorder'),
        headers: _getHeder(),
        body: jsonEncode({
          "id":0,
      "userId": userid,
      "totalprice": totalprice,
      "ispaid": ispaid,
      "date": date,
      "adress": adress,
       "vade" : vade,
    }) );
    print('addorder');
    print('id='+response.body);
    if(response.statusCode==200) {
      print(response.body);
      return int.parse(response.body) ;
    }
    else{
      print(response.body);
      throw Exception('Failed to load data!');
    }

  }


  Future<List<AddOrder>>getorder(int userId){
    return http
        .get(
      Uri.parse(baseurl+ '/Orders/getallbyuser?userId=$userId'),
      headers: _getHederWithToken(),
    )
        .then((data) {
      print(data.body);
      print("getorder :  ${data.statusCode}");
      print("getorder : ${json.decode(data.body)}");
      // print(json.encode(data.body));
      if (data.statusCode == 200) {
        List<AddOrder> a = [];
        Iterable list = json.decode(data.body);
        a = list.map((model) => AddOrder.fromJson(model)).toList();

        return a;
      }
      return null;
    });
  }

  Future<List<AddOrder>>getVadeliOrdeer(int i){
    return http
        .get(
      Uri.parse(baseurl+ '/Orders/getallbyvade?id=$i'),
      headers: _getHederWithToken(),
    )
        .then((data) {
      print(data.body);
       print("getVadeliOrdeer:  ${data.statusCode}");
      print(json.decode(data.body));
      // print(json.encode(data.body));
      if (data.statusCode == 200) {
        List<AddOrder> a = [];
        Iterable list = json.decode(data.body);
        a = list.map((model) => AddOrder.fromJson(model)).toList();
        return a;
      }
      return null;
    });
  }

  Future<double>getTotalPrice(){
    return http
        .get(
      Uri.parse(baseurl+ '/Baskets/gettotalprice'),
      headers: _getHederWithToken(),
    )
        .then((data) {
      print(data.body);
      print("gettotalprice :  ${data.statusCode}");
      // print(json.encode(data.body));
      if (data.statusCode == 200) {

        return double.parse(data.body);
      }
      return null;
    });
  }

  Future<bool> addOrderProduct( int productid, int orderid , int quantity , double price) async {

    final response = await http.post(Uri.parse(baseurl + '/OrderProducts/addorderproduct'),
        headers: _getHeder(),
        body: jsonEncode(
          {

            "productId": productid,
            "orderId": orderid,
            "quantity": quantity,
            "price": price,

        }));
    print('addorderProduct');
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.statusCode);
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data!');
    }
  }

  Future<bool>getBycode(String code){
    return http
        .get(
      Uri.parse(baseurl+ '/Discounts/getbycode?discountCode=$code'),
      headers: _getHederWithToken(),
    )
        .then((data) {
      print(data.body);
      print("getBycode :  ${data.statusCode}");
      // print(json.encode(data.body));
      if (data.statusCode == 200) {
        return true;
      }
      return false;
    });
  }





  // **********************


}


