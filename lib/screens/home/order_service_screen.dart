import 'package:flutter/material.dart';
import 'package:shop_app/models/places.dart';
import 'package:shop_app/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_app/screens/home/components/search_field.dart';
import 'package:shop_app/screens/home/components/vertical_place_item.dart';

import '../../models/Product.dart';
import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';

class OrderServiceScreen extends StatelessWidget {
  static String routeName = "/orderservice";

  const OrderServiceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              HomeHeader(),
              DiscountBanner(),
               Categories(),
               buildVerticalList(),
              // SpecialOffers(),
              // SizedBox(height: 20),
              // PopularProducts(),
              // SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }



  buildVerticalList() {
    // _performSearch();
    // print(widget.searchEnter);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: demoProducts == null ? 0 : demoProducts.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = demoProducts[index];
          return VerticalPlaceItem(place: demoProducts[index]);
        },
      ),
    );
  }

  
}
