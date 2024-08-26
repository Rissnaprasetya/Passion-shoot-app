
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/core/network/remote_datasource.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/body/event_body.dart';


part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final RemoteDataSource remoteDatasource;
  EventBloc(this.remoteDatasource) : super(EventInitial()) {
    on<LoadEvent>((event, emit) async {
      emit(EventLoading());
      try { 
        final result = await remoteDatasource.getEvent();
        emit(EventLoaded(events: result.data));
        log(result.data.toString());
      } catch (e) {
        emit(EventError(error: e.toString()));
      }
    });
  }
}
