/*
 * hkarcadequeue - An app for providing HK arcade info.
 * Copyright (C) 2025 CHAN Chung Yuk
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:hkarcadequeue/src/view/screen/settings_screen/settings_page.dart';

import 'package:hkarcadequeue/src/view/widget/arcade_details_button/dialogs/report_dialog.dart';

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