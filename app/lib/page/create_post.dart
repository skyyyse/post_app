import 'package:app/color/color.dart';
import 'package:app/controller/Post_controller.dart';
import 'package:app/page/CircularProgressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class create_post extends StatefulWidget {
  create_post({super.key});

  @override
  State<create_post> createState() => _create_postState();
}

class _create_postState extends State<create_post> {
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() => this.image = imageTemp);
  }
  final post=Get.put(Post_controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post",style: TextStyle(color: Colors.white),),
        backgroundColor: TColor.appbar,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.blue, width: 1.0),
                      ),
                      child: image == null
                          ? Icon(
                              Icons.image,
                              size: 100,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: FileImage(image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.blue, width: 1.0),
                  ),
                  child: TextFormField(
                    controller: post.title,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      border: InputBorder.none, // Remove the default border
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.blue, width: 1.0),
                  ),
                  child: TextFormField(
                    controller: post.description,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      border: InputBorder.none, // Remove the default border
                    ),
                    maxLines: 5,
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColor.button,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    ),
                    onPressed: () {
                      post.store(image!.path);
                    },
                    child: Obx((){
                      return post.loading.value?CircularProgressIndicator_page():Text('Create Post',style: TextStyle(color: Colors.white),);
                    }),
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
