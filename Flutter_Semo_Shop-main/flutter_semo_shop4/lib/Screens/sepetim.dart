import 'package:flutter/material.dart';
import 'package:flutter_semo_shop4/Helpers/LoadingWidget.dart';
import 'package:flutter_semo_shop4/Helpers/api.dart';
import 'package:flutter_semo_shop4/Screens/GecmisSiparisScreen.dart';
import 'package:flutter_semo_shop4/Screens/sepetSayfasi.dart';
import 'package:flutter_semo_shop4/models/Basket.dart';
import 'package:flutter_semo_shop4/models/Orders.dart';
import 'package:flutter_semo_shop4/models/Urun.dart';
import 'package:flutter_semo_shop4/models/Users.dart';
import 'package:http/http.dart' as http;

class SepetimScreen extends StatefulWidget {
  GetUSer user;
  double price;

  SepetimScreen({this.price,this.user});

  @override
  _SepetimScreenState createState() => _SepetimScreenState();
}

class _SepetimScreenState extends State<SepetimScreen> {
  List<GetUSer> dataUSer = [];
  TextEditingController adress = TextEditingController();
  TextEditingController kupon = TextEditingController();
  TextEditingController vadezamani = TextEditingController();
  int ispaid = 0 ;
  Api api = new Api();
  Urun secilenurun = new Urun();
  List<Urun> dataurun = [];
  List<Basket> datas = [];
  int selectedUrunId = 0;
  Basket selectedBasked = new Basket();
  int selectedBaskedId = 0;
  bool isLoading = true;

  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _getDatas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Semo Shop ",
          style: TextStyle(color: Colors.black, fontSize: 32),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.orange,
        ),
      ),
      bottomNavigationBar: _bottomNavigatorBar(context),
      body:  isLoading ? LoadingWidget() : _body(),
    );
  }

  _body() {
    if (selectedUrunId > 0)
      return Text(secilenurun.id.toString());
    else {
      return Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemBuilder: (
                    context,
                    i,
                    ) {
                  var q = dataurun[i];
                  return Dismissible(
                    background: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          child: Icon(
                            Icons.restore_from_trash_outlined,
                            color: Colors.black,
                            size: 100,
                          ),
                          color: Colors.red,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      api
                          .deleteBasketProduct(
                          datas[i].id,
                          q.id,
                          datas[i].quantity,
                          datas[i].clientId,
                          q.price,
                          null)
                          .then((value) {
                        if (value != null)
                          setState(() {
                            datas.remove(datas[i]);
                            dataurun.remove(dataurun[i]);
                          });
                      });
                    },
                    key: Key(datas[i].id.toString()),
                    direction: DismissDirection.endToStart,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        color: Colors.white,
                        child: ListTile(
                          title: Image.network(q.pictureUrl,height: 95,),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: datas.length,
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  TextFormField(
                    controller: kupon,
                    decoration: new InputDecoration(
                      errorStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Kupon Kodu ",
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "Kupon",
                      labelStyle: TextStyle(color: Colors.orange),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          )),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    onPressed: () {
                      _kodKontrol();
                    },
                    child: Text(
                      "Kodu Uygula",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    children:[
                      Text("  Ödeme Yöntemi Seçiniz:  "),
                      DropdownButton(
                      items: [
                        DropdownMenuItem(child:
                        Text("Nakit"),
                          value: 1,
                        ),
                        DropdownMenuItem(child:
                        Text("Kredi Kartı "),
                          value: 0,
                        ),
                        DropdownMenuItem(child:
                        Text("Vade"),
                          value: 2,
                        ),
                      ],
                      onChanged: (int secilen) {
                        setState(() {
                              ispaid = secilen ;
                              print('secilen s : $ispaid');

                        });
                      },
                      value: ispaid,
                    ),]
                  ),
              _func(ispaid),
                  SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: adress,
                    decoration: new InputDecoration(
                      errorStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Adress ",
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "Adress",
                      labelStyle: TextStyle(color: Colors.orange),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                        onPressed: () {
                          _finishProcess();
                        },
                        child: Text(
                          "Siparişi uygula",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              api.deleteBasket();
                            });
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: Text(
                            "Tümünü Sil",
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  _bottomNavigatorBar(BuildContext context) {
    {
      return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.orange,
            ),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.orange,
            ),
            label: 'Önceki Sayfa ',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          print(index);
          if (index == 1) {
            Navigator.pop(context);
          } else if (index == 0) {
            Navigator.pop(context);
          }
        },
      );
    }
  }

  Future<void> _getDatas() async {
    final result = await api.getBasket();
    dataurun = [];
    if (result != null) {
      datas = result;
      for (var data in datas) {
        var tmp = await _getDatasUrun(data.productId);
        if (tmp != null) dataurun.add(tmp);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Urun> _getDatasUrun(int id) async {
    print('*');
    final result = await api.getsepetiUrun(id);
    print("selectedUrunId: $id");
    if (result != null) {
      return result;
    }
    return null;
  }

  Future<void> _finishProcess() async {
    var dd=datas[0];
    bool b = await api.getBycode(kupon.text);
    double x = (await api.getTotalPrice());
    if(b==true&& x>20){
      if(ispaid==0 || ispaid == 1 ){
        var ordeId=await api.addOrder(dd.clientId,await api.getTotalPrice()-20.0,ispaid,DateTime.now().toString().replaceAll(' ', 'T'),adress.text,0);
        var i=datas.length;
        for(var data in datas){
          api.addOrderProduct( data.productId, ordeId, data.quantity,data.totalPrice ).then((value){
            print('bitti');
            i=i-1;
            if(i==0){
              //sonraki işlem
              api.deleteBasket();
            }
          });
        }
      }
      else{
        String a = vadezamani.text;
        int c = int.parse(a);
        var ordeId=await api.addOrder(dd.clientId,await api.getTotalPrice()-20.0,ispaid,DateTime.now().toString().replaceAll(' ', 'T'),adress.text,c);
        var i=datas.length;
        for(var data in datas){
          api.addOrderProduct( data.productId, ordeId, data.quantity,data.totalPrice ).then((value){
            print('bitti');
            i=i-1;
            if(i==0){
              //sonraki işlem
              api.deleteBasket();
            }
          });
        }
      }
    }
    else{
      if(ispaid==0 || ispaid == 1 ){
        var ordeId=await api.addOrder(dd.clientId,await api.getTotalPrice(),ispaid,DateTime.now().toString().replaceAll(' ', 'T'),adress.text,0);
        var i=datas.length;
        for(var data in datas){
          api.addOrderProduct( data.productId, ordeId, data.quantity,data.totalPrice ).then((value){
            print('bitti');
            i=i-1;
            if(i==0){
              //sonraki işlem
              api.deleteBasket();
            }
          });

        }
      }
      else{
        String a = vadezamani.text;
        int c = int.parse(a);
        var ordeId=await api.addOrder(dd.clientId,await api.getTotalPrice(),ispaid,DateTime.now().toString().replaceAll(' ', 'T'),adress.text,c);
        var i=datas.length;
        for(var data in datas){
          api.addOrderProduct( data.productId, ordeId, data.quantity,data.totalPrice ).then((value){
            print('bitti');
            i=i-1;
            if(i==0){
              //sonraki işlem
              api.deleteBasket();
            }
          });
        }
      }
    }

  }

  Widget _func(int a) {
    if(a==2) {
      return Container(
        width: 100,
        height: 100,
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: vadezamani,
          decoration: new InputDecoration(
            errorStyle: TextStyle(color: Colors.orange),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Vade Zamanı ",
            hintStyle: TextStyle(color: Colors.black),
            labelText: "Vade zamanı",
            labelStyle: TextStyle(color: Colors.orange),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .accentColor
                        .withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.orange,
                )),
          ),
        ),
      );
    }
    else
      return Text("");
  }

  Future<bool> _kodKontrol() async {
     bool b = await api.getBycode(kupon.text);
     print("code : $b");
     return b ;
  }

}
