import 'package:flutter/material.dart';
import 'package:flutter_semo_shop4/Helpers/LoadingWidget.dart';
import 'package:flutter_semo_shop4/Helpers/api.dart';
import 'package:flutter_semo_shop4/Screens/LoginScreen.dart';
import 'package:flutter_semo_shop4/models/Orders.dart';

class VadeliSiparislerimScreen extends StatefulWidget {
 final int id ;
  const VadeliSiparislerimScreen({Key key,this.id}) : super(key: key);

  @override
  _VadeliSiparislerimScreenState createState() => _VadeliSiparislerimScreenState();
}

class _VadeliSiparislerimScreenState extends State<VadeliSiparislerimScreen> {
  List<AddOrder> datas =[] ;
  Api api = new Api();
  int selectedOrderId =0 ;
  AddOrder addOrder = new AddOrder();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatas(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Vadeli Siparişlerim",style: TextStyle(color: Colors.black),),
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
            Icons.home_outlined,
            color: Colors.orange,
          ),
          label: 'Anasayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.orange,
          ),
          label: 'Çıkış Yap  ',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        print(index);
        if (index == 1) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
        } else if (index == 0) {
          Navigator.pop(context);
        }
      },
    );
  }


  _bodyy() {
    if(selectedOrderId > 0 )
      return Text("ssadasd");
    else{
     return  ListView.builder(itemBuilder: (context,i){
        var q = datas[i];
        return Card(
          child:ListTile(
            onTap: (){
              setState(() {
                selectedOrderId=q.userId;

              });
            },
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



  Future<void> getDatas(int userId) async {
    final result = await api.getVadeliOrdeer(userId);
    if (result != null) {
      setState(() {
        datas = result;
        isLoading = false;
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

