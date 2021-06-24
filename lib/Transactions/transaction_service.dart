// ignore: file_names
import 'dart:convert';
import 'package:hdbpricermobile/Models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionService {

  static const String _url = 'https://data.gov.sg/api/action/datastore_search?resource_id=42ff9cfe-abe5-4b54-beda-c88f9bb438ee&sort=month%20desc&limit=2000';
  static Future<List<Transaction>> getTransactions({query}) async{

    

    String search_url = '';
    if(query !=null && query.isNotEmpty){
      search_url=_url + '&q=' + query;
    }else{
      search_url = _url;
    }

    http.Response response = await http.get(Uri.parse(search_url));

    String content = response.body;

    if (response.statusCode == 200) {
      List collection = json.decode(content)['result']['records'];
      //List<Transaction> transactions = collection.map((json) => Transaction.fromJson(json)).toList();
      Iterable<Transaction> transactions = collection.map((json) => Transaction.fromJson(json));

      /*if(query !=null && query.isNotEmpty){
        transactions = transactions.where((transaction) => transaction.town.toLowerCase().contains(query));
      }*/

      return transactions.toList();
    }else {
      return <Transaction>[];
      //throw Exception("Failed to retrieve latest transactions");
    }
  }
}