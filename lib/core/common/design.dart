import 'package:flutter/material.dart';

class Design{

  Widget generateField(BuildContext context,String text) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: text,
          hintStyle: const TextStyle(fontFamily: 'SF_Pro',),
        ),
        style: const TextStyle(fontFamily: 'SF_Pro',),
      ),
    );
  }
}