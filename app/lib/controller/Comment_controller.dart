import 'dart:convert';
import 'package:app/controller/Token_controller.dart';
import 'package:app/model/Comment.dart';
import 'package:app/server/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Comment_controller extends GetxController {
  final commentController = TextEditingController();
  final token = Get.put(Token_controller());
  var comments = <Comment>[].obs;
  var isLoading = true.obs;
  Future<void> fetchComment(int id) async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse("${Url.comment}${id}"),
        headers: {
          "Authorization": "Bearer ${token.data['token']}",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        final List<dynamic> jsonList = json.decode(response.body)['comment'];
        comments.assignAll(jsonList.map((json) => Comment.fromjson(json)).toList());
        print('000');
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> store(int id) async {
    print(token.data['token']);
    if (commentController.text.isEmpty) {
      fetchComment(id);
      Get.snackbar('Error', 'Comment is Empty......');
    } else {
      try {
        isLoading.value = true;
        final response = await http.get(
          Uri.parse("${Url.comment_store}${id}&comment=${commentController.text}"),
          headers: {
            "Authorization": "Bearer ${token.data['token']}",
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isLoading.value = false;
          fetchComment(id);
          commentController.clear();
        } else {
          Get.snackbar('Error', 'Failed to fetch posts');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e');
        print(e);
      }
    }
  }

  Future<void> Delete(int id, int post_id) async {
    print(id);
    print(post_id);
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse("${Url.comment_delete}${id}"),
        headers: {
          "Authorization": "Bearer ${token.data['token']}",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        fetchComment(post_id);
        print('object');
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print(e);
    }
  }
}
