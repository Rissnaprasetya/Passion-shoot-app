part of 'event_bloc.dart';

@immutable
sealed class EventState {}

final class EventInitial extends EventState {}
final class EventLoading extends EventState {}
final class EventLoaded extends EventState {
  final List<Event> events;

  EventLoaded({required this.events});
}
final class EventError extends EventState {
  final String error;

  EventError({required this.error});
}
