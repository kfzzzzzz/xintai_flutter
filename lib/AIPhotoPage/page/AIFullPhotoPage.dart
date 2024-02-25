import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';

class AIFullPhotoPage extends StatefulWidget {
  const AIFullPhotoPage({super.key, required this.ImageUrl});

  final String? ImageUrl;

  @override
  State<AIFullPhotoPage> createState() => _AIFullPhotoPage();
}

class _AIFullPhotoPage extends State<AIFullPhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: GestureDetector(
                child: Image.network(widget.ImageUrl ?? ""),
                onLongPress: () {
                  _copyImageToClipboard(widget.ImageUrl);
                },
              ),
            ),
            Positioned(
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  print(widget.ImageUrl);
                  BoostNavigator.instance.pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _copyImageToClipboard(String? imageUrl) {
    if (imageUrl != null) {
      Clipboard.setData(ClipboardData(text: imageUrl));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('图片链接已复制到剪贴板'),
        ),
      );
    }
  }
}
