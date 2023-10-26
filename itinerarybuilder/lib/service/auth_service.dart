// import 'dart:convert';
// import 'dart:async'; // Import dart:async for StreamController
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:itinerarybuilder/main.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';

// class AuthService {
//   final String baseUrl; // Your API base URL
//   final String loginEndpoint; // The endpoint for user login
//   final String registrationEndpoint; // The endpoint for user registration
//   final BuildContext context;
//   AuthService({
//     required this.baseUrl,
//     required this.loginEndpoint,
//     required this.registrationEndpoint,
//     required this.context,
//   });

//   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   final BehaviorSubject<String?> _authStreamController = BehaviorSubject<String?>.seeded(null);
//   // Create a StreamController to manage the user's authentication state
//   // final StreamController<String?> _authStreamController = StreamController<String?>.broadcast();

//   // Create a getter for the userStream to access the stream
//   Stream<String?> get userStream => _authStreamController.stream;

//   void updateUserData(String? jwt) {
//     final userData = Provider.of<UserData>(context, listen: false);
//     userData.updateJwt(jwt);
//   }
//   Future<void> login(String email, String password, BuildContext context) async {
//     final Map<String, dynamic> data = {
//       'email': email,
//       'password': password,
//     };

//     final String jsonData = json.encode(data);

//     final response = await http.post(
//       Uri.parse('$baseUrl$loginEndpoint'),
//       headers: {
//         'Content-Type': 'application/json', // Set the request content type to JSON
//       },
//       body: jsonData,
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final jwt = responseData['message'];
//       final userData = Provider.of<UserData>(context, listen: false);
//       await _storeJwt(jwt);
//       _authStreamController.add(jwt); // Notify stream listeners
//     } else {
//       throw Exception(response.statusCode);
//     }
//   }

//   Future<void> register(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl$registrationEndpoint'),
//       body: {
//         'email': email,
//         'password': password,
//       },
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Failed to register');
//     }
//   }

//   Future<void> logout() async {
//     final prefs = await _prefs;
//     await prefs.remove('jwt'); // Remove the stored JWT on logout
//     _authStreamController.add(null); // Notify stream listeners
//   }

//   Future<void> _storeJwt(String jwt) async {
//     final prefs = await _prefs;
//     await prefs.setString('jwt', jwt); // Store the JWT securely
//   }

//   Future<String?> getJwt() async {
//     final prefs = await _prefs;
//     return prefs.getString('jwt'); // Retrieve the stored JWT
//   }
// }
