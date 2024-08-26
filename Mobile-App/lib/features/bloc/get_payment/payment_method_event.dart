part of 'payment_method_bloc.dart';

@immutable
sealed class PaymentMethodEvent {}

final class LoadPaymentMethod extends PaymentMethodEvent {}
