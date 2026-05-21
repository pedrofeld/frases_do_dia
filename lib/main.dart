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

  var _titulo = "Frases do Dia";
  var _frase = "";
  var _autor = "";

  Future<void> gerarFrase() async {
    try {
      final url = Uri.parse(
        "https://zenquotes.io/api/random",
      );
      final resposta = await http.get(url);
      if (resposta.statusCode == 200) {
        final dados = jsonDecode(resposta.body);
        setState(() {
          _frase = dados[0]['q'];
          _autor = dados[0]['a'];
        });
      } else {
        setState(() {
          _frase = "Erro ao carregar frase.";
          _autor = "";
        });
      }
    } catch (e) {
      setState(() {
        _frase = "Sem conexão com a internet.";
        _autor = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            _titulo,
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
              "images/logo.png",
              fit: BoxFit.contain,
            ),
            SizedBox(height: 50),
            Container(
              height: 120,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _frase.isEmpty
                        ? "Clique no botão abaixo para gerar uma frase"
                        : _frase,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _frase.isEmpty ? 18 : 24,

                      color: _frase.isEmpty
                          ? Colors.grey
                          : Colors.black,

                      fontStyle: _frase.isEmpty
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
              onPressed: gerarFrase,
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                )
              ),
              child: Text(
                "Nova Frase",
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