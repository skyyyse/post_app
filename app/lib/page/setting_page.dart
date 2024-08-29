import 'dart:io';
import 'package:app/color/color.dart';
import 'package:app/controller/User_controller.dart';
import 'package:app/page/CircularProgressIndicator.dart';
import 'package:app/page/about_page.dart';
import 'package:app/page/address_page.dart';
import 'package:app/page/contect_page.dart';
import 'package:app/page/feedback_page.dart';
import 'package:app/page/login_page.dart';
import 'package:app/page/prfile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class setting_page extends StatefulWidget {
  @override
  State<setting_page> createState() => _setting_pageState();
}

class _setting_pageState extends State<setting_page> {
  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() => this.image = imageTemp);
  }
  final User_controller userController = Get.put(User_controller());
  @override
  void initState() {
    userController.fetchUserData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.background,
      appBar: AppBar(
        title: Text('Setting',style: TextStyle(color: Colors.white),),
        backgroundColor: TColor.appbar,
        elevation: 0,
      ),
      body: Obx(() {
        final user = userController.user.value;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(profile_page(
                        user_image: user!.image,
                        username: user.name,
                        email: user.email,
                      ));
                    },
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0XFF5e6472),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: user!.image.toString().isEmpty
                                ? CircleAvatar(
                                    radius: 40,
                                    child: Icon(Icons.person,size: 50,),
                                  )
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      "http://10.0.2.2:8000/file/user/image/${user!.image.toString()}",
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Name : ${user?.name}",style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Email :${user?.email.toString()}",style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFF5e6472)
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap:(){
                            Get.to(feedback_page());
                          },
                          child: ListTile(
                            leading: Icon(Icons.format_align_justify,color: Colors.white,),
                            title: Text("Feed Back",style: TextStyle(color: Colors.white),),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        InkWell(
                          onTap:(){
                            Get.to(contect_page());
                          },
                          child: ListTile(
                            leading: Icon(Icons.call,color: Colors.white,),
                            title: Text("Contect",style: TextStyle(color: Colors.white),),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(about_page());
                          },
                          child: ListTile(
                            leading: Icon(Icons.info_outline,color: Colors.white,),
                            title: Text("About",style: TextStyle(color: Colors.white),),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            logout();
                          },
                          child: ListTile(
                            leading: Icon(Icons.logout_sharp,color: Colors.white,),
                            title: Text("Logout",style: TextStyle(color: Colors.white),),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to Logout?'),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              userController.logout();
            },
            child: Obx((){
              return userController.isLoading.value?CircularProgressIndicator_page():Text('OK');
            }),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
