import 'package:flutter/material.dart';
import 'package:itinerarybuilder/models/place.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:itinerarybuilder/places/place_detail.dart';
import 'package:itinerarybuilder/service/firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_place.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final String placeId;

  PlaceDetailsScreen({required this.placeId});

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Place List",
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5900)
      ),     
      body: SingleChildScrollView(
        child: FutureBuilder<Place>(
        future: FirestoreService().getPlaceById(widget.placeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot}"));
          } else if (!snapshot.hasData ) {
            return Center(child: Text("No places found."));
          }
            return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                snapshot.data!.Name ?? "Unknown",
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
                height: 256.0, // Adjust the aspect ratio as needed
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9, // Adjust the aspect ratio based on your images
                    enableInfiniteScroll: true,
                    viewportFraction: 1, // This makes it full-width
                  ),
                  items: (snapshot.data!.PhotoUrls ?? []).map((photo) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            photo,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(snapshot.data!.Description ?? "Unknown"),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, bottom: 16),
                child: Text('Address: ${snapshot.data!.Address ?? "Unknown"}'),
              ),
              Column(
                crossAxisAlignment : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0), // Adjust the left padding as needed
                    child: ElevatedButton(
                      onPressed: () {
                        if(snapshot.data!.GoogleMapUrl != null){
                          _launchURL(snapshot.data!.GoogleMapUrl ?? "https://google.com");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Adjust the value for the desired roundness
                        ),
                        primary: Colors.orange, // Set the button's background color to orange
                        onPrimary: Colors.white, // Set the button's text color to white
                      ),
                      child: Text("Direction"), // Replace with your button text
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0), // Adjust the left padding as needed
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Adjust the value for the desired roundness
                        ),
                        primary: Colors.red, // Set the button's background color to orange
                        onPrimary: Colors.white, // Set the button's text color to white
                      ),
                      child: Text("Delete"), // Replace with your button text
                    ),
                  ),
                ],
              )
            ],
          );
          },
        
      ),

      
    )
    );
    
  }
}



void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}