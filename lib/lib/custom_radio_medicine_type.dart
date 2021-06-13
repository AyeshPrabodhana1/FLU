import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomRadio extends StatefulWidget {
  final CustomRadioState _customRadioState = new CustomRadioState();

  String get getSelectedMedicineType {
    return _customRadioState._getSelectedValue;
  }

  @override
  createState() {
    return _customRadioState;
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = <RadioModel>[];

  String _selectedValue = 'Pill';

  String get _getSelectedValue {
    return _selectedValue;
  }

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(true, FontAwesomeIcons.capsules, 'Pill'));
    sampleData.add(new RadioModel(false, FontAwesomeIcons.tablets, 'Tablet'));
    sampleData.add(
        new RadioModel(false, FontAwesomeIcons.prescriptionBottle, 'Bottle'));
    sampleData.add(new RadioModel(false, FontAwesomeIcons.syringe, 'Syringe'));
  }

  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 4.2),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: sampleData.length,
      itemBuilder: (BuildContext context, int index) {
        return new InkWell(
          splashColor: Colors.teal,
          highlightColor: Colors.teal,
          onTap: () {
            setState(() {
              sampleData.forEach((element) => element.isSelected = false);
              sampleData[index].isSelected = true;
              _selectedValue = sampleData[index].text;
            });
          },
          child: new RadioItem(sampleData[index]),
        );
      },
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: new Center(
              child: new FaIcon(
                _item.buttonIcon,
                color: _item.isSelected ? Colors.white : Colors.black,
              ),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Colors.teal : Colors.white,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.black : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(3.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0),
            child: new Text(_item.text),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final IconData buttonIcon;
  final String text;

  RadioModel(this.isSelected, this.buttonIcon, this.text);
}
