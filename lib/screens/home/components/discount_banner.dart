import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('object');
        // Handle the container click event here
        // For example, navigate to a new screen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => NewScreen(),
        //   ),
        // );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF4A3298),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text.rich(
          TextSpan(
            style: TextStyle(color: Colors.white),
            children: [
              // TextSpan(text: "A Summer Surpise\n"),
              TextSpan(
                text: "Repair Order Now",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
