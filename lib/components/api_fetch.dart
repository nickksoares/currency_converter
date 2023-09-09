
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


Map<String,dynamic> apiResponse = {'Atualize a lista': 0.00};



void apiResponseSetter(Map<String, dynamic> rates) {
  apiResponse = rates;
}



Future<Map<String, double>> fetchExchangeRates() async {
  const String apiKey = '8e510b32fd18462480e2889309a22836';
  String apiUrl =
      'https://openexchangerates.org/api/latest.json?app_id=$apiKey';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = data['rates'] as Map<String, dynamic>;
      if (rates.isNotEmpty) {
        apiResponseSetter(rates);
        //print(rates);
        return rates.cast<String, double>();
      } else {
        throw Exception('Taxas de câmbio não encontradas na resposta da API.');
      }
    } else {
      throw Exception(
          'Erro ao buscar as taxas de câmbio: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Erro ao buscar as taxas de câmbio: $e');
  }
}



