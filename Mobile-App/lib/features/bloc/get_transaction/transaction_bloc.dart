import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/core/network/remote_datasource.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/body/transaction_body.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final RemoteDataSource remotedatasource;

  TransactionBloc({required this.remotedatasource})
      : super(TransactionInitial()) {
    on<LoadTransactions>((event, emit) async {
      emit(TransactionLoading());
      try {
        final result = await remotedatasource
            .getTransaction(); // Implementasikan pemanggilan dengan parameter tanggal
        emit(TransactionLoaded(result.data));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });
  }
}
