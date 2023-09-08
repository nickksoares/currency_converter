
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



// Função que simula chamadas assíncronas a diferentes APIs para obter informações sobre produtos
/*
Future fetchDollarInfo() async {
  const String apiKey = '8e510b32fd18462480e2889309a22836';
  String apiUrl =
      'https://openexchangerates.org/api/latest.json?app_id=$apiKey';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final rates = data['rates'] as Map<String, dynamic>;

    if (rates.containsKey('BRL')){
      final double dollarToReal = rates['BRL'] as double;
      return dollarToReal;
    }
  }else{
    throw Exception('Taxa de câmbio para o Dollar não encontrada.');
  }
  return 0.0;
}
*/

Future<double> fetchDollarInfo() async {
  const String apiKey = 'MY_API_KEY';
  String apiUrl =
      'https://openexchangerates.org/api/latest.json?app_id=$apiKey';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = data['rates'] as Map<String, dynamic>;

      if (rates.containsKey('BRL')) {
        final double dollarToReal = rates['BRL'] as double;
        return dollarToReal;
      } else {
        throw Exception(
            'Taxa de câmbio para o Real (BRL) não encontrada na resposta da API.');
      }
    } else {
      throw Exception(
          'Erro ao buscar a taxa de câmbio: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Erro ao buscar a taxa de câmbio: $e');
  }
}
