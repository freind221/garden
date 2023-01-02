import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slick_garden/providers/herbs_provider.dart';

import 'package:slick_garden/utilis/widgets/drawer.dart';
import 'package:slick_garden/views/add_herbs.dart';

import 'package:slick_garden/views/herbs_detail.dart';

class HerbsPage extends StatefulWidget {
  const HerbsPage({super.key});

  @override
  State<HerbsPage> createState() => _HerbsPageState();
}

class _HerbsPageState extends State<HerbsPage> {
  final _advancedDrawerController = AdvancedDrawerController();
  final fireStoreData =
      FirebaseFirestore.instance.collection('herbs').snapshots();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HerbsProvider>(context);
    return MyDrawer(
        controller: _advancedDrawerController,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Slick Garden'),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: fireStoreData,
                      builder:
                          ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  provider.setVegetable(
                                      snapshot.data!.docs[index]['name'],
                                      snapshot.data!.docs[index]['image'],
                                      snapshot.data!.docs[index]['care'],
                                      snapshot.data!.docs[index]['description'],
                                      snapshot.data!.docs[index]['cropMonth'],
                                      snapshot.data!.docs[index]['sowMonth'],
                                      snapshot.data!.docs[index]['temprature'],
                                      snapshot.data!.docs[index]['duration'],
                                      snapshot.data!.docs[index]['waterAmount'],
                                      snapshot.data!.docs[index]['light'],
                                      snapshot.data!.docs[index]['uid']);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const HerbsDetail())));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 100,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: index % 2 == 0
                                              ? Colors.green[200]
                                              : Colors.blue[100],
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10)),
                                              child: SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(
                                                  snapshot.data!.docs[index]
                                                      ['image'],
                                                  //height: 200.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  snapshot.data!.docs[index]
                                                      ['name'],
                                                  style: GoogleFonts.abel(
                                                    textStyle: const TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(Icons
                                                      .thermostat_auto_sharp),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      '${snapshot.data!.docs[index]['temprature'].toString().substring(0, 5)} °C',
                                                      style: GoogleFonts.abel(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    const Icon(Icons
                                                        .wb_sunny_outlined),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['light'],
                                                        style: GoogleFonts.abel(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.timelapse_outlined),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      snapshot.data!.docs[index]
                                                          ['duration'],
                                                      style: GoogleFonts.abel(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                              );
                            }));
                      })))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const AddHerbs())));
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
