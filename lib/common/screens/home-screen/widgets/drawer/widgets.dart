import 'package:flutter/material.dart';

Widget profilMenuItem(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _userAvatar(context),
      const SizedBox(height: 15),
      _userName(context),
      const SizedBox(height: 5),
      _userFonction(context),
    ],
  );
}

Widget _userName(context) {
  return Text(
    'Gad Tshimama',
    style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 16,
        ),
  );
}

Widget _userFonction(context) {
  return Text(
    'Moniteur AgroMwinda',
    style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 14,
        ),
  );
}

Widget _userAvatar(context) {
  String photoPath = "photo";
  if (photoPath.isEmpty) {
    return GestureDetector(
      onTap: () {},
      child: _avatarPlaceHolder(context, label: "AG"),
    );
  }

  return GestureDetector(
    onTap: () {},
    child: Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(
                color: Colors.blueGrey.shade600,
                width: 3.5,
              )),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/images/user.png",
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Positioned(
          bottom: 5,
          right: 5,
          child: Icon(
            Icons.circle,
            size: 10,
            color: Colors.green,
          ),
        ),
      ],
    ),
  );
}

Widget _avatarPlaceHolder(context, {required String label}) {
  return Container(
    width: 60,
    height: 60,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blueGrey.shade600,
          width: 3.5,
        )),
    child: Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.white,
            fontSize: 16,
          ),
      textAlign: TextAlign.center,
    ),
  );
}
