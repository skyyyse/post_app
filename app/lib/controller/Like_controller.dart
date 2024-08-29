import 'dart:convert';
import 'package:app/controller/Post_controller.dart';
import 'package:app/controller/Token_controller.dart';
import 'package:app/server/app_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class Like_controller extends GetxController {
  final post=Get.put(Post_controller());
  final token=Get.put(Token_controller());
  void like(int id) async {
    try {
      final response = await http.get(
        Uri.parse("${Url.like_unlike}${id}"),
        headers: {
          "Authorization": "Bearer ${token.data['token']}",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('object');
        final data = json.decode(response.body);
        if (data['status'] == true) {
          Get.snackbar("Sucess","${data['message']}",backgroundColor: Colors.red,colorText: Colors.white);
          post.fetchPosts();
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
      }
    } catch (e) {
      print(e);
    }
  }
}
