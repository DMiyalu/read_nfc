import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget circlarPercentIndicator(context) {
  return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: Colors.white)),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Producteurs',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 20.0,
                      percent: 0.75,
                      center: Text(
                        "758523", // goal here mission
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 16),
                      ),
                      linearGradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: <Color>[
                            Colors.lightGreenAccent,
                            Colors.green
                          ]),
                      rotateLinearGradient: true,
                      circularStrokeCap: CircularStrokeCap.round)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Cartes livrées',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CircularPercentIndicator(
                      //radius: screenWidth / 4,
                      radius: 60.0,
                      lineWidth: 20.0,
                      percent: 0.50,
                      center: Text(
                        "50",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 16),
                      ),
                      linearGradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: <Color>[Colors.purple, Colors.deepPurple]),
                      rotateLinearGradient: true,
                      circularStrokeCap: CircularStrokeCap.round)
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ));
}

Widget listdata(contex) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: stocksList.length,
    itemBuilder: (context, index) {
      return containerCard(context, index);
    },
  );
}

class DataList {
  String? text;
  String? subtext;

  DataList({this.text, this.subtext});
}

bool _value = true;
List stocksList = [
  DataList(
      text: "Enregistrement des producteurs",
      subtext:
          '2 000 000 des prudcteurs Lorem Ipsum is simply dummy text of the p Ipsum is simply'),
  DataList(
      text: "Livrer les cartes nfc",
      subtext: '50 000 000printing and typesetting'),
  DataList(
      text: "Faire le suivi", subtext: '1 000 000 Lorem Ipsum is simply dummy'),
  DataList(
      text: "Enregistrement des producteurs",
      subtext: 'Ipsum is simply dummy text of the printing and typesetting'),
  DataList(
      text: "Enregistrement des producteurs",
      subtext: 'Ipsum is simply dummy text of the printing and typesetting'),
];

Widget containerCard(context, int index) {
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ListTile(
          title: Text(
            '${stocksList[index].text}',
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
          ),
          subtitle: Text(
            '${stocksList[index].subtext}',
            style: const TextStyle(
                fontSize: 12, color: const Color.fromARGB(255, 48, 45, 45)),
          ),
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              border: Border.all(
                color: Colors.green,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: _value
                  ? const Icon(
                      Icons.check,
                      size: 15.0,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.cancel,
                      size: 15.0,
                      color: Colors.black12,
                    ),
            ),
          ),
        ),
      ),
    ),
  );
}
