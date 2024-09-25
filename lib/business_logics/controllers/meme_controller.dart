import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/models/memes_model.dart';

class MemeController extends GetxController {
  var memes = <Meme>[].obs;
  var filteredMemes = <Meme>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchMemes();
    super.onInit();
  }

  void fetchMemes() async {
    final response = await http.get(Uri.parse('https://api.imgflip.com/get_memes'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var memeList = (jsonData['data']['memes'] as List).map((meme) => Meme.fromJson(meme)).toList();
      memes.value = memeList;
      filteredMemes.value = memeList;
      isLoading.value = false;
    }
  }

  void filterMemes(String query) {
    if (query.isEmpty) {
      filteredMemes.value = memes;
    } else {
      filteredMemes.value = memes.where((meme) => meme.name!.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }
}
