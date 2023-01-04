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
import 'package:slick_garden/utilis/utilis.dart';
import 'package:slick_garden/utilis/widgets/custom_button.dart';
import 'package:slick_garden/utilis/widgets/drawer.dart';
import 'package:slick_garden/utilis/widgets/textform.dart';
import 'package:slick_garden/views/auth/sign_up.dart';
import 'package:slick_garden/views/chat_screen.dart';
import 'package:swipe_to/swipe_to.dart';

class MainQuestion extends StatefulWidget {
  static String routeName = '/ask';
  const MainQuestion({super.key});

  @override
  State<MainQuestion> createState() => _MainQuestionState();
}

class _MainQuestionState extends State<MainQuestion> {
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController textEditingController = TextEditingController();
  final FireStoreMethods fireStoreMethods = FireStoreMethods();

  final fireStoreData = FirebaseFirestore.instance
      .collection('question')
      //.orderBy('timestamp', descending: true)
      .snapshots();
  bool isliked = false;
  bool isSelected = true;
  final ScrollController _controller = ScrollController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    textEditingController.dispose();
    _controller.dispose();
    _advancedDrawerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (_controller.hasClients) {
      _controller.jumpTo(
        _controller.position.maxScrollExtent + 200,
      );
    }
    StreamBuilder(
      stream: AuthMethods().authChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          AuthMethods().setToProvider(context);
          return const MainQuestion();
        }
        return const MainQuestion();
      },
    );
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.65,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.0),
                                          topRight: Radius.circular(25.0),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(13.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Icon(
                                                      Icons.clear_outlined),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    fireStoreMethods
                                                        .question(
                                                            textEditingController
                                                                .text,
                                                            context)
                                                        .then((value) {
                                                      Utilis.toatsMessage(
                                                          'Your Question is posted');
                                                      textEditingController
                                                          .text = '';
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14)),
                                                    child: const Center(
                                                      child: Text('Add'),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: textEditingController,
                                              cursorColor: Colors.red,
                                              maxLines:
                                                  100 ~/ 20, // <--- maxLines
                                              decoration: InputDecoration(
                                                filled: true,
                                                hintText:
                                                    'Start with "What", "Why", "How".....',
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                //contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                          },
                          child: Container(
                            // padding: const EdgeInsets.all(13),
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   '@${provider.username}',
                                //   style: GoogleFonts.abel(
                                //       textStyle: const TextStyle(
                                //           fontWeight: FontWeight.bold,
                                //           color: Colors.blue)),
                                // ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4.0, left: 6),
                                  child: Text('What do you want to ask?',
                                      style: GoogleFonts.abel()),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: fireStoreData,
                            builder: ((context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (!snapshot.hasData) {
                                return const Center(
                                  child: Text("No Question to Show"),
                                );
                              }
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                _controller.jumpTo(
                                    _controller.position.maxScrollExtent);
                              });
                              return ListView.builder(
                                  controller: _controller,
                                  reverse: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: ((context, index) {
                                    return Align(
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
                                                      snapshot.data!.docs[index]
                                                          ['email']
                                                  ? Colors.cyan[100]
                                                  : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10)),
                                            ),
                                            //height: 30,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2.0,
                                                  left: 6,
                                                  right: 6,
                                                  bottom: 6),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Posted by @${snapshot.data!.docs[index]['username']}',
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
                                                            ['question'],
                                                        style: GoogleFonts.abel(
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        20)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          isSelected =
                                                              !isSelected;
                                                          fireStoreMethods
                                                              .updateSelection(
                                                                  snapshot.data!
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'messageId'],
                                                                  isSelected);
                                                          print("================" +
                                                              isSelected
                                                                  .toString());
                                                          print(snapshot.data!
                                                                  .docs[index]
                                                              ['isSelected']);
                                                          fireStoreMethods.updateViewCount(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['messageId'],
                                                              snapshot.data!
                                                                          .docs[
                                                                      index][
                                                                  'isSelected']);
                                                          setState(() {
                                                            {
                                                              {
                                                                isliked =
                                                                    !isliked;
                                                              }
                                                            }
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                              snapshot.data!.docs[
                                                                          index]
                                                                      [
                                                                      'isSelected']
                                                                  ? 'assets/images/liked.png'
                                                                  : 'assets/images/like.png',
                                                              fit: BoxFit.cover,
                                                              height: 30,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                        [
                                                                        'likes']
                                                                    .toString(),
                                                                style: GoogleFonts.abel(
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                            20)),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      // provider.email ==
                                                      //         snapshot.data!
                                                      //                     .docs[
                                                      //                 index]
                                                      //             ['email']
                                                      //     ? Image.asset(
                                                      //         'assets/images/edit.png',
                                                      //         fit: BoxFit.cover,
                                                      //         height: 30,
                                                      //       )
                                                      //     : Container(),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      ((context) =>
                                                                          ChatScreen(
                                                                            id: snapshot.data!.docs[index]['messageId'],
                                                                            text:
                                                                                snapshot.data!.docs[index]['question'],
                                                                            date:
                                                                                DateTimeFormat.format(DateTime.fromMicrosecondsSinceEpoch(snapshot.data!.docs[index]['createdAt'].microsecondsSinceEpoch), format: r'g:i a · M j, Y').substring(0, 8),
                                                                          ))));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/comment.png',
                                                              fit: BoxFit.cover,
                                                              height: 30,
                                                            ),
                                                            Text('Answer it',
                                                                style:
                                                                    GoogleFonts
                                                                        .abel()),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                          DateTimeFormat.format(
                                                                  DateTime.fromMicrosecondsSinceEpoch(snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
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
                                                                          12))),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                            })))
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
