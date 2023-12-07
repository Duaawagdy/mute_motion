import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/custombutton.dart';

class RateScreen extends StatefulWidget {
  RateScreen({Key? key}) : super(key: key);

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  String? rateComment;
  double? rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff003248),
        appBar: AppBar(
          title: Text(
            'Rate',
            style: TextStyle(
                fontSize: 25, fontFamily: 'Lato', color: Colors.white),
          ),
          leading: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 30,
              left: 15,
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Provide your feedback about your ride with this passenger',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, fontFamily: 'Lato', color: borderColor),
                  ),
                  SizedBox(
                    height: 61,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {
                      setState(() {
                        rating = value;
                        if (value == 1) {
                          rateComment = 'Awful';
                        } else if (value < 3) {
                          rateComment = 'Weak';
                        } else if (value < 4.5) {
                          rateComment = 'Good';
                        } else {
                          rateComment = 'Excellent';
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    rateComment!,
                    style: TextStyle(
                        fontSize: 24, fontFamily: 'Lato', color: borderColor),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'You rated your passenger',
                    style: TextStyle(
                        fontSize: 14, fontFamily: 'Lato', color: borderColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 18.0, // Set the font size
                        // You can also set other style properties here
                      ),
                      decoration: InputDecoration(
                        hintText: 'Your comment',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 100.0,
                            horizontal: 100), // Adjust the padding
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomButon(
                      text: 'Sumbit',
                      onTap: () {},
                    ),
                  ),
                ]))));
  }
}
