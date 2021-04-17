import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TumYazilar(),
      ),
    );
  }
}

class TumYazilar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Yazilar');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 10, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      //margin: EdgeInsets.only(top: 5,bottom: 5),
                      width: double.infinity,
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          color: Colors.blue.shade600
                          //Color(0xFF5E808A  ),//2E61EE
                          ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: new Text(
                                document.data()['baslik'],
                                style: GoogleFonts.varela(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            VerticalDivider(
                              thickness: 2,
                              color: Color(0xFFF6F4F4),
                            ),
                            Expanded(
                                child: new Text(document.data()['tarih'],
                                    style: GoogleFonts.varela(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15))),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //margin: EdgeInsets.only(top: 5,bottom: 5),
                      width: double.infinity,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: Colors.blue.shade500),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: new Text(
                                document.data()['icerik'],
                                style: GoogleFonts.varela(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            VerticalDivider(
                              thickness: 2,
                              color: Color(0xFFF6F4F4),
                            ),
                            Expanded(
                                child: new Text(document.data()['adres'],
                                    style: GoogleFonts.varela(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
