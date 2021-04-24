import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vscode1/videoPlayer.dart';
import 'package:vscode1/yaziEkle.dart';
import 'UygulamaTanitim.dart';
import 'anaSayfa.dart';
import 'login.dart';
import 'website.dart';

class ProfilEkran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
        title: Text("Benim Yazılarım",
            style: GoogleFonts.varela(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 20)),
        actions: <Widget>[
          IconButton(
              tooltip: 'AnaSayfa',
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => AnaSayfa()),
                    (Route<dynamic> route) => true);
              }),
          IconButton(
              tooltip: 'Çıkış Yap',
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((deger) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => Iskele()),
                      (Route<dynamic> route) => false);
                });
              }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(""),
              decoration: BoxDecoration(
                  //color: Colors.grey,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/draver3.jpeg'))),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey.shade800,
              height: 5,
            ),
            ListTile(
              leading: Icon(
                Icons.play_circle_fill_sharp,
                color: Colors.blue,
              ),
              title: Text(
                'Uygulama Tanıtım Videosu',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => VideoApp()),
                    (Route<dynamic> route) => true);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.book,
                color: Colors.red.shade800,
              ),
              title: Text(
                'Ek Bilgiler',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => UygulamaTanitim()),
                    (Route<dynamic> route) => true);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.blue,
              ),
              title: Text(
                'Tekno Çocuk',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => WebSite()),
                    (Route<dynamic> route) => true);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade600,
        tooltip: 'Yazı Ekle',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => YaziEkrani()),
              (Route<dynamic> route) => true);
        },
      ),
      body: KullaniciYazilari(),
    );
  }
}

class KullaniciYazilari extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    Query blogYazilari = FirebaseFirestore.instance
        .collection('Yazilar')
        .where("id", isEqualTo: auth.currentUser.uid);

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
                      width: double.infinity,
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          color: Colors.blue.shade600),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            kisaExpanded(document, 'baslik'),
                            VerticalDivider(
                              thickness: 2,
                              color: Color(0xFFF6F4F4),
                            ),
                            kisaExpanded(document, 'tarih')
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: Colors.blue.shade500,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            kisaExpanded(document, 'icerik'),
                            VerticalDivider(
                              thickness: 2,
                              color: Color(0xFFF6F4F4),
                            ),
                            kisaExpanded(document, 'adres')
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

  Widget kisaExpanded(dynamic document, String doc) {
    return Expanded(
        child: new Text(document.data()[doc],
            style: GoogleFonts.varela(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 15)));
  }
}
