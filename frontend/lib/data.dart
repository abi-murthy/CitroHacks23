import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'form.dart';

class Data extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataTablePage(),
    );
  }
}

class DataTablePage extends StatefulWidget {
  @override
  _DataTablePageState createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  late List<Map<String, dynamic>> _dataList;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDataFromApi();
  }

  Future<void> _loadDataFromApi() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Replace 'api_endpoint' with the actual API endpoint URL
      final response = await http.get(Uri.parse('https://capable-sundae-9a3979.netlify.app/.netlify/functions/server/userinfo/'));
      print(response);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _dataList = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      } 
      else {
        // Handle error response
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Table'),
         
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                DataTable(
                  columns: _buildTableColumns(),
                  rows: _buildTableRows(),
                ),
                SizedBox(height: 16.0), // Add some spacing between the DataTable and the button
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntryForm()),
                  );
                },
                child: const Text('Go back to entry form'),
              ),
            ],
            ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    return _dataList.isNotEmpty
        ? _dataList.first.keys
            .map((String key) => DataColumn(label: Text(key)))
            .toList()
        : [];
  }

  List<DataRow> _buildTableRows() {
    return _dataList
        .map(
          (Map<String, dynamic> data) => DataRow(
            cells: data.keys
                .map(
                  (String key) => DataCell(Text('${data[key]}')),
                )
                .toList(),
          ),
        )
        .toList();
  }
}
