import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itinerarybuilder/service/firestore.dart';


class AddItineraryScreen extends StatefulWidget {
  @override
  _AddItineraryScreenState createState() => _AddItineraryScreenState();
}

class _AddItineraryScreenState extends State<AddItineraryScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController photoUrlController = TextEditingController();
  List<String> photoUrls = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context,true),
        ),
        title: Text("Add Itinerary",
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
                        // Do something with the data (e.g., store it in a database)
                        FirestoreService().addItinerary(name);
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

// Future<void> addItinerary(String name) async {
//   final url = Uri.parse('http://10.0.2.2:7161/api/Itinerary'); // Replace with your API endpoint

//   final Map<String, dynamic> data = {
//     "name": name,
//   };

//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode(data),
//   );

//   if (response.statusCode == 201) {
//     // The place was successfully created
//     // You can handle the success as needed
//   } else {
//     // Handle errors or show an error message
//     throw Exception('Failed to add place: ${response.statusCode}');
//   }
// }


