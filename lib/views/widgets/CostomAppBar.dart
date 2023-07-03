import 'package:flutter/material.dart';

class CostomAppBar extends StatelessWidget {
  String word1;
  String word2;
   CostomAppBar({super.key,
   
   required this.word1,
   required this.word2});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text:word1,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text : " $word2",
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.w700)),
              ])),
    );
  }
}
