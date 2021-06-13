class Reminder {
  late int _id;
  late String _medicineName;
  late String _type;
  late double _dosage;
  late int _intervalDays;
  late int _intervalHours;
  late String _startDate;
  late String _startTime;

  Reminder(int id, String medicineName, String type, double dosage,
      int intervalDays, int intervalHours, String startDate, String startTime) {
    this._id = id;
    this._medicineName = medicineName;
    this._dosage = dosage;
    this._type = type;
    this._intervalDays = intervalDays;
    this._intervalHours = intervalHours;
    this._startDate = startDate;
    this._startTime = startTime;
  }

  // Reminder(String medicineName, String type, double dosage, int intervalDays,
  //     int intervalHours, String startDate, String startTime) {
  //   this._medicineName = medicineName;
  //   this._dosage = dosage;
  //   this._type = type;
  //   this._intervalDays = intervalDays;
  //   this._intervalHours = intervalHours;
  //   this._startDate = startDate;
  //   this._startTime = startTime;
  // }

  int get id {
    return _id;
  }

  String get medicineName {
    return _medicineName;
  }

  String get type {
    return _type;
  }

  double get dosage {
    return _dosage;
  }

  int get intervalDays {
    return _intervalDays;
  }

  int get intervalHours {
    return _intervalHours;
  }

  String get startDate {
    return _startDate;
  }

  String get startTime {
    return _startTime;
  }
}
