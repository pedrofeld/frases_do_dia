import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeStateful(),
    ),
  );
}

class HomeStateful extends StatefulWidget {
  const HomeStateful({super.key});

  @override
  State<HomeStateful> createState() => _HomeStatefulState();
}

class _HomeStatefulState extends State<HomeStateful> {

  var _title = "Phrases of the day";
  var _phrase = "";
  var _autor = "";
  bool _loading = false;

  Future<void> generatePhrase() async {
    setState(() {
      _loading = true;
    });
    try {
      final url = Uri.parse(
        "https://zenquotes.io/api/random",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _phrase = data[0]['q'];
          _autor = data[0]['a'];
          _loading = false;
        });
      } else {
        setState(() {
          _phrase = "Error loading phrase.";
          _autor = "";
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _phrase = "Without connection with internet.";
        _autor = "";
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            _title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/logo-en.png",
              fit: BoxFit.contain,
            ),
            SizedBox(height: 50),
            Container(
              height: 120,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _loading
                    ? CircularProgressIndicator(
                        color: Colors.green,
                      )
                    : Text(
                      _phrase.isEmpty
                          ? "Click on the button below to generate a phrase"
                          : _phrase,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _phrase.isEmpty ? 18 : 24,

                        color: _phrase.isEmpty
                            ? Colors.grey
                            : Colors.black,

                        fontStyle: _phrase.isEmpty
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              _autor,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: generatePhrase,
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                )
              ),
              child: Text(
                "New phrase",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}