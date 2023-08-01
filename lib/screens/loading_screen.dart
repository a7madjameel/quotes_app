import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<dynamic> getQuotes() async {
    http.Response response = await http.get(
      Uri.parse('https://api.quotable.io/random'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return Future.error(false);
  }
}
