import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:hdbpricermobile/Models/hdb.dart';

Future<Hdb> priceHDB(String town, String flat_type, String storey_range, int floor_area_sqm, String lease_commence_date) async {
  final response = await http.post(
    Uri.parse('https://hdbpricer-be.herokuapp.com/hdbs'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'town': town,
      'flat_type': flat_type,
      'storey_range': storey_range,
      'floor_area_sqm': floor_area_sqm,
      'lease_commence_date': lease_commence_date,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    return Hdb.fromJson(jsonDecode(response.body)['hdbs'][0]);
  } else {
    // If the server did not return a 200 CREATED response,
    // then throw an exception.
    throw Exception('Failed to price HDB.');
  }
}

// Create a Form widget.
class PricingForm extends StatefulWidget {
  @override
  //PricingFormState createState() => PricingFormState();
  PricingFormState createState() {
    return PricingFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class PricingFormState extends State<PricingForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<PricingFormState>.
  final _formKey = GlobalKey<FormState>();
  final yearController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  Future<Hdb>? _futureHdb;

  final List<String> _towns = [
    'ANG MO KIO',
    'BEDOK',
    'BISHAN',
    'BUKIT BATOK',
    'BUKIT MERAH',
    'BUKIT PANJANG',
    'BUKIT TIMAH',
    'CENTRAL AREA',
    'CHOA CHU KANG',
    'CLEMENTI',
    'GEYLANG',
    'HOUGANG',
    'JURONG EAST',
    'JURONG WEST',
    'KALLANG/WHAMPOA',
    'MARINE PARADE',
    'PASIR RIS',
    'PUNGGOL',
    'QUEENSTOWN',
    'SEMBAWANG',
    'SENGKANG',
    'SERANGOON',
    'TAMPINES',
    'TOA PAYOH',
    'WOODLANDS',
    'YISHUN'
  ];
  final List<String> _flatTypes = [
    '1 ROOM',
    '2 ROOM',
    '3 ROOM',
    '4 ROOM',
    '5 ROOM',
    'EXECUTIVE',
    'MULTI-GENERATION'
  ];
  final List<String> _storeyRange = [
    '01 TO 03',
    '04 TO 06',
    '07 TO 09',
    '10 TO 12',
    '13 TO 15',
    '16 TO 18',
    '19 TO 21',
    '22 TO 24',
    '25 TO 27',
    '28 TO 30',
    '31 TO 33',
    '34 TO 36',
    '37 TO 39',
    '40 TO 42',
    '43 TO 45',
    '46 TO 48',
    '49 TO 51'
  ];

  String town = '';
  String flat_type = '';
  String storey_range = '';
  int floor_area_sqm = 0;
  String lease_commence_date = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    void handleReadOnlyInputClick(context) {
      showBottomSheet(
          context: context,
          builder: (BuildContext context) => Container(
                width: MediaQuery.of(context).size.width,
                child: YearPicker(
                  selectedDate: DateTime(1997),
                  firstDate: DateTime(1965),
                  lastDate: DateTime((DateTime.now().year - 5)),
                  onChanged: (val) {
                    setState(() {
                      lease_commence_date = val.year.toString();
                    });
                    yearController.text = val.year.toString();
                    Navigator.pop(context);
                  },
                ),
              ));
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*
              TextFormField(

                decoration: const InputDecoration(
                  icon: Icon(Icons.add_location_outlined),
                  hintText: 'Where is this?',
                  labelText: 'Town *',
                )         ,
                // The validator receives the text that the user has entered.
                
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),*/
          DropdownButtonFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.add_location_outlined),
            ),
            hint: Text(
              'Which Town?',
            ),
            onSaved: (value) {
              setState(() {
                town = value.toString();
              });
            },
            onChanged: (value) {
              setState(() {
                town = value.toString();
              });
            },
            validator: (value) {
              if (value == null) {
                return "Please select a Town";
              } else {
                return null;
              }
            },
            items: _towns.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                ),
              );
            }).toList(),
          ),

          DropdownButtonFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.other_houses_outlined),
            ),
            hint: Text(
              'Choose a flat type',
            ),
            onSaved: (value) {
              setState(() {
                flat_type = value.toString();
              });
            },
            onChanged: (value) {
              setState(() {
                flat_type = value.toString();
              });
            },
            validator: (value) {
              if (value == null) {
                return "Please select a flat type";
              } else {
                return null;
              }
            },
            items: _flatTypes.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                ),
              );
            }).toList(),
          ),

          DropdownButtonFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.stairs_outlined),
            ),
            hint: Text(
              'What is the storey range?',
            ),
            onSaved: (value) {
              setState(() {
                storey_range = value.toString();
              });
            },
            onChanged: (value) {
              setState(() {
                storey_range = value.toString();
              });
            },
            validator: (value) {
              if (value == null) {
                return "Please select a storey range";
              } else {
                return null;
              }
            },
            items: _storeyRange.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                ),
              );
            }).toList(),
          ),

          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.zoom_out_map),
              hintText: 'How many square metres?',
              labelText: 'Floor Area (sqm) *',
            ),
            // The validator receives the text that the user has entered.
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the floor area in square meters';
              } else if (int.parse(value) < 30 || int.parse(value) > 260) {
                return 'Please enter a realistic HDB floor area size';
              }
              return null;
            },
          ),

          TextFormField(
            controller: yearController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please choose the year of the lease commencement';
              }
            },
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'When was it built?',
              icon: Icon(Icons.calendar_today),
            ),
            onTap: () => handleReadOnlyInputClick(context),
          ),

          //   today_outlined
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(duration: const Duration(seconds: 1),content: Text('Pricing in progress')));

                  setState(() {
                    _futureHdb = priceHDB(town,flat_type,storey_range,floor_area_sqm,lease_commence_date);
                  });

                  

                  Navigator.pop(context, _futureHdb);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

}



