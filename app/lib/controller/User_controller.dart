import 'package:app/controller/Token_controller.dart';
import 'package:app/model/User.dart';
import 'package:app/page/login_page.dart';
import 'package:app/server/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User_controller extends GetxController {
  final token = Get.put(Token_controller());
  final username = TextEditingController();
  final email = TextEditingController();
  final feedback = TextEditingController();
  var user = Rx<User?>(null);
  var isLoading = true.obs;
  var error = ''.obs;
  Future<void> fetchUserData() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(Url.users),
        headers: {
          "Authorization": "Bearer ${token.data['token']}",
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          user.value = User.fromJson(jsonResponse['user']);
        } else {
          error.value = 'Failed to load user data';
        }
      } else {
        error.value = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changes_data(image, user_name, user_email) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${token.data['token']}'
      };
      var request = http.MultipartRequest('POST', Uri.parse(Url.users_changes_image));
      request.fields.addAll({
        'username': '${username.text.isEmpty ? user_name : username.text}',
        'email': '${email.text.isEmpty ? user_email : email.text}'
      });
      image==null?null:request.files.add(await http.MultipartFile.fromPath('image', '${image!.path}'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar('Sucess', 'Create  posts sucessfull..');
        fetchUserData();
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e);
    }
  }
  Future<void> store() async {
    try {
      isLoading.value=true;
      var headers = {
        'Authorization': 'Bearer ${token.data['token']}'
      };
      var request = http.MultipartRequest('POST', Uri.parse(Url.feedback));
      request.fields.addAll({
        'text': '${feedback.text}',
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        isLoading.value=false;
        Get.snackbar('Sucess', 'Create  posts sucessfull..');
      }
      else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> logout() async {
    try {
      isLoading.value=true;
      var headers = {
        'Authorization': 'Bearer ${token.data['token']}'
      };
      var request = http.Request('POST', Uri.parse(Url.logout));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        await Future.delayed(Duration(seconds: 6));
        isLoading.value=false;
        Get.offAll(login_page());
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e);
    }
  }
}
