part of 'post_event_bloc.dart';

@immutable
sealed class PostEventState {}

final class PostEventInitial extends PostEventState {}

final class PostEventLoading extends PostEventState {}

final class PostEventSuccess extends PostEventState {}

final class PostEventError extends PostEventState {}
