import 'package:currency_converter/components/api_fetch.dart';
import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  final Map<String, dynamic> apiResponse;

  const DropDownList({required this.apiResponse});

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  Map<String, dynamic> data = {};
  String? selectedOption1;
  String? selectedOption2;

  @override
  void initState() {
    super.initState();
    fetchData();
    print('InitState');
  }

  fetchData() async {
    await fetchExchangeRates();
    print('Data Fetched');
    final fetchedData = apiResponse;
    setState(() {
      data = fetchedData;
      selectedOption1 = data.keys.isNotEmpty ? data.keys.first : null;
      selectedOption2 = data.keys.isNotEmpty ? data.keys.first : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedOption1,
          items: data.keys.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedOption1 = newValue;
            });
          },
        ),
        DropdownButtonFormField(
            value: selectedOption2,
            items: data.keys.map((String option) {
              return DropdownMenuItem<String>(
                  value: option, child: Text(option));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedOption2 = newValue;
              });
            }),
        const SizedBox(height: 20),
        Text('Moeda 1: ${selectedOption1 ?? "None"}'),
        Text('Valor atual (1USD): ${data[selectedOption1 ?? ""] ?? "None"}'),
        const SizedBox(height: 10,),
        Text('Moeda 2: ${selectedOption2 ?? "None"}'),
        Text('Valor atual (1USD): ${data[selectedOption2 ?? ""] ?? "None"}'),
      ],
    );
  }
}
