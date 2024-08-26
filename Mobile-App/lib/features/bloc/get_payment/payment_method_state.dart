part of 'payment_method_bloc.dart';

@immutable
sealed class PaymentMethodState {}

final class PaymentMethodInitial extends PaymentMethodState {}

final class PaymentMethodLoading extends PaymentMethodState {}

final class PaymentMethodLoaded extends PaymentMethodState {
  final List<PaymentMethod> methods;

  PaymentMethodLoaded(this.methods);

}

final class PaymentMethodError extends PaymentMethodState {
  final String error;

  PaymentMethodError(this.error);
}
