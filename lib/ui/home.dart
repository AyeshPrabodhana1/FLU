import 'package:flutter/material.dart';
import 'package:med_reminder/models/reminder.dart';
import 'add_ui.dart';
import 'update_ui.dart';
import 'package:med_reminder/database/database.dart';

class HomeScreen extends StatelessWidget {
  late Future<List<Reminder>> reminders;
  DatabaseController databaseController = new DatabaseController();

  list() {
    reminders = databaseController.getReminders();
    return Expanded(
      child: FutureBuilder(
        future: reminders,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //return dataTable((snapshot.data);
          }

          //if (null == snapshot.data || snapshot.data.length == 0) {
          //  return Text("No Data Found");
          //}

          return CircularProgressIndicator();
        },
      ),
    );
  }

  SingleChildScrollView dataTable(List<Reminder> reminders) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('Medicine Name'),
          ),
          DataColumn(
            label: Text('DELETE'),
          ),
          DataColumn(
            label: Text('UPDATE'),
          )
        ],
        rows: reminders
            .map(
              (reminder) => DataRow(cells: [
                DataCell(
                  Text(reminder.medicineName),
                  onTap: () {},
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // dbHelper.delete(employee.id);
                    // refreshList();
                  },
                )),
              ]),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MedReminder"),
        ),
        body: Container(
            child: new Column(
          children: [
            new Container(
              margin: EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddUI()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text('Add a Reminder'),
                  )),
            ),
            new Container(
              margin: EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UpdateUI()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text('Update a Reminder'),
                  )),
            ),
            new Container(
              margin: EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    //  Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => UpdateUI()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text('Delete'),
                  )),
            ),
            list(),
          ],
        )));
  }
}
