import 'package:flutter/material.dart';
import 'package:frontend/data.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'data.dart';


// Future<void> makeApiCall() async {
  
//   var url = Uri.parse("https://capable-sundae-9a3979.netlify.app/.netlify/functions/server/userinfo/add"); // Replace with your API URL
//   try { 
//     var response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'}, // Set the headers if required
//       body: '{"weight": $weightController, "calories_in": $caloriesInController, "calories_out": $caloriesOutController}', // Replace with your request body
//     );
//     if (response.statusCode == 200) {
//       // API call was successful
//       var responseBody = response.body;
//       // Process the response data here
//       print(responseBody);
//     } else {
//       // API call failed
//       print('API call failed with status code: ${response.statusCode}');
//     }

    
//   }
//   catch (e){
//     print(e);
  
//   }

// }

Future<void> makePythonCall(String weight, String caloriesIn, String caloriesOut, String gender, String alcoholUsage, String age, String chronicDisease, String ocupationalHazard) async {
  var url = Uri.parse("http://127.0.0.1:5000/predict"); // Replace with your API URL
  Map<String, dynamic> requestBody = {
    'weight': weight,
    'cal_in': caloriesIn,
    'cal_out': caloriesOut,
    'gender': gender, 
    'alcohol_usage': alcoholUsage,
    'age': age,
    'chronic_disease': chronicDisease,
    'ocupational_hazard': ocupationalHazard
  };
  String jsonBody = jsonEncode(requestBody);

  try { 
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'}, // Set the headers if required
      body: jsonBody, // Replace with your request body
    );
    if (response.statusCode == 200) {
      // API call was successful
      var responseBody = response.body;
      // Process the response data here
      print(responseBody);
    } else {
      // API call failed
      print('API call failed with status code: ${response.statusCode}');
    }
  }
  catch (e){
    print(e);
  
  }
}


void makeHttpRequest() async {
  var url = Uri.parse('http://127.0.0.1:5000/predict');

  var response = await http.get(url);
  

  if (response.statusCode == 200) {
    print('Request successful!');
    print('Response body: ${response.body}');
  } else {
    print('Request failed with status code: ${response.statusCode}');
  }
}



class EntryForm extends StatelessWidget {
  const EntryForm({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Add Entry';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  final caloriesInController = TextEditingController();
  final caloriesOutController = TextEditingController();

  String _weight = '';
  String _cal_in = '';
  String _cal_out = '';
  String _gender = '';
  String _alcohol_usage = '';
  String _age = '';
  String _chronic_disease = '';
  String _ocupational_hazard = '';

  void dispose() {
    weightController.dispose();
    caloriesInController.dispose();
    caloriesOutController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
            padding: EdgeInsets.all(30.0),
            child : TextFormField(
                onChanged: (value) {
                  setState(() {
                    _weight = value;
                  });
                },
                controller: weightController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Weight'
                ),
              )
            ),
            Padding(
            padding: EdgeInsets.all(30.0),
            child : TextFormField(
            onChanged: (value) {
                  setState(() {
                    _cal_in = value;
                  });
            },
            controller: caloriesInController,

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Calories In'
                ),
              )
            ),
            Padding(
            padding: EdgeInsets.all(30.0),
            child : TextFormField(
            onChanged: (value) {
                  setState(() {
                    _cal_out = value;
                  });
            },
            controller: caloriesOutController,

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Calories Out'
                ),
              )
            ),
            
            Padding(
            padding: EdgeInsets.all(30.0),
            child : TextFormField(
                onChanged: (value) {
                  setState(() {
                    _alcohol_usage = value;
                  });
                },
                controller: weightController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Alcohol Usage (scale of 1-9)'
                ),
              )
            ),
            
            Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    makePythonCall(_weight, _cal_in, _cal_out, _gender, _alcohol_usage, _age, _chronic_disease, _ocupational_hazard);
                    // makeApiCall();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Data()),
                    );
                },
                child: const Text('Submitted Data Table'),
              ),
            ),
          ],
        ),
      )
    );
  }
}