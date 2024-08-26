part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class LoadTransactions extends TransactionEvent {}
