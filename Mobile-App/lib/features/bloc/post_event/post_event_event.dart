part of 'post_event_bloc.dart';

@immutable
sealed class PostEventEvent extends Equatable {
  const PostEventEvent();

  @override
  List<Object> get props => [];
}

final class PostDataEvent extends PostEventEvent {
  const PostDataEvent({required this.body});

  final Event body;
}
