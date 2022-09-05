import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController with StateMixin<List<String>> {
  @override
  void onInit() {
    super.onInit();
    fetchComments();
  }

  fetchComments() async {
    await Future.delayed(5.seconds);
    var response = await http.get(Uri.parse('https://afzalali15.github.io/api/comments.json'));

    if (response.statusCode == 200) {
      var js = json.decode(response.body);
      var comments = List<String>.from(js.map((e) => e));

      if (comments.isEmpty)
        //! NO RECORDS
        change(null, status: RxStatus.empty());
      else
        //SUCCESS
        change(comments, status: RxStatus.success());
    } else {
      //! ERROR
      change(null, status: RxStatus.error('something went wrong: ${response.statusCode}'));
    }
  }
}
