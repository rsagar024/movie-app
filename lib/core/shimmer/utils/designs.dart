import 'package:flutter/material.dart';

Widget posterPlaceholder({
  required double height,
  required double width,
}) {
  return Container(
    margin: const EdgeInsets.only(
      right: 20,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    height: height,
    width: width,
  );
}

Widget scrollingPlaceholder(BuildContext context) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.35,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
    ),
  );
}

Widget textPlaceholder({required double width}){
  return Container(
    width: width,
    height: 12,
    margin: const EdgeInsets.only(
      right: 20,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
    ),
  );
}
