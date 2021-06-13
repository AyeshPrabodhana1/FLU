import 'package:med_reminder/database/database.dart';
import 'package:med_reminder/models/reminder.dart';

class UpdateReminderController {
  static final UpdateReminderController _addReminderController =
      UpdateReminderController._internal();

  factory UpdateReminderController() {
    return _addReminderController;
  }

  UpdateReminderController._internal();

  Future<String> updateReminder(
      String medicineName,
      String medicineType,
      String dosage,
      String days,
      String hours,
      String startDate,
      String startTime) async {
    // Validate user inputs
    if (medicineName.isEmpty) {
      return 'Medicine name is Empty!';
    } else if (medicineType.isEmpty) {
      return 'Medicine type is Empty!';
    } else if (days.isEmpty) {
      return 'Interval days is Empty!';
    } else if (hours.isEmpty) {
      return 'Interval hours is Empty!';
    } else if (startDate.isEmpty) {
      return 'Start date is Empty!';
    } else if (startTime.isEmpty) {
      return 'Start time is Empty!';
    }

    double formattedDosage = 0.0;

    // Validate dosage's value
    if (dosage.isNotEmpty) {
      if (!_isDouble(dosage)) {
        return 'Invalid value for dosage! It has to a numeric value!';
      } else {
        formattedDosage = double.parse(dosage);
      }
    }

    int formattedDays = 0;
    int formattedHours = 0;

    // Validate and format interval days
    if (!_isInteger(days)) {
      return 'Invalid value for Interval Days! It has to a number!';
    } else {
      formattedDays = int.parse(days);
    }

    // Validate and format interval hours
    if (!_isInteger(hours)) {
      return 'Invalid value for Interval Hours! It has to a number!';
    } else {
      formattedHours = int.parse(hours);
    }

    // Create Reminder object
    Reminder reminder = new Reminder(0, medicineName, medicineType,
        formattedDosage, formattedDays, formattedHours, startDate, startTime);

    DatabaseController databaseController = new DatabaseController();
    final result = await databaseController.updateReminder(reminder);

    if (result) {
      return 'success';
    } else {
      return 'Cannot update data to the Database!';
    }
  }

  // Check double value
  bool _isDouble(String check) {
    return double.tryParse(check) != null;
  }

  // Check integer value
  bool _isInteger(String check) {
    return int.tryParse(check) != null;
  }
}
