import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _searchInputField(context),
    );
  }
}

Widget _searchInputField(context) {
  return TextFormField(
    style: Theme.of(context).textTheme.bodyText1,
    decoration: InputDecoration(
      suffixIcon: _suffixIcon(context),
      hintText: "Recherche",
      hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Theme.of(context).colorScheme.tertiary, fontSize: 13),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      focusColor: Colors.black,
      hoverColor: Theme.of(context).colorScheme.secondary,
      labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 15,
            color: Theme.of(context).colorScheme.tertiary,
          ),
    ),
    onChanged: (String text) {},
    validator: (String? value) {
      return null;
    },
  );
}

Widget _suffixIcon(context) {
  return Ink(
    height: 30,
    width: 30,
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(50),
      child: Icon(
        Icons.search_sharp,
        size: 20,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    ),
  );
}
