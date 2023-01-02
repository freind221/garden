import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:slick_garden/views/chat_screen.dart';
import 'package:slick_garden/views/herbs_screen.dart';
import 'package:slick_garden/views/home.dart';
import 'package:slick_garden/views/vegetables.dart';
import 'package:slick_garden/views/vid_screen.dart';

class MyDrawer extends StatelessWidget {
  final Widget child;
  final AdvancedDrawerController controller;
  const MyDrawer({super.key, required this.child, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        backdropColor: Colors.green[200],
        controller: controller,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MenuScreen())));
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
                      scale: 12,
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
                            builder: ((context) => const ChatScreen())));
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
        child: child);
  }
}
