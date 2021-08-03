import 'package:flutter/material.dart';
import 'package:twillo_strip_down/screens/twillo_card_list.dart';

/// Home screen may house elements other than just list of cards.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Twillo Strip Down')),
      body: TwilloList(),
    );
  }
}
