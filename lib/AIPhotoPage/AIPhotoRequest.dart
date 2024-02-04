import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:xintai_flutter/AIPhotoPage/CivitaiModel.dart';

class AIPhotoManager {
  late final String apiKey;
  late List<CivitaiImageItem> imageItems;
  static const platform = MethodChannel('xinTai/MethodChannel');

  Future<void> getCivitaiKey() async {
    try {
      final String result = await platform.invokeMethod('getCivitaiKey');
      apiKey = result;
    } on PlatformException catch (e) {
      apiKey = "Failed to CivitaiKey: '${e.message}'.";
    }
  }

  Future<List<CivitaiImageItem>> fetchData(int page) async {
    final response = await http.get(Uri.parse(
        'https://civitai.com/api/v1/images?nsfw=None&page=$page&limit=10'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData['items'];
      imageItems =
          items.map((item) => CivitaiImageItem.fromJson(item)).toList();
      return imageItems;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
