import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YaziEkrani extends StatefulWidget {
  @override
  _YaziEkraniState createState() => _YaziEkraniState();
}

class _YaziEkraniState extends State<YaziEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();

  var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  yaziEkle() {
    Random random = Random();
    String metinEkle = random.nextInt(99999).toString();
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(auth.currentUser.email + metinEkle)
        .set({
      'id': auth.currentUser.uid,
      'baslik': t1.text,
      'icerik': t2.text,
      'tarih': t3.text,
      'adres': t4.text
    });
    t1.clear();
    t2.clear();
    t3.clear();
    t4.clear();
  }

  yaziSil() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(auth.currentUser.email)
        .delete();
    t1.clear();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(40),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (deger) {
                        if (deger.isEmpty) {
                          return "Lütfen adınızı ve soyadınızı giriniz";
                        }
                        return null;
                      },
                      controller: t1,
                      decoration: InputDecoration(
                        hintText: "İletişim (mail ya da tel)",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.image,
                            color: Colors.grey.shade700,
                          ),
                        ), // icon is 48px widget.
                      ),
                    ),
                    TextFormField(
                      maxLines: 3,
                      maxLength: 300,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      controller: t2,
                      decoration: InputDecoration(
                        hintText: "Yazı içeriği",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.text_snippet,
                            color: Colors.grey.shade700,
                          ),
                        ), // icon is 48px widget.
                      ),
                    ),
                    TextFormField(
                      validator: (deger) {
                        if (deger.isEmpty) {
                          return "Gönderi tarihini giriniz. ör: 24.03.2021";
                        }
                        return null;
                      },
                      controller: t3,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: "Tarih",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.grey.shade700,
                          ),
                        ), // icon is 48px widget.
                      ),
                    ),
                    TextFormField(
                      validator: (deger) {
                        if (deger.isEmpty) {
                          return "Lütfen il ve ilçeyi giriniz";
                        }
                        return null;
                      },
                      controller: t4,
                      decoration: InputDecoration(
                        hintText: "Adres örn: il-ilçe",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.location_on_rounded,
                            color: Colors.grey.shade700,
                          ),
                        ), // icon is 48px widget.
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: 150,
                            height: 40,
                            child: ElevatedButton(
                                child: Text(
                                  "Ekle",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                ),

                                onPressed: () {
                                  if (_formKey.currentState.validate()) {

                                    yaziEkle();
                                  }
                                })),
                        Container(
                          height: 20,
                        ),
                        SizedBox(
                            width: 150,
                            height: 40,
                            child: ElevatedButton(
                                child: Text(
                                  "Sil",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    yaziSil();
                                  }
                                }))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
