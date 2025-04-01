import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show AggregateQuerySnapshot;

import 'package:hkarcadequeue/src/model/queries/arcade_crowdness_stream.dart';

class PeopleCountShower extends ConsumerStatefulWidget {
  final int id;
  const PeopleCountShower({super.key, required this.id});

  @override
  ConsumerState<PeopleCountShower> createState() => _PeopleCountShowerState();
}

class _PeopleCountShowerState extends ConsumerState<PeopleCountShower> {

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Icon(Icons.error);
          }
          if (!snapshot.hasData) {
            return Icon(Icons.no_accounts_outlined);
          }
          return StreamBuilder<AggregateQuerySnapshot?>(
            stream: getArcadeCrowdnessStream(widget.id),
            builder: (BuildContext context, AsyncSnapshot<AggregateQuerySnapshot?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return Icon(Icons.error);
              }
              final int? c = snapshot.data?.count;
              final double? rc = snapshot.data?.getSum("crowdness");
              if (c == null || rc == null) {
                return Icon(Icons.error);
              }
              if (c == 0) {
                return Center(child: Icon(Icons.horizontal_rule));
              }
              return SleekCircularSlider(
                min: 0.0,
                max: 4.0,
                initialValue: rc / c,
                appearance: CircularSliderAppearance(
                  animationEnabled: false,
                  customWidths: CustomSliderWidths(
                    trackWidth: 2,
                    progressBarWidth: 14,
                    handlerSize: 14,
                    shadowWidth: 0,
                  ),
                  customColors: CustomSliderColors(
                    trackColor: Colors.pinkAccent[300],
                    progressBarColors: [Colors.green, Colors.yellow, Colors.red],
                  ),
                ),
                innerWidget: (double _) => Container(),
              );
            },
          );
        },
      ),
    );
  }
}
