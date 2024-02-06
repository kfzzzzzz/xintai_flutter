import 'package:flutter/material.dart';

void showTransparentOverlay(BuildContext context) {
  OverlayEntry? overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.0),
        body: GestureDetector(
          onTap: () {
            overlayEntry?.remove();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.5), // 设置透明背景
              child: const Center(
                child: Text(
                  'This is a transparent overlay.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  Overlay.of(context).insert(overlayEntry);
}
