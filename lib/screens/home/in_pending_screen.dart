import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Order_details.dart';
import 'package:shop_app/screens/cart/components/cart_card.dart';
import 'package:shop_app/screens/cart/components/check_out_card.dart';

import '../../constants.dart';

class InPendingScreen extends StatefulWidget {
  static String routeName = "/inpending";
  const InPendingScreen({super.key});

  @override
  State<InPendingScreen> createState() => _InPendingScreenState();
}

class _InPendingScreenState extends State<InPendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Your Orders Status",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${demoOrders.length} orders",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: demoOrders.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
                key: Key(demoOrders[index].product.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    demoOrders.removeAt(index);
                  });
                },
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 88,
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child:
                              Image.asset(demoOrders[index].product.images[0]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          demoOrders[index].product.title,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),Text.rich(
                              TextSpan(
                                text: demoOrders[index].order_status,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor),
                                // children: [
                                //   TextSpan(
                                //       text: " x${demoOrders[index].numOfItem}",
                                //       style: Theme.of(context).textTheme.bodyLarge),
                                // ],
                              ),
                            ),
                        const SizedBox(height: 8),]
                      //   Row(
                      //     children: [
                            
                        
                      //       GestureDetector(
                      //         onTap: () {
                      //           // Your onTap callback logic here
                      //           print("YES!");
                      //         },
                      //         child: const Text(
                      //           "YES",
                      //           style: TextStyle(
                      //             color: Colors.blue,
                      //             decoration: TextDecoration.underline,
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 16,
                      //       ),
                      //       GestureDetector(
                      //         onTap: () {
                      //           // Your onTap callback logic here
                      //           print("NO!");
                      //         },
                      //         child: const Text(
                      //           "NO",
                      //           style: TextStyle(
                      //             color: Colors.blue,
                      //             decoration: TextDecoration.underline,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ],
                    )
                  ],
                )),
          ),
        ),
      ),
      //bottomNavigationBar:  CheckoutCard(),
    );
  }
}
