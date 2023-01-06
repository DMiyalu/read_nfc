import 'package:flutter/material.dart';

BoxDecoration _onFocus(context) {
  return BoxDecoration(
    color: Theme.of(context).colorScheme.primary.withOpacity(.1),
  );
}

Widget nameField(context,
    {bool obscureText = false,
    required String label,
    required String hint,
    required TextEditingController text,
    required IconData icon}) {
  return Container(
    decoration: _onFocus(context),
    padding: const EdgeInsets.only(bottom: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14, top: 8),
          child: Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 13)),
        ),
        TextFormField(
          controller: text,
          cursorColor: Theme.of(context).colorScheme.secondary,
          style: Theme.of(context).textTheme.bodyText1,
          obscureText: obscureText,
          decoration: inputDecoration(context, hint: hint, icon: icon),
          onChanged: (String value) {},
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Mettez $label";
              // show error
            }
            return null;
          },
        ),
      ],
    ),
  );
}

InputDecoration inputDecoration(context,
    {required String hint, required IconData icon}) {
  return InputDecoration(
      constraints: const BoxConstraints(
        maxHeight: 25,
      ),
      suffixIcon: Ink(
          padding: const EdgeInsets.only(bottom: 30),
          child: Icon(icon,
              size: 16, color: Theme.of(context).colorScheme.tertiary)),
      filled: false,
      hintText: hint,
      focusedBorder: enableBorderStyle(context),
      fillColor: Theme.of(context).colorScheme.tertiary.withOpacity(.1),
      focusColor: Colors.black,
      hoverColor: Theme.of(context).colorScheme.secondary,
      labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 15,
            color: Theme.of(context).colorScheme.tertiary,
          ),
      enabledBorder: enableBorderStyle(context),
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
      hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Theme.of(context).colorScheme.tertiary, fontSize: 13));
}

OutlineInputBorder enableBorderStyle(context) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
      gapPadding: 4.5);
}
