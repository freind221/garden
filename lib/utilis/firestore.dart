import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:slick_garden/models/vege_model.dart';
import 'package:slick_garden/providers/user_provider.dart';
import 'package:slick_garden/utilis/storage.dart';
import 'package:slick_garden/utilis/utilis.dart';

class FireStoreMethods {
  final StorageMethods storageMethods = StorageMethods();
  final _firestore = FirebaseFirestore.instance;
  Future<String> uploadingVegetables(
      String title,
      Uint8List? file,
      String waterAmount,
      String light,
      String temprature,
      String sowMonth,
      String cropMonth,
      String care,
      String description,
      String duration,
      BuildContext context) async {
    String channelID = '';

    try {
      if (title.isNotEmpty && file != null) {
        var url = await storageMethods.uploadImageToSource('vegetables', file,
            DateTime.now().millisecondsSinceEpoch.toString());

        final String channelId =
            DateTime.now().millisecondsSinceEpoch.toString();
        channelID = channelId;
        Herbs vegetables = Herbs(
            uid: DateTime.now().hour.toString(),
            vegeName: title,
            image: url,
            care: care,
            cropMonth: cropMonth,
            description: description,
            light: light,
            sowMonth: sowMonth,
            temprature: temprature,
            duration: duration,
            waterAmount: waterAmount);
        _firestore
            .collection('vegetables')
            .doc(DateTime.now().millisecondsSinceEpoch.toString())
            .set(vegetables.toMap())
            .then((value) {
          Utilis.toatsMessage('Uploaded Successfully');
        }).onError((error, stackTrace) {
          Utilis.toatsMessage('Something went wrong');

          channelID = '';
        });
      } else {
        Utilis.toatsMessage('Failed in Uploading');
      }
    } catch (e) {
      Utilis.toatsMessage(e.toString());
    }
    return channelID;
  }

  Future<String> uploadingHerbs(
      String title,
      Uint8List? file,
      String waterAmount,
      String light,
      String temprature,
      String sowMonth,
      String cropMonth,
      String care,
      String description,
      String duration,
      BuildContext context) async {
    String channelID = '';

    try {
      if (title.isNotEmpty && file != null) {
        var url = await storageMethods.uploadImageToSource(
            'herbs', file, DateTime.now().millisecondsSinceEpoch.toString());

        final String channelId =
            DateTime.now().millisecondsSinceEpoch.toString();
        channelID = channelId;
        Herbs herbs = Herbs(
            uid: DateTime.now().hour.toString(),
            vegeName: title,
            image: url,
            care: care,
            cropMonth: cropMonth,
            description: description,
            light: light,
            sowMonth: sowMonth,
            temprature: temprature,
            duration: duration,
            waterAmount: waterAmount);
        _firestore
            .collection('herbs')
            .doc(DateTime.now().millisecondsSinceEpoch.toString())
            .set(herbs.toMap())
            .then((value) {
          Utilis.toatsMessage('Uploaded Successfully');
        }).onError((error, stackTrace) {
          Utilis.toatsMessage('Something went wrong');

          channelID = '';
        });
      } else {
        Utilis.toatsMessage('Failed in Uploading');
      }
    } catch (e) {
      Utilis.toatsMessage(e.toString());
    }
    return channelID;
  }

  Future<void> chat(String text, String id, BuildContext context) async {
    final user = Provider.of<UserProvide>(context, listen: false);

    try {
      final String ansId = DateTime.now().millisecondsSinceEpoch.toString();
      await _firestore
          .collection('question')
          .doc(id)
          .collection('answers')
          .doc(ansId)
          .set({
        'username': user.user.username,
        'email': user.user.email,
        'answer': text,
        'uid': user.user.uid,
        'createdAt': DateTime.now(),
        'answerId': ansId,
      });
    } on FirebaseException catch (e) {
      Utilis.toatsMessage(e.message!);
    }
  }

  Future<void> question(String text, BuildContext context) async {
    final user = Provider.of<UserProvide>(context, listen: false);

    try {
      final String id = DateTime.now().millisecondsSinceEpoch.toString();
      await _firestore.collection('question').doc(id).set({
        'username': user.user.username,
        'email': user.user.email,
        'question': text,
        'uid': user.user.uid + user.user.username,
        'createdAt': DateTime.now(),
        'messageId': id,
        'likes': 0,
        'isSelected': false,
      });
    } on FirebaseException catch (e) {
      Utilis.toatsMessage(e.message!);
    }
  }

  updateSelection(String id, bool selected) async {
    try {
      await _firestore
          .collection('question')
          .doc(id)
          .update({'isSelected': selected});
    } catch (e) {
      Utilis.toatsMessage(e.toString());
    }
  }

  updateViewCount(String channelId, bool isIncreasing) async {
    try {
      await _firestore.collection('question').doc(channelId).update({
        'likes': FieldValue.increment(isIncreasing ? 1 : -1)
      }).onError((error, stackTrace) {
        Utilis.toatsMessage(error.toString());
      });
    } catch (e) {
      Utilis.toatsMessage(e.toString());
    }
  }
}
