import 'package:flutter/material.dart';

class catBlock1 extends StatelessWidget {
  String imgSrc;
 catBlock1({super.key , required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
                height: 70,
                width: 100,
                fit: BoxFit.cover,
                imgSrc),
          ),
          Container(
            height: 70,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(15)),
          ),
          Positioned(
            left: 32,
            top: 25,
            child: Text(
              "Cars",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
