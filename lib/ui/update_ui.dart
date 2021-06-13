import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:med_reminder/controllers/update_reminder_controller.dart';
import 'package:med_reminder/lib/custom_radio_medicine_type.dart';

void main() {
  runApp(UpdateUI());
}

class UpdateUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpdateUIState();
  }
}

enum NewReminder { pill, tablet, bottle, syringe }

class _UpdateUIState extends State<UpdateUI> {
  // TextEditingControllers
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _medicineNameController = TextEditingController();
  TextEditingController _dosageController = TextEditingController();
  TextEditingController _daysController = TextEditingController(text: '0');
  TextEditingController _hoursController = TextEditingController(text: '0');

  // Start date time values
  String _selectedDate = '';
  String _selectedTime = '';

  CustomRadio _selectMedicineTypeRadio = new CustomRadio();

  // Submit function
  void _submitData() async {
    UpdateReminderController updateReminderController =
        new UpdateReminderController();
    final result = await updateReminderController.updateReminder(
        _medicineNameController.text,
        _selectMedicineTypeRadio.getSelectedMedicineType,
        _dosageController.text,
        _daysController.text,
        _hoursController.text,
        _selectedDate,
        _selectedTime);
    if (result == 'success') {
      ArtDialogResponse dialog = await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            showCancelBtn: false,
            title: 'Success!',
            text: 'Reminder Updated successfully!',
          ));
      Navigator.of(context, rootNavigator: true).pop(context);
    } else {
      ArtDialogResponse dialog = await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            showCancelBtn: false,
            title: 'Error!',
            text: '$result',
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedReminder',
      home: Builder(
          builder: (context) => Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text('Update Reminder'),
                      pinned: true,
                      expandedHeight: 200.0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          'assets/medical-1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 85.0, minHeight: 85.0),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 20.0, bottom: 10.0, left: 20.0, right: 20.0),
                          child: TextFormField(
                            controller: _medicineNameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter Medicine Name *',
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10.0, bottom: 0.0, left: 20.0, right: 20.0),
                          child: Text('Select Medicine Type *',
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 200.0, minHeight: 200.0),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 0.0, bottom: 10.0, left: 20.0, right: 20.0),
                          child: _selectMedicineTypeRadio,
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 85.0, minHeight: 85.0),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                          child: TextFormField(
                            controller: _dosageController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter Dosage in mg (Optional)',
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 85.0, minHeight: 85.0),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                          child: TextFormField(
                            controller: _daysController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Interval Days *',
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 85.0, minHeight: 85.0),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                          child: TextFormField(
                            controller: _hoursController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Interval Hours *',
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0,
                                  right: 10.0,
                                  bottom: 10.0,
                                  top: 15.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Start Date',
                                    fillColor: Colors.white,
                                    filled: true),
                                controller: _startDateController,
                                enabled: false,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight: 85.0, minHeight: 85.0),
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0,
                                      right: 20.0,
                                      bottom: 10.0,
                                      top: 15.0),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                          color: Colors.teal, width: 1),
                                    ),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(2021, 1, 1),
                                          maxTime: DateTime(2030, 1, 1),
                                          onConfirm: (date) {
                                        DateTime selected = date;
                                        DateFormat formatter1 =
                                            DateFormat('cccc LLLL dd');
                                        DateFormat formatter2 =
                                            DateFormat('yyyy-MM-dd');
                                        String newDate =
                                            formatter1.format(selected);
                                        _selectedDate =
                                            formatter2.format(selected);
                                        setState(() {
                                          _startDateController.text = newDate;
                                        });
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    child: const Text('Select Date'),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0,
                                  right: 10.0,
                                  bottom: 10.0,
                                  top: 20.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Start Time',
                                    fillColor: Colors.white,
                                    filled: true),
                                controller: _startTimeController,
                                enabled: false,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight: 90.0, minHeight: 90.0),
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0,
                                      right: 20.0,
                                      bottom: 10.0,
                                      top: 20.0),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                          color: Colors.teal, width: 1),
                                    ),
                                    onPressed: () {
                                      DatePicker.showTime12hPicker(context,
                                          showTitleActions: true,
                                          onConfirm: (time) {
                                        DateTime selected = time;
                                        DateFormat formatter1 =
                                            DateFormat('h:mm a');
                                        DateFormat formatter2 =
                                            DateFormat('HH:mm:ss');
                                        String newTime =
                                            formatter1.format(selected);
                                        _selectedTime =
                                            formatter2.format(selected);
                                        setState(() {
                                          _startTimeController.text = newTime;
                                        });
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    child: const Text('Select Time'),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 0.0, top: 20.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: 30.0, right: 30.0, bottom: 10.0, top: 5.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Container(
                                    height: 40,
                                    margin: EdgeInsets.only(
                                        left: 0.0,
                                        right: 30.0,
                                        bottom: 10.0,
                                        top: 5.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(context);
                                        },
                                        child: Text('Cancel'),
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.grey))),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    height: 40,
                                    margin: EdgeInsets.only(
                                        left: 30.0,
                                        right: 0.0,
                                        bottom: 10.0,
                                        top: 5.0),
                                    child: ElevatedButton(
                                        onPressed: _submitData,
                                        child: Text('Update'))),
                              )
                            ],
                          )),
                    ]))
                  ],
                ),
              )),
      theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.grey.shade100),
    );
  }
}
