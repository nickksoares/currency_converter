import 'api_fetch.dart';




///Função que recebe duas chaves `String key1` e `String key2` correspondentes as siglas das moedas e retorna
///a conversao pronta.
Future  makeSum(
    {required double value,
    required String key1,
    required String key2,
    required double currentValue}) async {

  try {
    Map apiResponse = await fetchExchangeRates();
    if (apiResponse.containsKey(key1) && apiResponse.containsKey(key2)) {
      print('Api fetch');

      final double rateFrom = apiResponse[key1]!;
      final double rateTo = apiResponse[key2]!;
      final double convertedAmount = (currentValue / rateFrom) * rateTo;
      return convertedAmount;
    }
  } catch (e) {
    throw Exception('Erro ao buscar a taxa de câmbio: $e');
  }
}
