import 'api_fetch.dart' as api_fetch;




///Função que recebe duas chaves `String key1` e `String key2` correspondentes as siglas das moedas e retorna
///a conversao pronta.
double makeSum(
    {
    required String? key1,
    required String? key2,
    required double currentValue}){
    Map apiResponse = api_fetch.apiResponse;
    if (apiResponse.containsKey(key1) && apiResponse.containsKey(key2)) {
      dynamic rateFrom = apiResponse[key1];
      dynamic rateTo = apiResponse[key2];
      if (rateFrom is int){
        rateFrom = double.tryParse(rateFrom.toString()) ?? 0.00;
      }
      if(rateTo is int){
        rateTo = double.tryParse(rateTo.toString()) ?? 0.00;
      } 



      //final double? rateFrom = double.tryParse((apiResponse[key1]));
      
      //final double? rateTo = double.tryParse((apiResponse[key2]));
      
      
      final double convertedAmount = (currentValue / rateFrom!) * rateTo!;
      
      return convertedAmount;
    }else{
      throw Exception('Erro');
    }
}
