import 'package:flutter/material.dart';

class UygulamaTanitim extends StatefulWidget {
  @override
  _UygulamaTanitimState createState() => _UygulamaTanitimState();
}

class _UygulamaTanitimState extends State<UygulamaTanitim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              divCon("1.jpeg"),
              divdiv(),
              divCon("2.jpeg"),
              divdiv(),
              divCon("3.jpeg"),
              divdiv(),
              divCon("4.jpeg"),
              divdiv(),
              divCon("5.jpeg"),
              divdiv(),
              divCon("6.jpeg"),
              divdiv(),
              divCon("7.jpeg"),
              divdiv(),
              divCon("8.jpeg"),
              divdiv(),
              divCon("9.jpeg"),
              divdiv(),
              divCon("10.jpeg"),
              divdiv(),
              divCon("11.jpeg"),
              divdiv(),
              divCon("e1.jpeg"),
              divdiv(),
              divCon("e2.jpeg"),
              divdiv(),
              divCon("e3.jpeg"),
              divdiv(),
              divCon("e4.jpeg"),
              divdiv(),
              divCon("e5.jpeg"),
              divdiv(),
              divCon("e6.jpeg"),
              divdiv(),
              divCon("e7.jpeg"),
              divdiv(),
              divCon("e8.jpeg"),
              divdiv(),
              divCon("e9.jpeg"),
              divdiv(),
              divCon("e10.jpeg"),
              divdiv(),
              divCon("e11.jpeg"),
              divdiv(),
              divCon("e12.jpeg"),
              divdiv(),
              divCon("e13.jpeg"),
              divdiv(),
              divCon("e14.jpeg"),
              divdiv(),
              divCon("e15.jpeg"),
              divdiv(),
              divCon("f1.jpeg"),
              divdiv(),
              divCon("f2.jpeg"),
              divdiv(),
              divCon("f3.jpeg"),
              divdiv(),
              divCon('f4.jpeg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget divCon(String fileName) {
    return Container(
      width: 480,
      height: 700,
      decoration: BoxDecoration(
          color: Colors.black87,
          image: DecorationImage(
              image: AssetImage('assets/' + fileName), fit: BoxFit.cover)),
    );
  }

  Widget divdiv() {
    return Divider(
      color: Colors.grey.shade700,
      height: 10,
    );
  }
}
