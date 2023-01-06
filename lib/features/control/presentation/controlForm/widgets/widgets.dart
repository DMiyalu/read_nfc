import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/features/control/presentation/cubit/control_cubit.dart';
import 'package:sigi_android/features/control/presentation/cubit/control_state.dart';
import 'package:sigi_android/features/suivi/presentation/cubit/monitoring_cubit.dart';

AppBar appBar(context) {
  return AppBar(
    leading: InkWell(
      onTap: () => Get.back(),
      child: Icon(
        Icons.arrow_back_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      'Controle',
      style: Theme.of(context).textTheme.bodyText1,
    ),
  );
}

Widget images(context) {
  return BlocBuilder<ControlCubit, ControlState>(
      builder: (context, state) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
      child: GridView.count(
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: state.field!['data']['photos'].isEmpty
            ? <Widget>[placeholderImage(context)]
            : state.field!['data']['photos'].map<Widget>((image) {
                return imageItem(context, image);
              }).toList(),
      ),
    );
  });
}

Widget placeholderImage(context) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      image: const DecorationImage(
        image: AssetImage("assets/images/img1.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.6),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Ink(
        child: InkWell(
          onTap: () {},
          child: const Icon(
            Icons.image_not_supported_rounded,
            size: 14,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget imageItem(context, String? image) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Image.memory(
          base64Decode(image!),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 25,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.4),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Ink(
            child: InkWell(
              onTap: () => BlocProvider.of<MonitoringCubit>(context)
                  .onDeleteImage(image),
              child: const Icon(
                Icons.delete_rounded,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// Widget imageItem(context, String? imagePath) {
//   return Container(
//     alignment: Alignment.bottomLeft,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(5),
//       image: DecorationImage(
//         image: AssetImage(imagePath!),
//         //      Image.memory(
//         //   base64Decode(""),
//         //   width: 50,
//         //   height: 50,
//         //   fit: BoxFit.cover,
//         // ),
//         fit: BoxFit.cover,
//       ),
//     ),
//     child: Container(
//       height: 25,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(.4),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(5),
//           bottomRight: Radius.circular(5),
//         ),
//       ),
//       child: Ink(
//         child: InkWell(
//           onTap: () {},
//           child: const Icon(
//             Icons.delete_rounded,
//             size: 14,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     ),
//   );
// }
