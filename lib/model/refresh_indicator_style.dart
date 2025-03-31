import 'package:flutter/material.dart';

class IndicatorColors {
  final Color content;
  final Color background;

  const IndicatorColors({
    required this.content,
    required this.background,
  });
}

class IndicatorStyle {
  final IndicatorColors loading;
  final IndicatorColors completed;
  final IndicatorColors error;

  const IndicatorStyle({
    required this.loading,
    required this.completed,
    required this.error,
  });
}

const IndicatorStyle defaultIndicatorStyle = IndicatorStyle(
  loading: IndicatorColors(
    content: Colors.white,
    background: Colors.blue,
  ),
  completed: IndicatorColors(
    content: Colors.white,
    background: Colors.green,
  ),
  error: IndicatorColors(
    content: Colors.white,
    background: Colors.red,
  ),
);