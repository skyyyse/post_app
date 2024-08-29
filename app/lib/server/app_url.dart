class Url {
  static var baseUrl="http://10.0.2.2:8000/api/";
  static var login = '${baseUrl}login';
  static var register = '${baseUrl}register';
  static var post = '${baseUrl}post/get';
  static var post_store = '${baseUrl}post/store';
  static var favorite = '${baseUrl}favorite/get';
  static var favorite_add_remove = '${baseUrl}favorite?id=';
  static var history = '${baseUrl}history/get?user_id=';
  static var history_delete = '${baseUrl}post/delete?id=';
  static var like_unlike = '${baseUrl}like?id=';
  static var comment = '${baseUrl}comment/get?id=';
  static var comment_store = '${baseUrl}comment/store?id=';
  static var comment_delete = '${baseUrl}comment/delete?id=';
  static var users = '${baseUrl}user/get';
  static var users_changes_image = '${baseUrl}changes/data';
  static var feedback = '${baseUrl}feedback';
  static var logout = '${baseUrl}logout';
}