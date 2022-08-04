import 'package:flutter/material.dart';
import 'src/core/util/card_constants.dart';
import 'src/presentation/view/card_list.dart';

void main() => runApp(const HearthstoneCardApp());

class HearthstoneCardApp extends StatelessWidget {
  const HearthstoneCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: materialAppTitle,
      home: CardList(),
    );
  }
}
