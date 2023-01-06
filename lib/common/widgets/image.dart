import 'dart:convert';
import 'package:flutter/material.dart';

Widget imagePreview(
    {required String base64String,
    required double width,
    required double height}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Image.memory(
        base64Decode(base64String),
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    ),
  );
}