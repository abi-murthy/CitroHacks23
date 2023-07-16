import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() => runApp(const MyApp());

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

Future<void> makePythonCall() async {
  var url = Uri.parse("http://127.0.0.1:5000/predict"); // Replace with your API URL
  try { 
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'}, // Set the headers if required
      body: '{"weight": "767", "cal_in": "20", "cal_out": "30"}', // Replace with your request body
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



class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  void dispose() {
    weightController.dispose();
    caloriesInController.dispose();
    caloriesOutController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
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
                  makePythonCall();
                  // makeApiCall();
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}