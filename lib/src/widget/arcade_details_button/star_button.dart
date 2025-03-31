import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hkarcadequeue/src/provider/arcade_provider/preferred_arcade_provider.dart';

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
