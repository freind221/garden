import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slick_garden/utilis/utilis.dart';

class AddVideos extends StatefulWidget {
  const AddVideos({super.key});

  @override
  State<AddVideos> createState() => _AddVideosState();
}

class _AddVideosState extends State<AddVideos> {
  final TextEditingController controller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("videos");
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Enter Url of Video",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  final String id =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  firestore
                      .doc(id)
                      .set({'url': controller.text.toString(), 'id': id}).then(
                          (value) {
                    setState(() {
                      isLoading = false;
                    });
                    Utilis.toatsMessage("Video Added Successfully");
                  }).onError((error, stackTrace) {
                    setState(() {
                      isLoading = false;
                    });
                    Utilis.toatsMessage(error.toString());
                  });
                },
                child: isLoading
                    ? Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(
                          value: 4,
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
