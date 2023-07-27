import 'package:attedance/authentication/auth_method.dart';
import 'package:attedance/widget_use/another_button.dart';
import 'package:attedance/widget_use/text_control.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoAttedancePage extends StatefulWidget {
  const NoAttedancePage({super.key});

  @override
  State<NoAttedancePage> createState() => _NoAttedancePageState();
}

class _NoAttedancePageState extends State<NoAttedancePage> {
  TextEditingController controlket = TextEditingController();
  final items = [
    'Sakit',
    'Ijin',
  ];

  final totalday = [
    '1',
    '2',
    '3',
  ];

  String? values;
  String? values2;

  String lottieanim() {
    switch (values) {
      case "Sakit":
        return 'lottie/sick_lottie.json';
      case "ijin":
        return 'lottie/cycle_lottie.json';
      default:
        return 'lottie/cycle_lottie.json';
    }
  }

  @override
  void dispose() {
    super.dispose();
    controlket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.012,
          horizontal: size.width * 0.05,
        ),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                width: size.width,
                height: size.height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mau ijin apa',
                      style: TextStyle(
                          fontSize: size.height * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                    Text('hari ini...',
                        style: TextStyle(
                            fontSize: size.height * 0.04,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.4,
                child: Lottie.asset(lottieanim()),
              ),
              Container(
                width: size.width,
                height: size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width,
                      child: Row(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Perihal',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: items
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: values,
                              onChanged: (String? value) {
                                setState(() {
                                  values = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Jumlah Hari',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: totalday
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: values2,
                              onChanged: (String? value) {
                                setState(() {
                                  values2 = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Textcontrol(
                        controltext: controlket,
                        hintit: 'masukan keterangan...',
                        colorfield: Colors.grey[200]!,
                        widthit: size.width * 0.9,
                        iconit: Icons.note),
                  ],
                ),
              ),
              AnotherButton(
                  btnname: 'Kirim',
                  action: () async {
                    await nonattedance(values2!, DateTime.now(), values!, controlket.text, context);
                    controlket.clear();
                  },
                  width: size.width,
                  height: size.height * 0.08,
                  colors: Colors.blueAccent,
                  size: size,
                  radius: 12)
            ],
          ),
        ),
      ),
    );
  }
}
