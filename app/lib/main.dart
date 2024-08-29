import 'package:app/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {
  runApp(const app());
}
class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash_page(),
    );
  }
}