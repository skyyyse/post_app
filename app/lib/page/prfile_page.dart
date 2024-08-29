import 'dart:io';
import 'package:app/color/color.dart';
import 'package:app/controller/User_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';

class profile_page extends StatefulWidget {
  var user_image, username, email;
  profile_page(
      {super.key,
      required this.username,
      required this.user_image,
      required this.email});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() => this.image = imageTemp);
  }
  final  userController = Get.put(User_controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: image == null
                          ? CircleAvatar(
                              radius: 40,
                              child: widget.user_image.toString().isEmpty ? CircleAvatar(
                                radius: 40,
                                child: Icon(Icons.person,size: 50,),
                              ) : CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(
                                  "http://10.0.2.2:8000/file/user/image/${widget.user_image}",
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image: FileImage(image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 50),
                  child: TextField(
                    controller: userController.username,
                    decoration: InputDecoration(
                      hintText: '${widget.username}',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: KPrimarykeycolor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: userController.email,
                    decoration: InputDecoration(
                      hintText: '${widget.email}',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: KPrimarykeycolor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () {
                      userController.changes_data(image,widget.username,widget.email);
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    color: Colors.cyan,
                    minWidth: double.infinity,
                    height: 50,
                    elevation: 0,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
