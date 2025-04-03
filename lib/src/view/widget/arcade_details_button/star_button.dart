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

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hkarcadequeue/src/controller/provider/arcade_provider/preferred_arcade_provider.dart';

class StarButton extends ConsumerStatefulWidget {
  const StarButton({super.key, required this.id});
  final int id;

  @override
  ConsumerState<StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends ConsumerState<StarButton> {
  bool isPreferred = false;

  @override
  void initState() {
    super.initState();
    _isInPreferred();
  }

  Future<void> _isInPreferred() async {
    final bool result = await ref
        .read(preferredArcadeNotifierProvider.notifier)
        .isInPreferred(widget.id);
    if (mounted) {
      setState(() {
        isPreferred = result;
      });
    }
  }

  void _updatePreferred() {
    if (isPreferred) {
      ref
          .read(preferredArcadeNotifierProvider.notifier)
          .removePreferred(widget.id);
      if (mounted) {
        setState(() {
          isPreferred = false;
        });
      }
    } else {
      ref
          .read(preferredArcadeNotifierProvider.notifier)
          .addPreferred(widget.id);
      if (mounted) {
        setState(() {
          isPreferred = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isPreferred ? Icons.star : Icons.star_border,
        color: isPreferred ? Colors.amber.shade600 : null,
      ),
      onPressed: _updatePreferred,
    );
  }
}
