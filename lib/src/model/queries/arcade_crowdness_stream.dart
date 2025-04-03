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

import 'package:cloud_firestore/cloud_firestore.dart';

Stream<AggregateQuerySnapshot?> getArcadeCrowdnessStream(int id) {
  return FirebaseFirestore.instance
      .collection('reports')
      .where('id', isEqualTo: id)
      .where(
        'ttl',
        isGreaterThan: DateTime.now().subtract(const Duration(hours: 2)),
      )
      .aggregate(count(), sum("crowdness"))
      .get()
      .asStream();
}