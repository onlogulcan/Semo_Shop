import 'package:flutter/material.dart';

import 'Screens/FirstScreen.dart';
import 'Screens/RegisterScreen.dart';


final TextStyle menuStyle = TextStyle(color: Colors.black, fontSize: 12);

class GirisSayfasi extends StatelessWidget {
  const GirisSayfasi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Semo Shop",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: FunFun(context),
      ),
    );
  }
}

FunFun(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.orange),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Email',
              hintText: 'Email'),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Password',
              hintText: 'Password'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FirstScreen()));
                },
                child: Text(
                  "Giriş Yap",
                  style: menuStyle,
                ),
                style: ElevatedButton.styleFrom(primary: Colors.orange),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text(
                  "Kayıt Ol",
                  style: menuStyle,
                ),
                style: ElevatedButton.styleFrom(primary: Colors.orange),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
