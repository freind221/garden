import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySheet extends StatefulWidget {
  final String care;
  const MySheet({Key? key, required this.care}) : super(key: key);

  @override
  State<MySheet> createState() => _MySheetState();
}

class _MySheetState extends State<MySheet> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
        child: Column(
          children: [
            const Text(
              'Precautions',
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Text(widget.care,
                    style: GoogleFonts.abel(
                      textStyle:
                          const TextStyle(color: Colors.black, fontSize: 15),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
