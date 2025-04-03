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

class LandingPageButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  const LandingPageButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(icon, size: 28), Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))],
            ),
          ),
        ),
      ),
    );
  }
}
