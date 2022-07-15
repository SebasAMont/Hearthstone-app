import 'src/card_page.dart';
import 'package:flutter/material.dart';
import 'src/card_constants.dart';

void main() => runApp(const HearthstoneCardApp());

class HearthstoneCardApp extends StatelessWidget {
  const HearthstoneCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: materialAppTitle,
      home: CardPage(),
    );
  }
}
