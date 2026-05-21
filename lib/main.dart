import 'package:flutter/material.dart';
import 'dart:math';

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

  List<String> frases = [
    "Nós aceitamos o amor que acreditamos merecer.",
    "Só quem se arrisca merece viver o extraordinário.",
    "Para quem tem pensamento forte, impossível é só questão de opinião.",
    "É impossível conhecer o amor sem perder a razão.",
    "Cada escolha, uma renúncia. Cada sonho, uma batalha.",
    "Dias de luta, dias de glória.",
    "O tempo não para pra ninguém, então faz valer.",
    "Liberdade é pouco. O que eu desejo ainda não tem nome.",
    "Seja forte o suficiente para deixar ir, e sábio o suficiente para esperar o que merece.",
    "A vida acontece enquanto você tenta entender ela.",
    "Nem todo mundo vai entender sua caminhada, porque nem todos viveram sua história.",
    "A coragem não é ausência do medo, é agir apesar dele.",
    "Viver é raro. A maioria das pessoas apenas existe.",
  ];

  void gerarFrase() {
    int i = 0;
    i = Random().nextInt(13);
    setState(() {
      _frase = frases[i];
    });
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
              child: Text(
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