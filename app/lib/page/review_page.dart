import 'package:app/color/color.dart';
import 'package:app/controller/Favorite_controller.dart';
import 'package:app/page/comment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
class review_page extends StatefulWidget {
  var user_image,name,title,image,description,id;
  review_page({super.key,required this.user_image,required this.name,required this.title,required this.image,required this.description,required this.id});

  @override
  State<review_page> createState() => _review_pageState();
}

class _review_pageState extends State<review_page> {
  final Favorite_controller favorite = Get.put(Favorite_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.background,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
        backgroundColor: TColor.appbar,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
                color: TColor.Container,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    leading: widget.user_image.isEmpty?CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person,size: 30,),
                    ):CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage("http://10.0.2.2:8000/file/user/image/${widget.user_image}"),
                    ),
                    title: Text(widget.name),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8,bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          maxLines: 5, // Maximum number of lines
                          overflow: TextOverflow.ellipsis, // Overflow behavior
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // Get.to(review_page(posts: posts,));
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image: NetworkImage(
                            "http://10.0.2.2:8000/file/post/image/${widget.image}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8,bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.description,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          maxLines: 5, // Maximum number of lines
                          overflow: TextOverflow.ellipsis, // Overflow behavior
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
    );
  }
}
