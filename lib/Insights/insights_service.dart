import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hdbpricermobile/Models/median_price_insights.dart';

Future<MedianPriceInsights> getMedianPriceInsights(String town) async {
  final response = await http.post(
    Uri.parse('https://hdbpricer-be.herokuapp.com/chart'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'town': town,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    //print(response.body);
    return MedianPriceInsights.fromJson(jsonDecode(response.body)['chart_data']);
  } else {
    // If the server did not return a 200 CREATED response,
    // then throw an exception.
    throw Exception('Failed to get insights.');
  }
}

/*
void main() async{
  MedianPriceInsights result = await getMedianPriceInsights('SINGAPORE');
  print(result.five_room);
  print(result.labels);

}
*/