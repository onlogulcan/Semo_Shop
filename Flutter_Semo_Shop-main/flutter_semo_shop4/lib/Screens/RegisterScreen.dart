import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_semo_shop4/giris.dart';

import '../models/Users.dart';
import '../Helpers/api.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isHidden = true;

  final _formKey = GlobalKey<FormState>();
  Api api = new Api();
  Users model;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordControllerAgain = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = new Users();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Scaffold(
        body: _sCreen(context),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.orange,
          ),
        ),
      ),
    );
  }

  _sCreen(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  "KAYIT OL",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              TextFormField(
                onSaved: (deger) {
                  nameController.text = deger;
                },
                validator: (deger) {
                  if (deger.length < 4) {
                    return 'Username en az 4 karakter olmalı';
                  } else
                    return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.orange,
                    )),
                    errorStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'İsim',
                    labelStyle: TextStyle(color: Colors.orange),
                    hintText: 'İsim'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: isHidden,
                onSaved: (deger) {
                  passwordController.text = deger;
                },
                validator: (deger) {
                  if (deger == null) {
                    return 'şifre giriniz';
                  }
                },
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.orange,
                    )),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Şifre',
                    hintText: 'Şifre',
                    labelStyle: TextStyle(color: Colors.orange),
                    suffixIcon: IconButton(
                      onPressed: togglePasswordVisibilty,
                      icon: isHidden
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.orange,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.orange,
                            ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: isHidden,
                onSaved: (deger) {
                  passwordControllerAgain.text = deger;
                },
                validator: (deger) {
                  if (deger != passwordController.text) {
                    return 'şifreler aynı değil';
                  } else if (deger == null) {
                    return 'boş şifre';
                  } else
                    return null;
                },
                controller: passwordControllerAgain,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.orange,
                    )),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Şifre',
                    hintText: 'Şifre Tekrar',
                    labelStyle: TextStyle(color: Colors.orange),
                    suffixIcon: IconButton(
                      onPressed: togglePasswordVisibilty,
                      icon: isHidden
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.orange,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.orange,
                            ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (deger) {
                  emailController.text = deger;
                },
                validator: (deger) {
                  if (deger.isEmpty) {
                    return 'email giriniz';
                  } else if (!EmailValidator.validate(deger)) {
                    return 'Geçerli mail giriniz';
                  } else
                    return null;
                },
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.orange,
                    )),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'E-mail',
                    labelStyle: TextStyle(color: Colors.orange),
                    hintText: 'E-mail'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (deger) {
                  phoneController.text = deger;
                },
                validator: (deger) {
                  if (deger == null) {
                    return 'Telefon numarası Giriniz';
                  }
                  return null;
                },
                controller: phoneController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.orange,
                    )),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Phone',
                    labelStyle: TextStyle(color: Colors.orange),
                    hintText: 'Phone'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final String name = nameController.text;
                      final String password = passwordController.text;
                      final String email = emailController.text;
                      final String passwordagain = passwordControllerAgain.text;
                      final String phone = phoneController.text;
                      bool _validate = _formKey.currentState.validate();
                      if (_validate) {
                        api.getRegister(name, password, email, phone).then(
                            (value) => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => GirisSayfasi())));
                        //    _formKey.currentState!.save();

                        setState(() {
                          _showDiyalog();
                        });
                      } else {
                        //  _formKey.currentState!.reset();
                        setState(() {
                          _showDiyalognot();
                        });
                      }
                    },
                    child: Text(
                      "Kayıt Ol",
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDiyalog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: new Text("Kayıt  İşlemi Başarılı "),
            content: new Text("Kaydın onaylanması için mailinize gidiniz"),
          );
        });
  }

  void _showDiyalognot() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: new Text("Kayıt  İşlemi Başarılı olmadı  "),
            content: new Text("Tekrar deneyin "),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('Tamam'),
              ),
            ],
          );
        });
  }

  void togglePasswordVisibilty() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
