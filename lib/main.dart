import 'package:flutter/material.dart';
import 'components/converter.dart';

void main(List<String> args) {
  runApp(const Converter());
}

class Converter extends StatelessWidget {
  const Converter({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      //Tema do App
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
                color: Colors.purple),
            titleSmall: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
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
  final TextEditingController _dollarController = TextEditingController();
  double _convertedAmount = 0.0;
  double _currentRate = 0.0;
  

  Future makeSum(double value) async{
    print('Chamando makeSum com valor $value');
      try {
        dynamic apiResponse = await fetchDollarInfo();
        if (apiResponse is double) {
          _currentRate = apiResponse;
          print(_currentRate);
          print(_currentRate*value);
          return _currentRate*value;
        } else {
          throw Exception('Um erro ocorreu');
        }
      } catch (e) {
        throw Exception('Erro ao buscar a taxa de câmbio: $e');
      }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Moedas'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _dollarController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor em Dolar',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              String dollarValue = _dollarController.text;
              double value = double.tryParse(dollarValue) ?? 0.00;
              try{
                double result = await makeSum(value);
                setState(() {
                  _convertedAmount = result;
                });
              }catch (error){
                throw Exception("Erro encontrado: $error");
              }
            },
            child: const Text('Converter'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text('Valor em Real: $_convertedAmount')
        ],
      ),
    );
  }
}
