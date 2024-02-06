import 'package:flutter/material.dart';
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
              child: Image.network(widget.ImageUrl ?? ""),
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
}
