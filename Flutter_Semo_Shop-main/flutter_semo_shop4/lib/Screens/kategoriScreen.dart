import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_semo_shop4/Helpers/LoadingWidget.dart';
import 'package:flutter_semo_shop4/Helpers/api.dart';
import 'package:flutter_semo_shop4/Screens/sepetSayfasi.dart';
import 'package:flutter_semo_shop4/models/Kategoriler.dart';
import 'package:flutter_semo_shop4/models/Urun.dart';



class UrunListesi extends StatefulWidget {
  String c ;
  int id ;
  UrunListesi({this.id,this.c});
  // const UrunListesi({Key key}) : super(key: key);

  @override
  _UrunListesiState createState() => _UrunListesiState();
}

class _UrunListesiState extends State<UrunListesi> {
  bool isLoading = true;
  Api api= Api();
  Categories categories = new Categories();
  List<Categories> dataCategories =[];

  List<Urun> datas =[];
  int selectedUrunId= 0;
  Urun selectedUrun =Urun();
  int urunid =0 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.orange,
        ),
        title: Text(widget.c.toString(),style: TextStyle(color: Colors.black),),
      ),
      body:   isLoading ? LoadingWidget() : _body(),
    );
  }
  @override
  void initState() {
    print(widget.id);
    super.initState();
    _getDatas();
  }

  _body() {
    if (selectedUrunId > 0) {
      return Text(selectedUrun.name ?? "");
    } else {
      return ListView.builder(itemBuilder: (context, i){
        var a = datas[i];
        if(selectedUrunId>0)
          return Text(selectedUrun.name);
        else{
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
      itemCount: datas.length,
      );
    }
  }

  Future<void> _getDatas() async {
    final result = await api.getKategoriurun(widget.id);
    if (result != null) {
      setState(() {
        datas = result;
        isLoading = false;
      });

    }
  }


}






