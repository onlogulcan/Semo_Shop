import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_semo_shop4/Helpers/LoadingWidget.dart';
import 'package:flutter_semo_shop4/Helpers/api.dart';
import 'package:flutter_semo_shop4/Helpers/database_Helper.dart';
import 'package:flutter_semo_shop4/Screens/VadeliSiparislerim.dart';
import 'package:flutter_semo_shop4/Screens/hepsini_gor.dart';
import 'package:flutter_semo_shop4/Screens/kategoriScreen.dart';
import 'package:flutter_semo_shop4/Screens/sepetSayfasi.dart';
import 'package:flutter_semo_shop4/models/Kategoriler.dart';
import 'package:flutter_semo_shop4/models/Urun.dart';
import 'package:flutter_semo_shop4/models/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GecmisSiparisScreen.dart';
import 'sepetim.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isLoading = false;
  List<GetUSer> dataUSer = [];
  Api api = new Api();
  int urunadedi = 0;
  double urunfiyat = 0;
  List<Categories> datas = [];
  List<Urun> datasurun = [];
  int selectedUrunId = 0;
  Urun selectedUrun = new Urun();
  int selectedCategoriesId = 0;

  Categories selectedCategories = new Categories();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                child: Center(
                    child: Text(
                  'Semo Shop ',
                  style: TextStyle(fontSize: 24),
                )),
              ),
            ),
            ListTile(
              title: Text('Geçmiş Siparişlerim'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GecmisSiparisScreen(
                          userId: dataUSer[0].id,
                        )));
              },
            ),
            ListTile(
              title: Text('Vadeli Siparişlerim'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (VadeliSiparislerimScreen(
                          id: dataUSer[0].id,
                        ))));
              },
            ),
            //    _listView()
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          "Semo Shop ",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading ? LoadingWidget() : _body(context),
      bottomNavigationBar: bottomNAvigationBar(context),
    );
  }

  _body(context) {
    if (selectedCategoriesId > 0)
      print(selectedCategories.name);
    else {
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
              ),
              child: Text("Kategoriler"),
            ),
            Card(
              elevation: 0,
              child: Container(
                height: 70,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var q = datas[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.orange),
                        height: 100,
                        width: 100,
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UrunListesi(
                                        id: q.id,
                                        c: q.name,
                                      )));
                            });
                          },
                          title: Text(
                            q.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: datas.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.orange,
                    child: Text(
                      "En çok Alınanlar",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HepsiniGor()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          color: Colors.orange,
                          child: Text(
                            "Hepsini Gör",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemBuilder: (context, i) {
                  var a = datasurun[i];
                  if (selectedUrunId > 0) {
                    return Text(selectedUrun.name ?? "");
                  } else {
                    return Container(
                        child: Column(
                      children: [
                        Image.network(a.pictureUrl),
                        ListTile(
                          title: Text(
                            a.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.orange,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            a.price.toString() + "TL ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.orange,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SepetimEkran(
                                        product: a,
                                      )));
                            },
                            child: Text("Ürünü Görüntüle"),
                          ),
                        ),
                      ],
                    ));
                  }
                },
                itemCount: datasurun.length,
              ),
            ),
          ],
        ),
      );
    }
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
          label: 'Çıkış yap',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        print(index);
        if (index == 1) {
          logOutFn();
        } else if (index == 0) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SepetimScreen(
                    user: dataUSer[0],
                  )));
        }
      },
    );
  }

  Future<void> _getDatas() async {
    setState(() {
      isLoading = true;
    });
    final result = await api.getCategory();
    if (result != null) {
      setState(() {
        datas = result;
      });
    }
    await _getDatasurun();
    await _getDataUser();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getData(int id) async {
    final result = await api.getCategori(id);
    if (result != null) {
      setState(() {
        selectedCategories = result;
      });
    }
  }

  _listView() {
    if (selectedCategoriesId > 0)
      return Text(selectedCategories.name);
    else {
      return ListView.builder(
        itemBuilder: (context, i) {
          var a = datas[i];
          return ListTile(
            title: Text(a.name),
            onTap: () {
              setState(() {
                selectedCategoriesId = a.id;
                getData(a.id);
              });
            },
          );
        },
        itemCount: datas.length,
      );
    }
  }

  Future<void> _getDatasurun() async {
    final result = await api.getUrun();
    if (result != null) {
      setState(() {
        datasurun = result;
      });
    }
  }

  Future<void> _getDatasuruns(int id) async {
    final result = await api.getidliUrun(id);
    if (result != null) {
      setState(() {
        selectedCategories = result as Categories;
      });
    }
  }

  Future<void> _getDataUser() async {
    final result = await api.getUser();
    if (result != null) {
      setState(() {
        dataUSer = result;
      });
    }
  }

  Future<void> logOutFn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pop(context);
  }
}
