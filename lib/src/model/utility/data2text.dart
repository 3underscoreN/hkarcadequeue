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

import 'package:hkarcadequeue/src/model/type/arcade_store.dart';

String amountConverter(int amount) {
  if (amount == -1) {
    return "未知";
  }
  if (amount == 0) {
    return "一部都冇哭能咗";
  }
  return amount.toString();
}

String smokeConverter(String smoke) {
  if (smoke == "unknown") {
    return "未知";
  }
  if (smoke == "none") {
    return "無煙";
  }
  if (smoke == "light") {
    return "少煙";
  }
  if (smoke == "heavy") {
    return "大煙";
  }
  return "未知";
}

String restrictionConverter(EntryRestriction r) {
  if (r == EntryRestriction.below16) {
    return "只準16歲以下人士進入。\n根據香港法例第435章第20條，年滿16歲人士，除為照顧一名16歲以下的人及保障其福利外，不得進入。";
  }
  return "只準16歲以上人士進入。\n未滿16歲人士，不得進入。";
}

