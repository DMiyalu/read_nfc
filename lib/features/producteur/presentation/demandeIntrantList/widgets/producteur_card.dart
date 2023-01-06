import 'package:flutter/material.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';

class ProducteurCard extends StatelessWidget {
  const ProducteurCard({
    Key? key,
    this.trailling,
    this.timeAgo,
    required this.onTap, required this.fields, required this.values,
  }) : super(key: key);
  final Widget? trailling;
  final String? timeAgo;
  final Function onTap;
  final List<String> fields;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _userAvatar(
          context,
          onTap: onTap,
        ),
        _description(context,
            onTap: onTap,
            trailling: trailling,
            timeAgo: timeAgo,
            fields: fields,
            values: values),
      ],
    );
  }
}

Widget _description(
  context, {
  Widget? trailling,
  String? timeAgo,
  required Function onTap,
  required List<String> fields,
  required List<String> values,
}) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondary.withOpacity(.1),
            width: 1),
        top: BorderSide.none,
        left: BorderSide.none,
        right: BorderSide.none,
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _title(
            context,
            onTap: onTap,
            fields: fields,
            values: values,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _trailling(context, timeAgo: timeAgo, trailling: trailling)
            ],
          )
        ],
      ),
    ),
  );
}

Widget _title(
  context, {
  required Function onTap,
  required List<String> fields,
  required List<String> values,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: () => onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: fields
            .asMap()
            .entries
            .map(
              (entry) => _titleItem(
                context,
                field: entry.value,
                value: values[entry.key],
              ),
            )
            .toList(),
      ),
    ),
  );
}

Widget _trailling(context, {Widget? trailling, String? timeAgo}) {
  return Container(
    constraints: const BoxConstraints(maxHeight: 65),
    child: Flex(
      mainAxisSize: MainAxisSize.min,
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(timeAgo ?? '',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(.5),
                  fontSize: 15),
              softWrap: true,
              textAlign: TextAlign.right),
        ),
        Expanded(
            flex: 1,
            child: trailling ??
                const Center(
                  child: SizedBox(),
                ))
      ],
    ),
  );
}

Widget _titleItem(context, {String? field, String? value}) {
  return Ink(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: RichText(
      text: TextSpan(
          text: "$field:   ",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary.withOpacity(.9)),
          children: <TextSpan>[
            TextSpan(
                text: "$value",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color:
                        Theme.of(context).colorScheme.secondary.withOpacity(.5),
                    fontSize: 15))
          ]),
    ),
  );
}

String getLabel({required String firstName, required String lastName}) {
  if (firstName != '') return firstName[0].toString();
  if (lastName != '') return lastName[0].toString();
  return '?';
}

Widget _userAvatar(
  context, {
  // required Map user,
  required Function onTap,
}) {
  return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          padding: const EdgeInsets.only(right: 10),
          child: Stack(
            children: [
              avatarPlaceHolder(context, label: 'AG'),
              // checkIcon(context),
            ],
          )));
}

Widget checkIcon(context) {
  return Positioned(
    right: 0,
    child: Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      padding: const EdgeInsets.all(2),
      child: const Icon(
        Icons.error_outline,
        size: 8,
        color: Colors.white,
      ),
    ),
  );
}

Widget avatarPlaceHolder(context, {required String label}) {
  return Container(
    width: 40,
    height: 40,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue.shade500,
          width: 1.5,
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

Widget previewImageCard(context, {required String imageBlobFile}) {
  return Center(
    child: Container(
      alignment: Alignment.center,
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Preview Image Card',
              style: Theme.of(context).textTheme.bodyText1),
          customButton(
            context,
            onPressed: () {},
            text: "Authentifier l'identité",
            bigger: true,
            bkgColor: Theme.of(context).colorScheme.primary,
            textColor: Colors.white,
          )
        ],
      ),
    ),
  );
}
