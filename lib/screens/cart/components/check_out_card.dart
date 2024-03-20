import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';

class CheckoutCard extends StatelessWidget {
  final String visitDate;
  final String problemDescription;
  final List<File> selectedImages;

  CheckoutCard(
      {required this.visitDate,
      required this.problemDescription,
      required this.selectedImages});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                const Spacer(),
                // const Text("Add voucher code"),
                const SizedBox(width: 8),
                const Icon(
                  Icons.send,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // const Expanded(
                //   child: Text.rich(
                //     TextSpan(
                //       text: "Total:\n",
                //       children: [
                //         TextSpan(
                //           text: "\$337.15",
                //           style: TextStyle(fontSize: 16, color: Colors.black),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Order submitted successfully!'),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                              top: 0.0, left: 16.0, right: 16.0, bottom: 0),
                        ),
                      );
                      print(this.visitDate);
                      print(this.problemDescription);
                      print(this.selectedImages.length);
                    },
                    child: const Text("Send Order"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
