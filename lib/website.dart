import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebSite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: SafeArea(
              child: Scaffold(
        
          body: WebView(
            initialUrl: 'https://cocuktekno.wordpress.com/',
            javascriptMode: JavascriptMode.unrestricted,
          )
        ),
      ),
    );
  }
}