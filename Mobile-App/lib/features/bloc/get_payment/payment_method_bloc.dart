import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/core/network/remote_datasource.dart';
import 'package:proj_passion_shoot/features/data/model/payment/body/payment_body.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final RemoteDataSource remoteDataSource;
  PaymentMethodBloc(this.remoteDataSource) : super(PaymentMethodInitial()) {
    on<LoadPaymentMethod>((event, emit) async {
      emit(PaymentMethodLoading());
      try {
        final result = await remoteDataSource.getPaymentMethod();
        emit(PaymentMethodLoaded(result.data));
      } catch (e) {
        emit(PaymentMethodError(e.toString()));
      }
    });
  }
}
