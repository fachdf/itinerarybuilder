// import 'package:flutter/material.dart';
// import '../service/auth_service.dart'; // Import your AuthService

// class LoginPage extends StatelessWidget {
//   final AuthService authService;
//  // final AsyncSnapshot<String?> snapshot; // Add this line

//   LoginPage({required this.authService});
//   //LoginPage({required this.authService});

//   @override
//   Widget build(BuildContext context) {
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //Text('Snapshot Data: ${snapshot.data}'),
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true, // Hide the password input
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 final email = emailController.text;
//                 final password = passwordController.text;
//                 try {
//                   await authService.login(email, password);
//                   // Redirect to the home screen on successful login
                  
//                 } catch (e) {
//                   // Handle login error, e.g., show an error message
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(e.toString()),
//                     ),
//                   );
//                 }
//               },
//               child: Text('Sign In'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
