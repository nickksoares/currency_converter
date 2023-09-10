import 'package:currency_converter/components/api_fetch.dart';
import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  final Map<String, dynamic> apiResponse;

  const DropDownList({super.key, required this.apiResponse});

  @override
  DropDownListState createState() => DropDownListState();
}

String? selectedOption1Getter;
String? selectedOption2Getter;

class DropDownListState extends State<DropDownList> {
  Map<String, dynamic> data = {};
  String? selectedOption1;
  String? selectedOption2;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await fetchExchangeRates();
    final fetchedData = apiResponse;
    setState(() {
      data = fetchedData;
      selectedOption1 = data.keys.isNotEmpty ? data.keys.first : null;
      selectedOption2 = data.keys.isNotEmpty ? data.keys.first : null;
      selectedOption1Getter = selectedOption1;
      selectedOption2Getter = selectedOption2;
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
              child: Text(
                'Converter de $option',
                style: Theme.of(context).textTheme.titleMedium,
                selectionColor: Colors.black,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            selectedOption1Getter = newValue;

            setState(() {
              selectedOption1 = newValue;
            });
          },
        ),
        DropdownButtonFormField(
            value: selectedOption2,
            items: data.keys.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  'Converter para $option',
                  style: Theme.of(context).textTheme.titleMedium,
                  selectionColor: Colors.black,
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              selectedOption2Getter = newValue;

              setState(() {
                selectedOption2 = newValue;
              });
            }),
        const SizedBox(
          height: 20,
          width: 100,
        ),
        Text('Moeda 1: ${selectedOption1 ?? "None"}'),
        Text('Valor atual (1USD): ${data[selectedOption1 ?? ""] ?? "None"}'),
        const SizedBox(
          height: 10,
          width: 100,
        ),
        Text('Moeda 2: ${selectedOption2 ?? "None"}'),
        Text('Valor atual (1USD): ${data[selectedOption2 ?? ""] ?? "None"}'),
      ],
    );
  }
}
