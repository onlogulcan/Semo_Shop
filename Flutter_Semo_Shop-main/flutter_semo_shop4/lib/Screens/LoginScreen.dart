import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_semo_shop4/Screens/FirstScreen.dart';
import 'package:flutter_semo_shop4/Screens/sepetSayfasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'RegisterScreen.dart';
import '../models/Users.dart';
import '../Helpers/api.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String username;
  String password;
  SepetimEkran spt1 = new SepetimEkran();
  Api api = new Api();
   Users model;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  bool isHidden = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = new Users();
    _verileriGetir().then((value){
      if((username!=null)||(password!=null))
        {
          print("dolu veri geldi ") ;
          Navigator.push(context,MaterialPageRoute(builder: (context)=>FirstScreen()));
        }
      setState(() {
        username = username;
        password = password;
      });
    });
    _verileriKaydet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
        "Semo Shop",
        style: TextStyle(
        fontSize: 24,
        color: Colors.black,
      ),
        ),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) :  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  errorStyle: TextStyle(color: Colors.orange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Kullanıcı Adı ",
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: "Kullanıcı Adı",
                  labelStyle: TextStyle(color: Colors.orange),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.orange,)),

                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              alignment: Alignment.center,
              child: TextFormField(
                obscureText: isHidden,
                controller: jobController,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  errorStyle: TextStyle(color: Colors.orange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Şifre ",
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: "Şifre",
                  labelStyle: TextStyle(color: Colors.orange),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.orange,)),
                  suffixIcon : IconButton(onPressed:togglePasswordVisibilty,icon:  isHidden ? Icon(Icons.visibility_off,color: Colors.orange,) : Icon(Icons.visibility,color: Colors.orange,), )

              ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _loginFn();
                },
                child: Text("Giriş Yap ",style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(primary: Colors.orange),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              onPressed: () {
              Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text("Kayıt ol ",style: TextStyle(color: Colors.black),),
            )
          ],
        ),
      ),
    );
  }

  Future<String>_verileriGetir() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("Username");
    password = prefs.getString("password");
    return "Tamamlandı" ;
  }

  Future<String> _verileriKaydet()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await  prefs.setString("Username", nameController.text);
    await  prefs.setString("password", jobController.text);
    return "Tamamlandı" ;
  }


  void togglePasswordVisibilty() {
    setState(() {
      isHidden =! isHidden ;
    }
    );
  }

  Future<void> _loginFn() async {
    setState(() {
      isLoading = true;
    });
    final String name = nameController.text;
    final String password = jobController.text;
    _verileriGetir();
    _verileriKaydet();
    final result = await api.login(name,password);
    if(result != null){
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FirstScreen()));
    }

    setState(() {
      isLoading = false;
    });
  }
}
