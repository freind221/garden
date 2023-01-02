import 'package:flutter/material.dart';

class MyContainor extends StatelessWidget {
  final String text;
  final String title;
  final IconData icon;
  const MyContainor(
      {super.key, required this.text, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 140,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
