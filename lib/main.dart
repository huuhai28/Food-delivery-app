import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/cart_provider.dart';
import 'View/onboard_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (create) => CartProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppOnBoardPage(),
      ),
    );
  }
}
