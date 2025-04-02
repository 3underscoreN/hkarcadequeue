import 'package:flutter/material.dart';

import 'package:cloud_functions/cloud_functions.dart';

import 'package:hkarcadequeue/src/constant/possible_crowdness.dart'
    show crowdnessChinese;

import 'package:hkarcadequeue/src/model/utility/int2crowdness.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({super.key, required this.id});
  final int id;

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  double _sliderValue = 0.0;
  bool _isLoading = false;

  Future<bool> _reportCrowdnessHandler(int id, int crowdness) async {
    final String ident = id.toString();
    final String crowd = int2crowdness(crowdness);
    try {
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'addreport',
      );
      final response = await callable.call(<String, String>{
        'ident': ident,
        'crowdness': crowd,
      });
      return response.data != null;
    } catch (e) {
      return false;
    }
  }

  Future<void> _reportHandler() async {
    setState(() {
      _isLoading = true;
    });
    bool isSuccess = await _reportCrowdnessHandler(
      widget.id,
      _sliderValue.toInt(),
    );
    if (!mounted) return;
    if (isSuccess) {
      // ignore: use_build_context_synchronously - mounted check implemented
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('回報成功！'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // ignore: use_build_context_synchronously - mounted check implemented
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('回報失敗 - 重新試吓？'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    // ignore: use_build_context_synchronously - mounted check implemented
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('回報人數', style: TextStyle(fontSize: 24)),
            
            const SizedBox(height: 24),
            Slider(
              value: _sliderValue,
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
              min: 0.0,
              max: 4.0,
              divisions: 4,
              label: int2crowdnessChinese(_sliderValue.toInt()),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(crowdnessChinese.values.first),
                const SizedBox(width: 20),
                Text(crowdnessChinese.values.last),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _reportHandler,
              icon:
                  _isLoading
                      ? Container(
                        padding: const EdgeInsets.all(2.0),
                        width: IconTheme.of(context).size ?? 24,
                        height: IconTheme.of(context).size ?? 24,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Icon(Icons.check),
              label: const Text('確認'),
            ),
          ],
        ),
      ),
    );
  }
}
