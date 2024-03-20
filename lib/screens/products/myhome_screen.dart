import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/home/order_service_screen.dart';

import '../details/details_screen.dart';
import '../home/components/icon_btn_with_counter.dart';

class MyHomeScreen extends StatefulWidget {
  static String routeName = "/myhome";

  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          const SizedBox(height: 16),
               Align(
                alignment: Alignment.topRight, // Adjust the alignment as needed
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: IconBtnWithCounter(
                    svgSrc: "assets/icons/Bell.svg",
                    numOfitem: 3,
                    press: () {},
                  ),
                ),
              ),
        ],
        // Add the leading icon for the drawer
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text("Products"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Handle drawer item tap
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle drawer item tap
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
          const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: demoProducts.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 160,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    product: demoProducts[index],
                    onPress: () => Navigator.pushNamed(
                      context,
                      OrderServiceScreen.routeName,
                      arguments: ProductDetailsArguments(
                        product: demoProducts[index],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}