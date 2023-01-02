import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:slick_garden/utilis/widgets/drawer.dart';
import 'package:slick_garden/views/add_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as you;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  // ignore: unused_field
  late YoutubePlayerController _controller;

  final fireStoreData =
      FirebaseFirestore.instance.collection("videos").snapshots();

  List vidIds = [];

  @override
  Widget build(BuildContext context) {
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
          body: StreamBuilder<QuerySnapshot>(
            stream: fireStoreData,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    vidIds.add(you.YoutubePlayer.convertUrlToId(
                        snapshot.data!.docs[index]['url']));
                    _controller = YoutubePlayerController.fromVideoId(
                      videoId: vidIds[index],
                      autoPlay: false,
                      params: const YoutubePlayerParams(
                          showFullscreenButton: false),
                    );
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: YoutubePlayer(
                              enableFullScreenOnVerticalDrag: false,
                              controller: YoutubePlayerController.fromVideoId(
                                videoId: vidIds[index],
                                autoPlay: false,
                                params: const YoutubePlayerParams(
                                    showFullscreenButton: false),
                              )),
                        ),
                      ],
                    );
                  }));
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const AddVideos())));
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
