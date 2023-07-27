import 'package:attedance/authentication/auth_method.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../state/state.dart';
import '../widget_use/sign_button.dart';
import '../widget_use/text_control.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  TextEditingController controlname = TextEditingController();
  TextEditingController controlemails = TextEditingController();
  TextEditingController controlpass = TextEditingController();

  @override
  void dispose() {
    controlemails.dispose();
    controlname.dispose();
    controlpass.dispose();
    super.dispose();
  }

  Future<void> validator() async {
    DateTime timenow = DateTime.now();
    var time = DateFormat.yMMMEd().format(timenow);
    if (controlemails.text.isNotEmpty &&
        controlname.text.isNotEmpty &&
        controlpass.text.isNotEmpty) {
      await signup(
          controlname.text, controlemails.text, controlpass.text, time, ref, values!, context);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:))
    }
  }

  final items = ['Admin', 'User'];

  String? values;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(color: Colors.grey[300]),
      width: size.width,
      height: size.height,
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.width * 0.02),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spa,
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          SizedBox(
              width: size.width * 0.6,
              height: size.height * 0.3,
              child: Image.asset('images/bgatt.png')),
          Expanded(
              child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          // vertical: size.height * 0.02,
                          horizontal: size.width * 0.02),
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.02,
                          horizontal: size.width * 0.02),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Type',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
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
                              values = value!;
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
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Textcontrol(
                    controltext: controlname,
                    hintit: 'username',
                    colorfield: Colors.white,
                    widthit: size.width * 0.9,
                    iconit: Icons.tag_faces),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Textcontrol(
                    controltext: controlemails,
                    hintit: 'email',
                    colorfield: Colors.white,
                    widthit: size.width * 0.9,
                    iconit: Icons.person),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Textcontrol(
                    controltext: controlpass,
                    hintit: 'password',
                    colorfield: Colors.white,
                    widthit: size.width * 0.9,
                    iconit: Icons.password),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width * 0.9,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            ref.read(authstate.notifier).update((state) => 0);
                          },
                          child: const Text('already have an account'))
                    ],
                  ),
                ),
                Signbutton(
                    bgbutton: Colors.black54,
                    btnname: 'SignUp',
                    action: () async {
                      await validator();
                      setState(() {
                        controlemails.clear();
                        controlname.clear();
                        controlpass.clear();
                      });
                    },
                    widthit: size.width * 0.9,
                    heightit: size.height * 0.07)
              ],
            ),
          )),
        ],
      ),
    );
  }
}
