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

