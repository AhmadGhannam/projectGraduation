import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../screens/cart/cart_screen.dart';
import '../../models/Product.dart';
import 'components/color_dots.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";
  DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    // final product = agrs.product;
    print(product.title);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Text(
                      "4.7",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      ColorDots(product: product),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CartScreen.routeName);
                    },
                    child: const Text("Order Now"),
                  ),
                ),
                const SizedBox(width: 10), // Add spacing between the buttons
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Set the button's background color
                    ),
                    onPressed: () {
                      // Handle the second button's onPressed event
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String selectedReport =
                              ''; // Variable to store the selected report

                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text('Your Report'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title:
                                          const Text('Inappropriate Content'),
                                      leading: Radio(
                                        value: 'inappropriate',
                                        groupValue: selectedReport,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedReport = value.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('Spam'),
                                      leading: Radio(
                                        value: 'spam',
                                        groupValue: selectedReport,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedReport = value.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('Other'),
                                      leading: Radio(
                                        value: 'other',
                                        groupValue: selectedReport,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedReport = value.toString();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Perform some action
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Perform some action
                                      print(selectedReport);
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Report submitted successfully!'),
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.only(
                                              top: 0.0,
                                              left: 16.0,
                                              right: 16.0,
                                              bottom: 0),
                                        ),
                                      );
                                    },
                                    child: const Text('Report'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    child: const Text("Report"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
