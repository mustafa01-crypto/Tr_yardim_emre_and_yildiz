import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFCEFBFA),
        body: TumYazilar(),
      ),
    );
  }
}

class TumYazilar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query blogYazilari = FirebaseFirestore.instance
        .collection('Yazilar')
        .orderBy('tarih', descending: true);

    return StreamBuilder<QuerySnapshot>(
      stream: blogYazilari.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
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
                            kisaExpanded2(document, 'baslik'),
                            VerticalDivider(
                              thickness: 2,
                              color: Color(0xFFF6F4F4),
                            ),
                            kisaExpanded2(document, 'tarih')
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
                            kisaExpanded2(document, 'icerik'),
                            VerticalDivider(
                              thickness: 2,
                              color: Color(0xFFF6F4F4),
                            ),
                            kisaExpanded2(document, 'adres')
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

  Widget kisaExpanded2(dynamic document, String doc) {
    return Expanded(
        child: new Text(document.data()[doc],
            style: GoogleFonts.varela(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 15)));
  }
}
