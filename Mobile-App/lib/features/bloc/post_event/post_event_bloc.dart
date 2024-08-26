import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/core/network/remote_datasource.dart';

import 'package:proj_passion_shoot/features/data/model/event_calender/body/event_body.dart';

part 'post_event_event.dart';
part 'post_event_state.dart';

class PostEventBloc extends Bloc<PostEventEvent, PostEventState> {
  final RemoteDataSource remoteDataSource;
  PostEventBloc(this.remoteDataSource) : super(PostEventInitial()) {
    on<PostDataEvent>((event, emit) async {
      emit(PostEventLoading());
      try {
        final response = await remoteDataSource.postEventCalender(event.body);
        log('post body: ${response.message}');
        if (response.status == 200) {
          emit(PostEventSuccess());
        } else {
          emit(PostEventError());
        }
      } catch (e) {
        log('post event calender catch: $e');
      }
    });
  }
}
