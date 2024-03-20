import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages

import '../../models/Cart.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen();

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late DateTime selectedDate;
  late TextEditingController _textController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final List<File> selectedImages = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Customize button text style
            ),
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Customize color scheme
            ).copyWith(secondary: Colors.blue),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _dateController.text =
              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day} ${pickedTime.format(context)}";
          print(_dateController.text);
        });
      }
    }
  }

  Future<void> addImages() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage(
      maxWidth: 800, // can be customized
      maxHeight: 600, // can be customized
    );

    if (images != null) {
      for (XFile image in images) {
        selectedImages.add(File(image.path));
      }
      setState(() {}); // Trigger rebuild to show selected images
      //print(selectedImages);
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _dateController.text =
        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              "Your Order",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
           
            const SizedBox(height: 20.5),
            TextFormField(
              controller: _dateController,
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.access_alarm_outlined),
                labelText: "Schedule Visit Time",
                border: OutlineInputBorder(),
              ),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 20.5),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                  labelText: "your problem",
                  border: OutlineInputBorder(),
                  hintText: "Describe your problem"),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: addImages,
              child: const Text('Add Images'),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(selectedImages[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  CheckoutCard(visitDate: _dateController.text,problemDescription: _textController.text,selectedImages: selectedImages),
    );
  }
}
