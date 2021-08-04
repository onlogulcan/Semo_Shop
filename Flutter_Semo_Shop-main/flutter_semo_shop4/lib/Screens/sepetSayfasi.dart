import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_semo_shop4/Helpers/api.dart';
import 'package:flutter_semo_shop4/Screens/sepetim.dart';
import 'package:flutter_semo_shop4/models/Kategoriler.dart';
import 'package:flutter_semo_shop4/models/Urun.dart';
import 'package:flutter_semo_shop4/models/Users.dart';
import 'package:jwt_decode/jwt_decode.dart';

class SepetimEkran extends StatefulWidget {
  double price;
  Urun product;
  int userid;
  String username;

  SepetimEkran({this.price, this.product, this.userid, this.username});

  //const SepetimEkran({Key key}) : super(key: key);

  @override
  _SepetimEkranState createState() => _SepetimEkranState();
}

class _SepetimEkranState extends State<SepetimEkran> {
  int quantity = 1;
  double price = 0;

  double totalprice = 0;
  Api api = new Api();
  List<Users> dataUser = [];
  List<Urun> dataurun = [];
  List<Categories> dataCategories = [];
  int selectedUrunId = 0;

  Urun selectedUrun = new Urun();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(jsonEncode(widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.product.name,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.orange),
        ),
        body: Column(
          children: [
            Card(
              child: Column(
                  children: [
                    Image.network(widget.product.pictureUrl),
                    Text("${widget.product.name}"),
                    Text("Fiyatı : ${widget.product.price}"),
                    Text("${widget.product.weight}"),
                    Text("Ürün Adeti : ${widget.product.stock}"),
                  ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: () {
                  setState(() {
                    price = widget.product.price;
                    api.addBasket(
                      quantity,
                      price,
                      widget.product.id,
                    );
                    print("quantity : $quantity");
                  });
                },
                child: Text(
                  "Siparişe Ekle",
                  style: TextStyle(color: Colors.black),
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (quantity > 0) {
                          price = widget.product.price;
                          quantity = quantity + 1;
                          price = widget.product.price * quantity;
                          api.addQuantity(
                            quantity,
                            price,
                            widget.product.id,
                          );
                          print('*********');
                          print(price);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    child: Text(
                      "+",
                      style: TextStyle(color: Colors.black),
                    )),
                Container(
                  child: Center(
                      child: Text(
                    quantity.toString(),
                    style: TextStyle(fontSize: 20),
                  )),
                  height: 30,
                  width: 30,
                  color: Colors.orange,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (quantity <= 0) {
                          quantity = 0;
                          price = 0;
                        } else {
                          setState(() {
                            price = widget.product.price;
                            quantity = quantity - 1;
                            price = widget.product.price * quantity;
                            print("price :  $price");
                            api.removeQuantity(
                              quantity,
                              price,
                              widget.product.id,
                            );
                          });
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    child: Text(
                      "-",
                      style: TextStyle(color: Colors.black),
                    )),
                Text("Price :  $price"),
              ],
            ),

          ],
        ));
  }
}
