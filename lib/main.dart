import 'package:currency_converter/components/api_fetch.dart';
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
  ///O valor que sera convertido
  final TextEditingController _valueToConvert = TextEditingController();
  
  double _convertedAmount = 0.0;
  double _currentRate = 0.0;


  

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
          ElevatedButton(onPressed:() async { await fetchExchangeRates();} , child: const Text('Buscar  conversoes')),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropDownList(apiResponse: apiResponse)
          ),
          
          ElevatedButton(
            onPressed: () async{
              String dollarValue = _valueToConvert.text;
              double value = double.tryParse(dollarValue) ?? 0.00;
              try{
               fetchExchangeRates();
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
