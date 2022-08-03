import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados!';

  void _resetFields(){
    weightController.text == "";
    heightController.text == "";
    setState(() {
      _infoText = "Informe seus dados!";
      heightController.clear();
      weightController.clear();
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    setState((){
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if(imc < 18.6){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          // ICONE DE REFRESH DA APPBAR
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.calculate, size: 120.0, color: Colors.green,),

              // CAMPO PARA ADICIONAR O PESO
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0,),
                validator: (value) {
                  if(value != null && value.isEmpty){
                    return 'Informe seu Peso!';
                  }
                },
              ),

              // CAMPO PARA ADICIONAR A ALTURA
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0,),
                validator: (value) {
                  if(value != null && value.isEmpty){
                    return 'Informe sua Altura!';
                  }
                },
              ),

              // BOTÃO PARA CALCULAR
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0,),
                child: Container(
                  height: 50.0,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                    color: Colors.green,
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ),

              // MENSAGEM COM RETORNO DO CALCULO
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}