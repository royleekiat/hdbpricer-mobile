
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hdbpricermobile/Models/transaction.dart';
import 'package:hdbpricermobile/Transactions/transaction_bloc.dart';
import 'package:hdbpricermobile/Transactions/transaction_search_delegate.dart';
import 'package:hdbpricermobile/Transactions/transaction_service.dart';
import 'package:hdbpricermobile/utils.dart';

class TransactionsTableRoute extends StatelessWidget {
  TransactionBloc bloc = TransactionBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              showSearch(context: context, delegate: TransactionSearchDelegate(bloc: bloc));
            },
            icon: Icon(Icons.search))
        ],  
      ),
      
      body: StreamBuilder(
        stream: bloc.transactionsTable,
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
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                        child: ListTile(
                          title: Text(_transaction.town , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          subtitle: Text('Flat type: ' + _transaction.flat_type + ' | ' + _transaction.flat_model + '\nSold: ' + _transaction.month + '\nFloor area: ' + _transaction.floor_area_sqm.toString() + 'sqm \n' + 'Address: ' + _transaction.block + ', ' + _transaction.street_name + '\n' + _transaction.storey_range + ' Floor \nLease commence year: ' + _transaction.lease_commence_date , style: TextStyle(color: Colors.white70),   ),
                          leading: Icon(Icons.house,color: Colors.white70,),
                          trailing: Text('S\$ ' + (priceformatter.format(_transaction.resale_price)).toString(),style: (TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),),
                      ));
                  }, 
                  //separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemCount: transactions?.length ?? 0,
                );
              }else{
                return Center(child: Text('The transactions service could not receive any data. Please try again later.'),);
              }
            
              
          }
        },
      )
      //const Center(child: TransactionsTable(),)
      
    );
  }
}

