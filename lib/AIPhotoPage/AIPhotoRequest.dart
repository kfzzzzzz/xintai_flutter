import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:xintai_flutter/AIPhotoPage/CivitaiModel.dart';

class AIPhotoManager {
  late final String apiKey;
  late List<CivitaiImageItem> imageItems;
  late List<CivitaiModel> modelItems;
  late List<CivitaiModelVersion> modelVersionItems;
  static const platform = MethodChannel('xinTai/MethodChannel');

  Future<void> getCivitaiKey() async {
    try {
      final String result = await platform.invokeMethod('getCivitaiKey');
      apiKey = result;
    } on PlatformException catch (e) {
      apiKey = "Failed to CivitaiKey: '${e.message}'.";
    }
  }

  Future<List<CivitaiImageItem>> getCivitaiImage(int page) async {
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

  Future<List<CivitaiImageItem>> getCivitaiModel(int page, String sort) async {
    late var response;
    if (sort != 'Random') {
      response = await http.get(Uri.parse(
          'https://civitai.com/api/v1/models?page=$page&limit=1&sort=$sort'));
      print('https://civitai.com/api/v1/models?page=$page&limit=1&sort=$sort');
    } else {
      int page = Random().nextInt(112290);
      response = await http.get(
          Uri.parse('https://civitai.com/api/v1/models?page=$page&limit=1'));
      print('https://civitai.com/api/v1/models?page=$page&limit=1');
    }
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData['items'];
      modelItems = items.map((item) => CivitaiModel.fromJson(item)).toList();
      modelVersionItems = modelItems[0].modelVersions;
      imageItems = modelVersionItems[0].images;
      return imageItems;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
