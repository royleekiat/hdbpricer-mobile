import 'package:flutter/material.dart';
import 'package:hdbpricermobile/Models/transaction.dart';
import 'package:hdbpricermobile/utils.dart';


class TransactionSearchDelegate extends SearchDelegate {
  final bloc;
  TransactionSearchDelegate({this.bloc});


  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return[
      IconButton(
        onPressed: (){query = '';}, 
        icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){
      close(context,null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (query.length < 3){
      return Center(child: Text("Your query is $query, type more than 3 characters to search"),);
    }else{
      return StreamBuilder(
        stream: bloc.filteredTransactionsTable(query: query),
        builder: (BuildContext context, AsyncSnapshot<List<Transaction>> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:

              if(snapshot.data!.isNotEmpty){
            
                List<Transaction>? transactions = snapshot.data;
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index){
                    Transaction _transaction = transactions![index];
                      return Card(
                        color: Colors.black26,
                        elevation: 5,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                        child: ListTile(
                          title: Text(_transaction.town , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          subtitle: Text('Flat type: ' + _transaction.flat_type + ' | ' + _transaction.flat_model + '\nSold: ' + _transaction.month + '\nFloor area: ' + _transaction.floor_area_sqm.toString() + 'sqm \n' + 'Address: ' + _transaction.block + ', ' + _transaction.street_name + '\n' + _transaction.storey_range + ' Floor \nLease commence year: ' + _transaction.lease_commence_date , style: TextStyle(color: Colors.white70),   ),
                          leading: Icon(Icons.house,color: Colors.white70,),
                          trailing: Text('S\$ ' + (priceformatter.format(_transaction.resale_price)).toString(),style: (TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),),
                      ));
                }, 
                itemCount: transactions?.length ?? 0,
            );
              }else{
                return Center(child: Text("There are no results for your query: $query"),);
              }
            
              
          }
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }

}