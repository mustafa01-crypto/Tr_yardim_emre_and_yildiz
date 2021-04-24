
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://9020196c92a449f5b528ba665b21156a@o576876.ingest.sentry.io/5730975';
    },
    appRunner: () => runApp(MyApp()),
  );

  // or define SENTRY_DSN via Dart environment variable (--dart-define)
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Iskele(),
      ),

    );
  }
}


