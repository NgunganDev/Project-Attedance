import 'package:attedance/format/date_format.dart';
import 'package:attedance/widget_use/another_button.dart';
import 'package:flutter/material.dart';

class HistoryAttedanceAdmin extends StatefulWidget {
  const HistoryAttedanceAdmin({super.key});

  @override
  State<HistoryAttedanceAdmin> createState() => _HistoryAttedanceAdminState();
}

class _HistoryAttedanceAdminState extends State<HistoryAttedanceAdmin> {
  String pickedDate = '';

  void calendarPick() async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: (DateTime.now()).add(const Duration(days: 7)))
        .then((value) {
      setState(() {
        pickedDate = Format().FormatDate(value!);
      });
      print(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.03, horizontal: size.width * 0.03),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Attedance History',
                    style: TextStyle(
                        fontSize: size.height * 0.04,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20)),
              width: size.width * 0.9,
              height: size.height * 0.2,
              child: PageView(
                children: [],
              ),
            ),
            Container(
              width: size.width * 0.9,
              height: size.height * 0.2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnotherButton(
                      btnname: 'Pick Date',
                      action: () {
                        calendarPick();
                      },
                      width: size.width * 0.35,
                      height: size.height * 0.06,
                      colors: Colors.lightBlueAccent,
                      size: size,
                      radius: 24),
                  AnotherButton(
                      btnname: 'Top User',
                      action: () {},
                      width: size.width * 0.35,
                      height: size.height * 0.06,
                      colors: Colors.lightBlueAccent,
                      size: size,
                      radius: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
