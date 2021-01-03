import 'package:flutter/material.dart';
import 'Features/login/presentation/pages/login_page.dart';
import 'core/injection_container/login_injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ketabche',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

