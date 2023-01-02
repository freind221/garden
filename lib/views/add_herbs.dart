import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slick_garden/providers/drop_down_provider.dart';
import 'package:slick_garden/utilis/firestore.dart';
import 'package:slick_garden/utilis/utilis.dart';
import 'package:slick_garden/utilis/widgets/drop_down.dart';
import 'package:slick_garden/utilis/widgets/textform.dart';

class AddHerbs extends StatefulWidget {
  const AddHerbs({super.key});

  @override
  State<AddHerbs> createState() => _AddHerbsState();
}

class _AddHerbsState extends State<AddHerbs> {
  TextEditingController nameController = TextEditingController();
  TextEditingController careController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController durController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  TextEditingController waterController = TextEditingController();
  TextEditingController lightController = TextEditingController();

  Uint8List? img;

  Future pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    try {
      if (result != null) {
        if (kIsWeb) {
          Uint8List fileBytes = result.files.single.bytes!;
          return fileBytes;
        }
        Uint8List file = await File(result.files.single.path!).readAsBytes();
        // ignore: unnecessary_null_comparison
        if (file != null) {
          Utilis.toatsMessage('Image Picked');
          setState(() {});
          img = file;
        } else {
          Utilis.toatsMessage("No Image Selected");
        }
      }
    } catch (e) {
      Utilis.toatsMessage(e.toString());
    }
  }

  final FireStoreMethods fireStoreMethods = FireStoreMethods();

  @override
  Widget build(BuildContext context) {
    final provir = Provider.of<DropDownProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(border: Border.all()),
                      child: img != null
                          ? Image.memory(
                              img!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyFormFeild(
                      controller: nameController,
                      hintText: "Herb Name",
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Expanded(
                          child: CustomDropDown(
                        items: [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'June',
                          'July',
                          'Agu',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec'
                        ],
                        title: 'Sow Month',
                        check: 'sowMonth',
                      )),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                          child: CustomDropDown(
                        items: [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'June',
                          'July',
                          'Agu',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec'
                        ],
                        title: 'Crop Month',
                        check: 'cropMonth',
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyFormFeild(
                          controller: tempController,
                          hintText: "Temp range",
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: MyFormFeild(
                          controller: lightController,
                          hintText: "Light",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyFormFeild(
                      controller: waterController, hintText: 'Water Required'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyFormFeild(
                      controller: durController, hintText: 'Duration in days'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // <--- SizedBox
                    height: 100,
                    child: TextFormField(
                      controller: descController,
                      cursorColor: Colors.red,
                      maxLines: 100 ~/ 20, // <--- maxLines
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Write description',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        //contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // <--- SizedBox
                    height: 100,
                    child: TextFormField(
                      controller: careController,
                      cursorColor: Colors.red,
                      maxLines: 100 ~/ 20, // <--- maxLines
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Precautions ',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            fireStoreMethods.uploadingHerbs(
                                nameController.text,
                                img,
                                waterController.text,
                                lightController.text,
                                tempController.text,
                                provir.sowMonth,
                                provir.cropMonth,
                                careController.text,
                                descController.text,
                                durController.text,
                                context);
                          },
                          child: const Text("Submit"),
                        ),
                      )),
                )
              ]),
        ),
      ),
    );
  }
}
