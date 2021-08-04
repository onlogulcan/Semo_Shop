import 'package:flutter/material.dart';
import 'package:flutter_semo_shop4/Helpers/LoadingWidget.dart';
import 'package:flutter_semo_shop4/Helpers/api.dart';
import 'package:flutter_semo_shop4/Screens/sepetSayfasi.dart';
import 'package:flutter_semo_shop4/models/Urun.dart';
class HepsiniGor extends StatefulWidget {
  const HepsiniGor({Key key}) : super(key: key);

  @override
  _HepsiniGorState createState() => _HepsiniGorState();
}

class _HepsiniGorState extends State<HepsiniGor> {

  Api api =Api();
  List<Urun> datas =[];
  int selectedUrunId=0;
  Urun selectedUrun =Urun();

  bool isLoading = true;






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.orange,
        ),
        elevation: 0,
        title: Text(
          "Tüm Ürünler",
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
      ),
      body:  isLoading ? LoadingWidget() : _body(),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdatas();
  }
  _body() {
    if (selectedUrunId > 0) {
      return Text(selectedUrun.name ?? "");
    }
    else {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemBuilder: (context, i) {
            var q = datas[i];
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Image.network(q.pictureUrl),
                    ListTile(
                      title: Text(
                        q.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.orange,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        q.weight ?? "",
                        style:
                        TextStyle(
                            backgroundColor: Colors.orange,
                            color: Colors.black
                        ),
                      ),

                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 105.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SepetimEkran(
                                    product:q,
                                  )));
                            },
                            child: Text("Sepete Ekle"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                color: Colors.white,
              ),
            );

          },
          itemCount: datas.length,
        ),
      );

    }

  }

  void getdatas() async{
    final result = await api.getUrun();
    if (result != null) {
      setState(() {
        datas = result;
        isLoading = false ;
      });
    }
  }

  void getData(int id) async{
    final result = await api.getUrun();
    if (result != null) {
      setState(() {
        selectedUrun = result as Urun;
      });
    }
  }
}