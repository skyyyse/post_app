
import 'package:app/color/color.dart';
import 'package:flutter/material.dart';

class contect_page extends StatelessWidget {
  const contect_page({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: TColor.Container,
      appBar: AppBar(
        elevation: 0,
        title: Text("Contect",style: TextStyle(color: Colors.white),),
        backgroundColor: TColor.appbar,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://imgs.search.brave.com/OoLPOdtBupqfHiX7xgReETZkFru7zQl8tk9CwersIBU/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTM5/MjgwNjM5L3Bob3Rv/L3VzaW5nLWNlbGwt/cGhvbmUuanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPTRteGpM/UzdBbUtkSk1DMUpZ/bnk2QlVqV2xoeDMt/aDIxSVlSNU4zd05n/N0E9'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
              child: Column(
                children: [
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("Phone :015618466"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Column(
                children: [
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.telegram),
                    title: Text("Telegram :015618466"),
                  ),
                  Divider(height: 1),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: TColor.button,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  onPressed: () {
                  },
                  child: Text('Telegram',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: TColor.button,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  onPressed: () {
                    // post.store(image!.path);
                  },
                  child: Text('Call',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
