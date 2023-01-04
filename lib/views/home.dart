import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slick_garden/views/chat_screen.dart';
import 'package:slick_garden/views/herbs_screen.dart';
import 'package:slick_garden/views/main_chat.dart';
import 'package:slick_garden/views/vegetables.dart';
import 'package:slick_garden/views/vid_screen.dart';

class MenuScreen extends StatelessWidget {
  static String routeName = '/home';
  MenuScreen({super.key});

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.green[200],
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.black,
          iconColor: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => MenuScreen())));
                },
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/house.png',
                    fit: BoxFit.cover,
                    scale: 12,
                  ),
                ),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const HerbsPage())));
                },
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/herbs.png',
                    fit: BoxFit.cover,
                    height: 40,
                  ),
                ),
                title: const Text('Herbs'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const VegetablePage())));
                },
                leading:
                    Image.asset('assets/images/veg.png', fit: BoxFit.cover),
                title: const Text('Vegetables'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const VideosScreen())));
                },
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/videos.png',
                    fit: BoxFit.cover,
                    height: 40,
                  ),
                ),
                title: const Text('Videos'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const MainQuestion())));
                },
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/ask.png',
                    fit: BoxFit.cover,
                    height: 40,
                  ),
                ),
                title: const Text('Community'),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Text(
                    'Terms of Service | Privacy Policy',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
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
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.centerLeft, // use aligment
                    color: Colors.white,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const HerbsPage())));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                    color: Colors.green[200],
                                    // border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset('assets/images/herbs.png',
                                    height: 100, width: 100, fit: BoxFit.cover),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Herbs",
                                  style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const VegetablePage())));
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green[200],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset('assets/images/veg.png',
                                    height: 150, width: 150, fit: BoxFit.cover),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Vegetables",
                                  style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.centerLeft, // use aligment
                    color: Colors.white,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const MainQuestion())));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                    color: Colors.green[200],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset('assets/images/ask.png',
                                    height: 100, width: 100, fit: BoxFit.cover),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Community",
                                  style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const VideosScreen())));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                    color: Colors.green[200],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset('assets/images/videos.png',
                                    height: 100, width: 100, fit: BoxFit.cover),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Videos",
                                  style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
