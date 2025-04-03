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

import "package:hkarcadequeue/src/constant/possible_crowdness.dart";

/// Convert int to crowdness string
/// 
/// Input: int 0-4
/// Output: String "zero", "low", "medium", "high", "dontgo"
/// 
/// If the input is not in the range of 0-4, return an empty string
String int2crowdness(int corwdnessInt) {
  if (corwdnessInt < 0 || corwdnessInt > 4) {
    return "";
  }
  return possibleCrowdness.entries
      .firstWhere((element) => element.value == corwdnessInt)
      .key;
}

String int2crowdnessChinese(int corwdnessInt) {
  if (corwdnessInt < 0 || corwdnessInt > 4) {
    return "";
  }
  return crowdnessChinese[corwdnessInt] ?? "";
}