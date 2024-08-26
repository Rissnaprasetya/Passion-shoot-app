/* 
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/core/network/remote_datasource.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/body/transaction_body.dart';

part 'post_transaction_event.dart';
part 'post_transaction_state.dart';

class PostTransactionBloc extends Bloc<PostTransactionEvent, PostTransactionState> {
  final RemoteDataSource remoteDataSource;
  PostTransactionBloc(this.remoteDataSource) : super(PostTransactionInitial()) {
    on<PostDataTransaction>((event, emit) async {
      emit(PostTransactionLoading());
      try {
        final response = await remoteDataSource.postTransaction(event.body);
        if (response.sta) {
          
        }
        // log('post transaction : ${}');
      } catch (e) {
       log(e.toString()); 
      }
    });
  }
}
 */