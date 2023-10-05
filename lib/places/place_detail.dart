import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'place.dart'; // Import your Place class

class PlaceDetailsScreen extends StatelessWidget {
  final Place place;

  PlaceDetailsScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.name, 
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold, 
            )
        ),
        backgroundColor: const Color(0xFFFF5900),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8, 
              height: 256.0, 
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 16/9, 
                  enlargeCenterPage: true,
                ),
                items: place.imgUrls.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(FontAwesomeIcons.calendarCheck),
                      const SizedBox(height: 8.0),
                      Text(
                        place.openDays,
                        //style: informationTextStyle,
                      ),
                    ], // Center vertically
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(FontAwesomeIcons.clock),
                      const SizedBox(height: 8.0),
                      Text(
                        place.openTime,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        //style: informationTextStyle,
                      ),
                    ], // Center vertically
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(FontAwesomeIcons.moneyBill),
                      const SizedBox(height: 8.0),
                      Text(
                        "¥${place.price}",
                        //style: informationTextStyle,
                      ),
                    ], // Center vertically
                  ),
                ),
              ],
            ),
      
                    
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(place.details),
                  SizedBox(height: 16.0),
      
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}