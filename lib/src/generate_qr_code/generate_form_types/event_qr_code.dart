import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common_lib.dart';
// For date formatting

class GenerateEventQRCode extends HookWidget {
  const GenerateEventQRCode({super.key, required this.onChange});
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final locationController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final startDate = useState<DateTime?>(null);
    final endDate = useState<DateTime?>(null);

    final startController = useTextEditingController();
    final endController = useTextEditingController();

    void updateQRCode() {
      final startDateStr = startDate.value != null
          ? DateFormat('yyyyMMddTHHmmss').format(startDate.value!)
          : '';
      final endDateStr = endDate.value != null
          ? DateFormat('yyyyMMddTHHmmss').format(endDate.value!)
          : '';
      final qrCodeContent = 'BEGIN:VEVENT\n'
          'SUMMARY:${nameController.text}\n'
          'DESCRIPTION:${descriptionController.text}\n'
          'LOCATION:${locationController.text}\n'
          'DTSTART:$startDateStr\n'
          'DTEND:$endDateStr\n'
          'END:VEVENT';

      onChange(qrCodeContent);
    }

    Future<void> selectDateTime(
        BuildContext context, ValueNotifier<DateTime?> dateState, bool isStart) async {
      final DateTime? pickedDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          final DateTime fullDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          dateState.value = fullDateTime;
          final formattedDateTime =
              DateFormat('dd MMM yyyy, hh:mm a').format(fullDateTime);
          if (isStart) {
            startController.text = formattedDateTime;
          } else {
            endController.text = formattedDateTime;
          }
          updateQRCode();
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Event Name'),
          const Gap(Insets.small),
          CustomTextFormField(
            onChanged: (value) => updateQRCode(),
            controller: nameController,
            hintText: 'Enter event name',
            validator: context.validator.required().build(),
          ),
          const Gap(Insets.large),
          const Text('Location'),
          const Gap(Insets.small),
          CustomTextFormField(
            keyboardType: TextInputType.streetAddress,
            onChanged: (value) => updateQRCode(),
            controller: locationController,
            hintText: 'Enter event location',
          ),
          const Gap(Insets.large),
          const Text('Start Date and Time'),
          const Gap(Insets.small),
          TextFormField(
            readOnly: true,
            controller: startController,
            decoration: const InputDecoration(hintText: 'Select Start date and time'),
            onTap: () => selectDateTime(context, startDate, true),
            validator: context.validator.required().build(),
          ),
          const Gap(Insets.large),
          const Text('End Date and Time'),
          const Gap(Insets.small),
          TextFormField(
            readOnly: true,
            controller: endController,
            decoration: const InputDecoration(hintText: 'Select End date and time'),
            onTap: () => selectDateTime(context, endDate, false),
            validator: context.validator.required().build(),
          ),
          const Gap(Insets.large),
          const Text('Description'),
          const Gap(Insets.small),
          CustomTextFormField(
            keyboardType: TextInputType.text,
            onChanged: (value) => updateQRCode(),
            controller: descriptionController,
            maxLines: 5,
            hintText: 'Enter description',
          ),
        ],
      ),
    );
  }
}
