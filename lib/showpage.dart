import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'api.dart';

class API extends StatefulWidget {
  const API({Key? key}) : super(key: key);

  @override
  _APIState createState() => _APIState();
}

String text = "";

bool show = false;

double years = 0.0;
double month = 0.0;
bool _isLooding = true;

_changeYears(double values) {
  years = values;
}

_changemount(double values) {
  month = values;
}

class _APIState extends State<API> {
  void _showError(String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ผลการทาย"),
          content: Text(text),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendData() async {
    if (_isLooding == true) {
      var sendData = (await Api().submit('guess_teacher_age', {
        'year': years.toInt(),
        'month': month.toInt()
      })) as Map<String, dynamic>;
      if (sendData['value'] == false) {
        _showError(sendData['text']);
      }
      else if (sendData['value'] == true) {

        setState(() {
          show = true;
          _isLooding == false;
        });


      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow.shade100,
        appBar: AppBar(
          title: Text("GUESS TEACHER'S AGE"),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "อายุอาจารย์",
              style: TextStyle(fontSize: 40.0, color: Colors.brown.shade400),
            ),
            show == false
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpinBox(
                            decoration: InputDecoration(labelText: "ปี"),
                            textStyle: TextStyle(fontSize: 35.0),
                            min: 0,
                            max: 100,
                            value: 0.0,
                            onChanged: (value) => _changeYears(value),
                          ),
                          SpinBox(
                            decoration: InputDecoration(labelText: "เดือน"),
                            textStyle: TextStyle(fontSize: 35.0),
                            min: 0,
                            max: 11,
                            value: 0.0,
                            onChanged: (value) => _changemount(value),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: _sendData,
                                child: Text(
                                  "ทาย",
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3.0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        "$years ปี $month เดือน",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Icon(
                        Icons.check,
                        size: 100,
                        color: Colors.green,
                      )
                    ],
                  ),

            //
          ]),
        ));
  }
}

//Text("อายุอาจารย์",style: TextStyle(fontSize: 40.0,color: Colors.brown.shade400),),
/*void _showError(old) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ผลการทาย'),
        content: Text('Invalid PIN. Please try again.'),
        actions: [
          // ปุ่ม OK ใน dialog
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              // ปิด dialog
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}*/
