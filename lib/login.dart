
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profil.dart';



class Iskele extends StatefulWidget {

  @override
  _IskeleState createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;


  void initState() {
    super.initState();
    auth
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => ProfilEkran()),
                (Route<dynamic> route) => false);
      }
    });
  }

  Future<void> kayitOl() async {
    await auth
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici){
      FirebaseFirestore.instance.
      collection("Kullanicilar")
          .doc(t1.text)
          .set({"E posta":t1.text,
        "Şifre":t2.text});
      t2.clear();

    });
  }

  girisYap(){
    auth.signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => ProfilEkran()),
              (Route<dynamic> route) => false);
    });

  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _formKey = GlobalKey<FormState>();
    var snackBar = SnackBar(
      content: Text("Hesabınız başarıyla oluşturuldu"),
      action: SnackBarAction(
        label: 'Tamam',
        onPressed: () {
          //print("Silme işlemi geri alındı");
        },
      ),
    );
    return new Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(

            key: _formKey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("WELCOME",style: TextStyle(color: Colors.blueGrey,fontSize: 30,fontFamily:  "Rock Salt"),),
                Container(height: 40,),
                TextFormField(
                  autofocus: true,
                  controller: t1,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.email,
                        color: Colors.blueGrey,
                      ),
                    ), // icon is 48px widget.
                  ),
                  validator: (deger) {
                    if (deger.isEmpty) {
                      return "Lütfen geçerli bir mail adresi giriniz";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  controller: t2,
                  obscureText: true,
                  maxLength: 40,
                  decoration: InputDecoration(
                    hintText: "Şifre",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.lock,
                        color: Colors.blueGrey,
                      ),
                    ), // icon is 48px widget.
                  ),
                  validator: (deger) {
                    if (deger.length < 6) {
                      return "Lütfen daha uzun bir şifre giriniz.";
                    }
                    return null;
                  },
                ),
                Container(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 40,
                      // ignore: deprecated_member_use
                      child: RaisedButton(

                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _scaffoldKey.currentState.showSnackBar(snackBar);
                            kayitOl();
                          }
                        },
                        color:Colors.blueGrey,
                        child: Text('Kayıt Ol',style: TextStyle(color: Colors.white),),
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      ),
                    ),
                    Container(height: 15,),
                    Container(
                      width: 150,
                      height: 40,
                      // ignore: deprecated_member_use
                      child: RaisedButton(

                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            girisYap();
                          }
                        },
                        color:Colors.blueGrey,
                        child: Text('Giriş Yap',style: TextStyle(color: Colors.white),),
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}