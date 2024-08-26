// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import DateFormat from intl package
import 'package:proj_passion_shoot/core/api_service.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/core/network/remote_datasource.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/body/event_body.dart';

import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';

// ignore: must_be_immutable
class EventScreen extends StatefulWidget {
  EventScreen({
    super.key,
    required this.eventController,
    required this.selectedTime,
    required this.selectedDate,
    required this.onPressed,
    required this.remoteDataSource,
  });

  final TextEditingController eventController;
  TimeOfDay selectedTime; //menyimpan time
  DateTime selectedDate; // menyimpan date
  void Function()? onPressed;
  final RemoteDataSource remoteDataSource;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final _key = GlobalKey();

  Service service = Service();
  Future<void> _saveEvent() async {
    try {
      final existingEvents = await widget.remoteDataSource.getEvent();
      final existingEvent = existingEvents.data
          .any((element) => element.time == DateFormat('HH:mm:ss').format(DateTime(2024, 5, 28,
                    widget.selectedTime.hour, widget.selectedTime.minute)));

      if (existingEvent) {
        // Duplicate event found, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menambahkan event: Jadwal dalam waktu tersebut sudah ada'),
          ),
        );
      } else {
        final newEvent = Event(
          date: DateFormat('yyyy-MM-dd').format(widget.selectedDate),
          title: widget.eventController.text,
          time: DateFormat('HH:mm:ss').format(
            DateTime(2024, 5, 28, widget.selectedTime.hour,
                widget.selectedTime.minute),
          ),
        );

        log('Data Event, Title: ${newEvent.title}, Date: ${newEvent.date}, Time: ${newEvent.time}');

        try {
          await widget.remoteDataSource.postEventCalender(newEvent);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Event berhasil ditambahkan'),
            ),
          );
          widget.eventController.clear();

          // Navigate to HomeScreen after successful event addition
          Navigator.of(context).popAndPushNamed('/');
          // Navigator.pop(context);
        } catch (e) {
          log('Error menyimpan event: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menyimpan event: $e'),
            ),
          );
        }
      }
    } catch (e, stackTrace) {
      log('Error while saving event: $e');
      log('Stack Trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan event: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Tambah Event',
          leading: BackButton(
            color: secondaryTextColor,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: double.infinity,
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: widget.eventController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  hintText: 'Event Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field ini harus diisi";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                controller: TextEditingController(
                  text:
                      '${widget.selectedTime.hour}:${widget.selectedTime.minute}',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  suffixIcon: const Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: widget.selectedTime,
                    initialEntryMode: TimePickerEntryMode.inputOnly,
                  );
                  if (timeOfDay != null) {
                    setState(() {
                      widget.selectedTime = timeOfDay;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field ini harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  onPressed: _saveEvent,
                  child: Text(
                    'Simpan',
                    style: secondaryTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
