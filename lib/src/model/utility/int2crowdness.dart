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