import 'dart:async';

import 'package:hdbpricermobile/Models/transaction.dart';
import 'package:hdbpricermobile/Transactions/transaction_service.dart';

class TransactionBloc {


  Stream<List<Transaction>> get transactionsTable =>
    Stream.fromFuture(TransactionService.getTransactions());
  
  Stream<List<Transaction>> filteredTransactionsTable({query}) =>
    Stream.fromFuture(TransactionService.getTransactions(query: query));
  


}