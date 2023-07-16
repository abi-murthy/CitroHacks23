import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login.dart';



Future<void> register(email, password, age, sex, occupational_hazard) async {
  print("here");
  
  var url = Uri.parse("https://capable-sundae-9a3979.netlify.app/.netlify/functions/server/users/register"); // Replace with your API URL
      Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
        'age': age,
        'sex': sex,
        'occupational_hazards': occupational_hazard,
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

      print(responseBody);

      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('accessToken', responseBody['session']['accessToken']);
      
    } else {
      // API call failed
      print('API call failed with status code: ${response.statusCode}');
    }

  }
  catch (e){
    print(e);
  }

}

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterDemo(),
    );
  }
}

class RegisterDemo extends StatefulWidget {
  @override
  _RegisterDemoState createState() => _RegisterDemoState();
}

class _RegisterDemoState extends State<RegisterDemo> {
  String email = ''; // Variable to hold the email value
  String password = ''; // Variable to hold the password value
  String sex = '';
  String age = '';
  String occupational_hazard = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Registration Page",style: TextStyle(color: Colors.white, fontSize: 30),),
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
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                 onChanged: (value) {
                  setState(() {
                    age = value; // Update the email value
                  });
                },

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                    hintText: 'Enter your age'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                 onChanged: (value) {
                  setState(() {
                    sex = value; // Update the email value
                  });
                },

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Sex',
                    hintText: 'Enter your sex (1 = Male, 2 = Female)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                 onChanged: (value) {
                  setState(() {
                    occupational_hazard = value; // Update the email value
                  });
                },

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Occupational Hazard',
                    hintText: 'Enter your Occupational (1 - 9)'),
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
                    register(email, password, age, sex, occupational_hazard);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
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
            )
          ],
        ),
      ),
    );
  }
}