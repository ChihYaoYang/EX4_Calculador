import "package:flutter/material.dart";
import 'package:validators/validators.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _infoText = "Resultado: 0";
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();

  void calcular(String operacao) {
    if (isNumeric(num1Controller.text) && isNumeric(num2Controller.text)) {
      setState(() {
        double n1 = double.parse(num1Controller.text);
        double n2 = double.parse(num2Controller.text);
        double result = 0;
        if (operacao == "+") {
          result = n1 + n2;
        } else if (operacao == "-") {
          result = n1 - n2;
        } else if (operacao == "*") {
          result = n1 * n2;
        } else if (operacao == "/") {
          result = n1 / n2;
        }
        _infoText = "Resultado: " + result.toStringAsPrecision(4);
      });
    } else {
      _showDialog('Aviso', 'Preencha somente números !');
    }
  }

  void _resetFields() {
    num1Controller.text = "";
    num2Controller.text = "";
    setState(() {
      _infoText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Número 1",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.green),
                controller: num1Controller,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Preencher o campo número 1 !";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Número 2",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.green),
                controller: num2Controller,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Preencher o campo número 2 !";
                  }
                },
              ),
              new ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          calcular("+");
                          FocusScope.of(context).requestFocus(new FocusNode());
                        }
                      },
                      child: Text(
                        "+",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          calcular("-");
                          FocusScope.of(context).requestFocus(new FocusNode());
                        }
                      },
                      child: Text("-", style: TextStyle(color: Colors.white)),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          calcular("*");
                          FocusScope.of(context).requestFocus(new FocusNode());
                        }
                      },
                      child: Text("*", style: TextStyle(color: Colors.white)),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          calcular("/");
                          FocusScope.of(context).requestFocus(new FocusNode());
                        }
                      },
                      child: Text("/", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Text(
                _infoText,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}