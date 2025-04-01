import 'package:cloud_firestore/cloud_firestore.dart';

enum EntryRestriction {
  below16,
  above16,
}

class ArcadeStore {
  final int id;
  final String chineseName;
  final String englishName;
  final String chineseAddress;
  final String englishAddress;
  final String abbreviation;
  final int maiAmount;
  final int chuniAmount;
  final GeoPoint location;
  final String smokiness;
  final EntryRestriction restriction;

  static final Map<int, ArcadeStore> _cache = <int, ArcadeStore>{};

  factory ArcadeStore(int id, String cName, String eName, String cAddr, String eAddr, String abbr, int maiAmt, int chuAmt, GeoPoint loc, String smokiness, EntryRestriction restriction) {
    return _cache.putIfAbsent(id, () => ArcadeStore._internal(id, cName, eName, cAddr, eAddr, abbr, maiAmt, chuAmt, loc, smokiness, restriction));
  }

  /// A `factory` constructor that creates an [ArcadeStore] instance from a JSON object.
  /// The json object should have the following keys:
  /// - `name_chi`: [String]
  /// - `name_eng`: [String]
  /// - `address_chi`: [String]
  /// - `address_eng`: [String]
  /// - `abbv_chi`: [String]
  /// - `maimai_amount`: [int]
  /// - `chunithm_amount`: [int]
  /// - `geoloc`: [GeoPoint]
  /// - `smoke`: [String]
  /// - `isForKids`: [String] or [null]
  /// - `liveData`: [List]
  factory ArcadeStore.fromJSON(int id, dynamic json) {
    String cName = json["name_chi"]!.toString();
    String eName = json["name_eng"]!.toString();
    String cAddr = json["address_chi"]!.toString();
    String eAddr = json["address_eng"]!.toString();
    String abbr = json["abbv_chi"]!.toString();
    int maiAmt = json["maimai_amount"]!;
    int chuAmt = json["chunithm_amount"]!;
    GeoPoint loc = json["geoloc"]!;
    String smokiness = json["smoke"]!;

    late EntryRestriction restriction;
    if (json["isForKids"] == "yes") {
      restriction = EntryRestriction.below16;
    } else {
      restriction = EntryRestriction.above16;
    }
    
    return ArcadeStore(id, cName, eName, cAddr, eAddr, abbr, maiAmt, chuAmt, loc, smokiness, restriction);
  }

  ArcadeStore._internal(this.id, this.chineseName, this.englishName, this.chineseAddress, this.englishAddress, this. abbreviation, this.maiAmount, this.chuniAmount, this.location, this.smokiness, this.restriction);

  /// A static function that gets all already-initialized [ArcadeStore] instances.
  static Map<int, ArcadeStore> getArcadeList() {
    return _cache;
  }

  /// A static function that finds among existing [ArcadeStore] instances given the [id].
  /// 
  /// Throws `"Item not found."` if not found.
  static ArcadeStore lookup(int id) {
    if (_cache.containsKey(id)) {
      return _cache[id]!;
    }
    throw "Item not found.";
  }
}