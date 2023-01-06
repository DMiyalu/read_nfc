import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appBar(context, {required String text, Function? onTap}) {
  return AppBar(
    leading: InkWell(
      onTap: () => onTap!() ?? Get.back(),
      child: Icon(
        Icons.arrow_back_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      text,
      style: Theme.of(context).textTheme.bodyText1,
    ),
  );
}
