import 'package:flutter/material.dart';
import './login.dart';
import './form.dart';
import './register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/form': (context) => Form(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Login(), // Use your component
      ),
    );
  }
}

class Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const EntryForm(), // Use your component
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Register(), // Use your component
      ),
    );
  }
}



// class RegisterPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Register Page'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text('Go to Entry'),
//           onPressed: () {
//             Navigator.pushNamed(context, '/entry');
//           },
//         ),
//       ),
//     );
//   }
// }

// class EntryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Entry Page'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text('Go to Information'),
//           onPressed: () {
//             Navigator.pushNamed(context, '/information');
//           },
//         ),
//       ),
//     );
//   }
// }

// class InformationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Information Page'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text('Go to Login'),
//           onPressed: () {
//             Navigator.pushNamed(context, '/');
//           },
//         ),
//       ),
//     );
//   }
// }
