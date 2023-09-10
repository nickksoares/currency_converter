import 'package:currency_converter/components/api_fetch.dart';
import 'package:currency_converter/components/conversor.dart';
import 'package:flutter/material.dart';
import 'components/drop_down_list.dart';

void main(List<String> args) {
  runApp(const Converter());
}

class Converter extends StatelessWidget {
  const Converter({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      //Tema do App /////////////////////////////////////////////
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
            background: Colors.grey.shade200),
        textTheme: tema.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          titleSmall: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        appBarTheme: tema.appBarTheme.copyWith(
          titleTextStyle: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.amber,
          elevation: 5,
        ),
      ),
      //////////////////////////////////////////
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///O valor que sera convertido
  final TextEditingController _valueToConvert = TextEditingController();
  void _resetValues() {
    setState(() {
      _valueToConvert.clear();
      _convertedAmount = 0.0;
    });
  }

  double? _convertedAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Moedas'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              onPressed: () async {
                await fetchExchangeRates();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) {
                  return Colors.red;
                }),
                elevation: MaterialStateProperty.resolveWith((states) => 5),

              ),
              child: const Text('Atualizar  rates')),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropDownList(apiResponse: apiResponse)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _valueToConvert,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String dollarValue = _valueToConvert.text;
              double value = double.tryParse(dollarValue) ?? 0.00;
              double result = makeSum(
                  key1: selectedOption1Getter.toString(),
                  key2: selectedOption2Getter.toString(),
                  currentValue: value);
              setState(() {
                _convertedAmount = result;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
              elevation: MaterialStateProperty.resolveWith((states) => 5),
            ),
            child: const Text('Converter'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text('Valor Convertido: ${_convertedAmount?.toStringAsFixed(3)}'),
          ElevatedButton(
            onPressed: _resetValues,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                return Theme.of(context).colorScheme.secondary;
              }),
            ),
            child: const Text('Resetar Valores'),
          )
        ],
      ),
    );
  }
}
