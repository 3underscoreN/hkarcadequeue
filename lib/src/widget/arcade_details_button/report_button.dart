import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:hkarcadequeue/src/screen/settings_screen/settings_page.dart';

import 'package:hkarcadequeue/src/widget/arcade_details_button/dialogs/report_dialog.dart';

class ReportButton extends StatelessWidget{
  const ReportButton({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_upward),
      tooltip: '回報',
      onPressed: () async {
        bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
        if (isLoggedIn) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ReportDialog(id: id);
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("唔好意思，要登入先可以用到回報功能！"),
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(label: "去登入", onPressed: 
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}