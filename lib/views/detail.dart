import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slick_garden/providers/veg_rovider.dart';
import 'package:slick_garden/utilis/widgets/bottom_sheet.dart';
import 'package:slick_garden/utilis/widgets/containor.dart';

class VegetableDetail extends StatefulWidget {
  const VegetableDetail({super.key});

  @override
  State<VegetableDetail> createState() => _VegetableDetailState();
}

class _VegetableDetailState extends State<VegetableDetail> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VegetableProvider>(context).vegetables;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(provider.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 315,
                    left: 315,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            context: context,
                            builder: ((context) => MySheet(
                                  care: provider.care,
                                )));
                      },
                      child: const Icon(
                        Icons.info_outline_rounded,
                        size: 35,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -15.0,
                    left: 10.0,
                    right: 10.0,
                    child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              provider.vegeName,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        width: 140,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.wb_sunny_outlined),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "Light",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      provider.light,
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
                      ),
                    ),
                    MyContainor(
                        text: 'Temprature',
                        title: provider.temprature,
                        icon: Icons.thermostat_auto_outlined)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 27),
                child: Row(
                  children: [
                    MyContainor(
                        text: 'Sow Month',
                        title: provider.sowMonth,
                        icon: Icons.thermostat_auto_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    MyContainor(
                        text: 'Crop Month',
                        title: provider.cropMonth,
                        icon: Icons.thermostat_auto_outlined),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 30, right: 30),
                child: Text(
                  provider.description,
                  style: GoogleFonts.abel(
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ) //Ce
        );
  }
}
