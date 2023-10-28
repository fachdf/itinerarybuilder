import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itinerarybuilder/service/firestore.dart';


class AddPlaceScreen extends StatefulWidget {
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController googleMapUrlController = TextEditingController();  
  TextEditingController photoUrlController = TextEditingController();
  List<String> photoUrls = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Place",
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5900)
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: googleMapUrlController,
                decoration: InputDecoration(labelText: "Google Map URL"),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: photoUrlController,
                      decoration: InputDecoration(labelText: "Photo Url"),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        final photoUrl = photoUrlController.text;
                        if (photoUrl.isNotEmpty) {
                          photoUrls.add(photoUrl);
                          photoUrlController.clear();
                        }
                      });
                    },
                  ),
                ],
              ),
              Text("Photos:"),
              SizedBox(height: 16.0),
              Column(
                children: photoUrls.map((url) => Text(url)).toList(),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0), // Adjust the left padding as needed
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Adjust the value for the desired roundness
                        ),
                        primary: Colors.orange, // Set the button's background color to orange
                        onPrimary: Colors.white, // Set the button's text color to white
                      ),
                      onPressed: () {
                        // Save the place data here
                        final name = nameController.text;
                        final address = addressController.text;
                        final description = descriptionController.text;
                        final photoUrl = photoUrlController.text;
                        final googleMapUrl = googleMapUrlController.text;
                        if (photoUrl.isNotEmpty) {
                          photoUrls.add(photoUrl);
                          photoUrlController.clear();
                        }
                        // Do something with the data (e.g., store it in a database)
                        //addPlace(name, address, description, photoUrls);
                        FirestoreService().addPlace(name, address, description, googleMapUrl, photoUrls);
                        // Then, navigate back to the previous screen
                        Navigator.pop(context);
                      },
                      child: Text("Submit"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}