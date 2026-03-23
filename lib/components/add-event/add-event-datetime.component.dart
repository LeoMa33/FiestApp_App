import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/event/data/provider/event_create_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddEventDateTime extends ConsumerStatefulWidget {
  const AddEventDateTime({super.key});

  @override
  ConsumerState<AddEventDateTime> createState() => _AddEventDateTimeState();
}

class _AddEventDateTimeState extends ConsumerState<AddEventDateTime> {
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(eventCreateProvider);
    _dateController = TextEditingController(
      text: state.date != null ? DateFormat('dd/MM/yyyy').format(state.date!) : '',
    );
    _timeController = TextEditingController(
      text: state.time != null ? state.time!.format(context) : '',
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        Expanded(
          flex: 4,
          child: DataTagInput(
            title: "Date",
            iconColor: Color(0xffE15B42),
            placeholder: "01/01/2025",
            inputType: InputType.date,
            controller: _dateController,
            icon: FontAwesomeIcons.calendar,
            onChanged: (value) {
              if (value != null) {
                final date = DateFormat('dd/MM/yyyy').parse(value);
                ref.read(eventCreateProvider.notifier).updateDate(date);
              }
            },
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          ),
        ),
        Expanded(
          flex: 3,
          child: DataTagInput(
            title: "Heure",
            placeholder: "0:00",
            inputType: InputType.time,
            controller: _timeController,
            icon: FontAwesomeIcons.clock,
            iconColor: Color(0xffE15B42),
            onChanged: (value) {
              if (value != null) {
                final time = TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(value));
                ref.read(eventCreateProvider.notifier).updateTime(time);
              }
            },
          ),
        ),
      ],
    );
  }
}
