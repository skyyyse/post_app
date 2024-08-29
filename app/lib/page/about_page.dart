import 'package:app/color/color.dart';
import 'package:flutter/material.dart';

class about_page extends StatelessWidget {
  const about_page({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: TColor.Container,
      appBar: AppBar(
        title: Text("About me",style: TextStyle(color: Colors.white),),
        backgroundColor: TColor.appbar,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Text("Contrary to popular belief Lorem Ipsum is not simply random text It has roots in a piece of classical Latin literature from 45 BC making it over 2000 years old Richard McClintock a Latin professor at Hampden-Sydney College in Virginia looked up one of the more obscure Latin words consectetur from a Lorem Ipsum passage and going through the cites of the word in classical literature discovered the undoubtable source Lorem Ipsum comes from sections 11032 and 11033 ofde Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero written in 45 BC This book is a treatise on the theory of ethics very popular during the Renaissance The first line of Lorem IpsumLorem ipsum dolor sit amet comes from a line in section 11032"),
        ),
      ),
    );
  }
}
