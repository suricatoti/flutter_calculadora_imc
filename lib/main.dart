import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState() {
      _info = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    }
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    if (imc < 24.9) {
      _info = "Abaixo do peso: (${imc.toStringAsPrecision(3)})";
    } else if (imc < 29.9) {
      _info = "Levemente acima do peso: (${imc.toStringAsPrecision(3)})";
    } else if (imc < 34.9) {
      _info = "Obesidade grau 1: (${imc.toStringAsPrecision(3)})";
    } else if (imc < 39.9) {
      _info = "Obesidade grau 2: (${imc.toStringAsPrecision(3)})";
    } else {
      _info = "Obesidade grau 3: (${imc.toStringAsPrecision(3)})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Peso (kg)",
                            labelStyle: TextStyle(color: Colors.green)),
                        textAlign: TextAlign.center,
                        controller: weightController,
                        style: TextStyle(color: Colors.green, fontSize: 25.0),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira seu peso!";
                          }
                          return null;
                        }),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Altura (cm)",
                            labelStyle: TextStyle(color: Colors.green)),
                        textAlign: TextAlign.center,
                        controller: heightController,
                        style: TextStyle(color: Colors.green, fontSize: 25.0),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira sua altura!";
                          }
                          return null;
                        }),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                            height: 50.0,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _calculate();
                                  }
                                },
                                child: Text("Calcular",
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green)))),
                    Text(_info,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25.0))
                  ],
                ))));
  }
}
