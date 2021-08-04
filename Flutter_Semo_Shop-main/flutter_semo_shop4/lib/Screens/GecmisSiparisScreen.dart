import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_semo_shop4/Helpers/LoadingWidget.dart';
import 'package:flutter_semo_shop4/Helpers/api.dart';
import 'package:flutter_semo_shop4/Screens/sepetim.dart';
import 'package:flutter_semo_shop4/models/Orders.dart';
import 'package:flutter_semo_shop4/models/Users.dart';

class GecmisSiparisScreen extends StatefulWidget {
  final int userId;
  const GecmisSiparisScreen({Key key, this.userId}) : super(key: key);

  @override
  _GecmisSiparisScreenState createState() => _GecmisSiparisScreenState();
}

class _GecmisSiparisScreenState extends State<GecmisSiparisScreen> {
  List<GetUSer> dataUSer = [];
  List<AddOrder> datas =[] ;
  Api api = new Api();
  int selectedOrderId =0 ;
  AddOrder addOrder = new AddOrder();
  bool isLoading = true ;

  @override
  void initState() {
    super.initState();
    getData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Geçmiş Siparişlerim",style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      bottomNavigationBar: bottomNAvigationBar(context),
      body:  isLoading ? LoadingWidget() : _bodyy(),
    );
  }
  
  bottomNAvigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_basket_outlined,
            color: Colors.orange,
          ),
          label: 'Sepetim',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.orange,
          ),
          label: 'Geri',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        print(index);
        if (index == 1) {
          Navigator.pop(context);
        } else if (index == 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SepetimScreen()));
        }
      },
    );
  }
  

  _bodyy() {
    if(selectedOrderId>0)
      return Text("dsadas");
    else{
    return ListView.builder(itemBuilder: (context,i){
          var q  = datas[i];
          return Card(
          child:ListTile(
            title:  Column(
              children: [
                Text("Adres: ${q.adress}"),
                Text("Date: ${q.date}"),
                Text("Total Price: ${q.totalPrice}"),
              ],
            ),
            subtitle:  Text("User ID: ${q.userId}"),
          ),
        );

      },
      itemCount: datas.length,
      );
    }

  }
  Future<void> getData(int userId) async {
    final result = await api.getorder(userId);
    if (result != null) {
      setState(() {
        print(jsonEncode(result));
        datas = result;
        isLoading = false ;
      });
    }
  }

  _isPaid(int i) {
    if(i == 1){
      return Text("ödendi");
    }else{
      return Text("ödenmedi");
    }
  }
}


