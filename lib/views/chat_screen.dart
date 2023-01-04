import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slick_garden/providers/user_provider.dart';
import 'package:slick_garden/utilis/firebase.dart';
import 'package:slick_garden/utilis/firestore.dart';
import 'package:slick_garden/utilis/widgets/drawer.dart';
import 'package:slick_garden/utilis/widgets/textform.dart';
import 'package:slick_garden/views/auth/sign_up.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = '/chat';
  final String? id;
  final String text;
  final String date;
  const ChatScreen(
      {super.key, this.id, required this.text, required this.date});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController textEditingController = TextEditingController();
  final FireStoreMethods fireStoreMethods = FireStoreMethods();

  // final fireStoreData = FirebaseFirestore.instance
  //     .collection('question').doc(widget.id!).collection('answers')
  //     //.orderBy('timestamp', descending: true)
  //     .snapshots();
  int length = 0;
  final ScrollController _controller = ScrollController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    textEditingController.dispose();
    _controller.dispose();
    _advancedDrawerController.dispose();
    super.dispose();
  }

  data() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('question')
        .doc(widget.id)
        .collection('answers')
        .get();

    setState(() {
      length = snapshot.docs.length;
    });
  }

  @override
  void initState() {
    if (_controller.hasClients) {
      _controller.jumpTo(
        _controller.position.maxScrollExtent + 200,
      );
    }
    data();

    // StreamBuilder(
    //   stream: AuthMethods().authChanges,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     if (snapshot.hasData) {
    //       AuthMethods().setToProvider(context);
    //       //return const ChatScreen();
    //     }
    //     //return const ChatScreen();
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvide>(context).user;

    return MyDrawer(
        controller: _advancedDrawerController,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: const Text(
              'Slick Garden',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: InkWell(
                    onTap: () {
                      AuthMethods().logout(context);
                    },
                    child: const Icon(Icons.logout_outlined)),
              )
            ],
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
          body: provider.email != ''
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        //height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Text(
                              widget.text,
                              style: GoogleFonts.abel(
                                  textStyle: const TextStyle(fontSize: 20)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/comment.png',
                                      fit: BoxFit.cover,
                                      height: 30,
                                    ),
                                    Text(length.toString())
                                  ],
                                ),
                                Text(widget.date, style: GoogleFonts.abel())
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      'Answers',
                      style: GoogleFonts.abel(
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    )),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('question')
                              .doc(widget.id!)
                              .collection('answers')
                              //.orderBy('timestamp', descending: true)
                              .snapshots(),
                          builder: ((context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: Text("No Messages to Show"));
                            } else if (snapshot.hasData) {
                              // setState(() {
                              //   isMe = true;
                              // });
                              // _scrollDown();
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                _controller.jumpTo(
                                    _controller.position.maxScrollExtent);
                              });
                              return ListView.builder(
                                  controller: _controller,
                                  itemCount: snapshot.data!.docs.length,
                                  reverse: true,
                                  itemBuilder: ((context, index) {
                                    return SwipeTo(
                                      onRightSwipe: () {
                                        focusNode.requestFocus();
                                      },
                                      child: Align(
                                        alignment: provider.email ==
                                                snapshot.data!.docs[index]
                                                    ['email']
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 2.0,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0, left: 8, right: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: provider.email ==
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ['email']
                                                      ? Colors.green[100]
                                                      : Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(10),
                                                          bottomLeft: Radius
                                                              .circular(10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  border: Border.all()),
                                              //height: 30,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0,
                                                    left: 6,
                                                    right: 6,
                                                    bottom: 6),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ['username'],
                                                          style: GoogleFonts.abel(
                                                              textStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .blue),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ['answer'],
                                                          style: GoogleFonts
                                                              .abel(),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                        DateTimeFormat.format(
                                                                DateTime.fromMicrosecondsSinceEpoch(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                        [
                                                                        'createdAt']
                                                                    .microsecondsSinceEpoch),
                                                                format:
                                                                    r'g:i a · M j, Y')
                                                            .substring(0, 8),
                                                        style: GoogleFonts.abel(
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10)))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                            }
                            return Container();
                          })),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyFormFeild(
                                focusNode: focusNode,
                                controller: textEditingController,
                                hintText: "Write your Answer"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: InkWell(
                                      onTap: () {
                                        //_scrollDown();
                                        //scrollToBottom().then((value) {});

                                        fireStoreMethods
                                            .chat(textEditingController.text,
                                                widget.id!, context)
                                            .then((value) {
                                          data();
                                        });
                                        setState(() {
                                          textEditingController.text = '';
                                        });
                                      },
                                      child: const Icon(Icons.send)))),
                        )
                      ],
                    ),
                  ],
                )
              : Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You must have an ", style: GoogleFonts.abel()),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: Text(
                          "account",
                          style: GoogleFonts.abel(
                              textStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        )),
                    Text(" to chat", style: GoogleFonts.abel()),
                  ],
                )),
        ));
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
