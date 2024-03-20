import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../../../models/Product.dart';

class VerticalPlaceItem extends StatefulWidget {
  final Product place;
  VerticalPlaceItem({required this.place});
  @override
  State<VerticalPlaceItem> createState() => _VerticalPlaceItemState();
}

class _VerticalPlaceItemState extends State<VerticalPlaceItem> {
  var switchFavourite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetailsScreen.routeName,arguments: widget.place);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: InkWell(
          child: Container(
            height: 70.0,
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    widget.place.images[0],
                    height: 70.0,
                    width: 70.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.place.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 3.0),
                      Flexible(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              const SizedBox(width: 3.0),
                              Text(
                                "this pharamacy so bad sdfdsfds sdfdsfdssdfdsfds",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                  color: Colors.blueGrey[300],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          IgnorePointer(
                            ignoring: true,
                            child: RatingBar.builder(
                              //itemSize: 50,
                              initialRating: 3,
                              unratedColor: Colors.grey,
                              //glowColor: Colors.grey,
                              itemCount: 5,
                              itemSize: 13,
                              allowHalfRating: true,
                              glow: false,
                              tapOnlyMode: true, //Colors.amber,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 3,
                              ),
                              onRatingUpdate: (double value) {
                                // value = 3;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          const Text(
                            '12-12-2020',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                ), //   onPressed: () {
                //     // Handle favorite icon press
                //     setState(() {
                //       switchFavourite = !switchFavourite;
                //     });

                //   },

                //   icon:switchFavourite?Icon(Icons.favorite): Icon(Icons.favorite_border),
                // ),
              ],
            ),
          ),
          //  onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (BuildContext context) {
          //       return Details( detail: widget.place["details"],);
          //     },
          //   ),
          // );
          // },
        ),
      ),
    );
  }
}
