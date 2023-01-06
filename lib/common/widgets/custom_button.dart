import 'package:flutter/material.dart';

Widget customButton(context,
    {String? text,
    Color? textColor,
    Color? bkgColor,
    Color? overlayColor,
    bool? showBorder = false,
    bool? bigger = false,
    required Function onPressed}) {
  return Flex(
    direction: Axis.horizontal,
    children: [
      Expanded(
        child: TextButton(
            onPressed: () => onPressed(),
            style: ButtonStyle(
                side: MaterialStateProperty.all(showBorder!
                    ? BorderSide(
                        color: Theme.of(context).colorScheme.primary, width: 1)
                    : BorderSide.none),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 15)),
                alignment: Alignment.center,
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: MaterialStateProperty.all(bkgColor),
                overlayColor: MaterialStateProperty.all(overlayColor ??
                    Theme.of(context).primaryColorLight.withOpacity(.1))),
            child: Text(
              text!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: textColor),
            )),
      ),
    ],
  );
}

Widget floatingActionButton(context, {required String tag, required Function onTap, required IconData icon}) {
    return Hero(
      tag: tag,
      child: Container(
        width: 55,
        height: 55,
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () => onTap(),
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }