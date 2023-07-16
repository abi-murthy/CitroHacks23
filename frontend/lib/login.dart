import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'form.dart';
import 'register.dart';


Future<void> login(email, password) async {
  print("here");
  
  var url = Uri.parse("https://capable-sundae-9a3979.netlify.app/.netlify/functions/server/users/login"); // Replace with your API URL
      Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
      };
      String jsonBody = jsonEncode(requestBody);
      print(jsonBody);
  try { 
    
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'}, // Set the headers if required
      body: jsonBody, // Replace with your request body
    );

    if (response.statusCode == 200) {
      // API call was successful
      final responseBody = json.decode(response.body);
      print("it was successful");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', responseBody['session']['access_token']);
      
    } else {
      // API call failed
      print('API call failed with status code: ${response.statusCode}');
    }

    
  }
  catch (e){
    print(e);
  }

}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  String email = ''; // Variable to hold the email value
  String password = ''; // Variable to hold the password value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page",style: TextStyle(color: Colors.white, fontSize: 30),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 55, bottom: 15),
              child: TextFormField(
                 onChanged: (value) {
                  setState(() {
                    email = value; // Update the email value
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                 onChanged: (value) {
                  setState(() {
                    password = value; // Update the email value
                  });
                },

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Container(
                height: 50,
                width: 175,
                decoration: BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context, MaterialPageRoute(builder: (_) => ()));
                    login(email, password);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EntryForm()),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    
                  ),
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Container(
                height: 50,
                width: 175,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context, MaterialPageRoute(builder: (_) => ()));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    
                  ),
                ),
              )
            ),
            SizedBox(
              height: 13330,
            ),
          ],
        ),
      ),
    );
  }
}