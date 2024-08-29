import 'dart:convert';
import 'package:app/controller/Post_controller.dart';
import 'package:app/controller/Token_controller.dart';
import 'package:app/server/app_url.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import '../model/Favorite.dart';
class Favorite_controller extends GetxController {
  var favorites = <favorite_model>[].obs;
  var loading = false.obs;
  final token = Get.put(Token_controller());
  final post=Get.put(Post_controller());
  @override
  void onInit() {
    fetchfavorite();
    super.onInit();
  }

  Future<void> fetchfavorite() async {
    try {
      loading.value = true;
      final response = await http.get(
        Uri.parse(Url.favorite),
        headers: {
          "Authorization": "Bearer ${token.data['token']}",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        loading.value = false;
        final List<dynamic> jsonList = json.decode(response.body)['favorite'];
        favorites.assignAll(jsonList.map((json) => favorite_model.fromjson(json)).toList());
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
      }
    } catch (e) {
      print(e);
    }
  }

  void fovorite(int id) async {
    try {
      final response = await http.get(Uri.parse("${Url.favorite_add_remove}${id}"),
        headers: {
          "Authorization": "Bearer ${token.data['token']}",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          Get.snackbar("Sucess","${data['message']}");
          post.fetchPosts();
          fetchfavorite();
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
      }
    } catch (e) {
      print(e);
    }
  }
}
