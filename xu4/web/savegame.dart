library savegame;

import 'dart:convert';
import 'enumerations.dart';

class SaveGame {
  int unknown1 = 0;
  int moves = 0;

  List<SaveGamePlayerRecord> players = new List.generate(8, (_) => new SaveGamePlayerRecord());

  int food = 0;

  int gold = 0;
  Map<Virtue, int> karma = new Map.fromIterable(Virtue.values, key: (k) => k, value: (v) => 50);
  int torches = 0;
  int gems = 0;
  int keys = 0;
  int sextants = 0;
  Map<ArmourType, int> armr = new Map.fromIterable(ArmourType.values, key: (k) => k, value: (v) => 0);
  Map<WeaponType, int> weapons = new Map.fromIterable(WeaponType.values, key: (k) => k, value: (v) => 0);
  Map<Reagent, int> reagents = new Map.fromIterable(Reagent.values, key: (k) => k, value: (v) => 0);
  Map<Spell, int> mixtures = new Map.fromIterable(Spell.values, key: (k) => k, value: (v) => 0);
  int items = 0;
  int x = 0,
      y = 0;
  int stones = 0;
  int runes = 0;
  int members = 1;
  int transport = 0x1f;
  int balloonstate = 0;
  int torchduration = 0;
  int trammelphase = 0;
  int feluccaphase = 0;
  int shiphull = 50;
  int lbintro = 0;
  int lastcamp = 0;
  Reagent lastreagent;
  int lastmeditation = 0;
  int lastvirtue = 0;
  int dngx = 0,
      dngy = 0;
  int orientation = 0;
  int dnglevel = 0xffff;
  int location = 0;

  SaveGame(SaveGamePlayerRecord avatar) {
    players[0] = avatar;
    food = 30000;
    gold = 200;
    reagents[Reagent.REAG_GINSENG] = 3;
    reagents[Reagent.REAG_GARLIC] = 4;
    torches = 2;
}

  SaveGame.fromMap(Map data) {
    balloonstate = data["balloonstate"];
    dnglevel = data["dnglevel"];
    dngx = data["dngx"];
    dngy = data["dngy"];
    feluccaphase = data["feluccaphase"];
    food = data["food"];
    gems = data["gems"];
    gold = data["gold"];
    items = data["items"];
    karma = data["karma"];
    keys = data["keys"];
    lastcamp = data["lastcamp"];
    lastmeditation = data["lastmeditation"];
    lastvirtue = data["lastvirtue"];
    lbintro = data["lbintro"];
    location = data["location"];
    members = data["members"];
    moves = data["moves"];
    orientation = data["orientation"];
    runes = data["runes"];
    sextants = data["sextants"];
    shiphull = data["shiphull"];
    stones = data["stones"];
    torchduration = data["torchduration"];
    torches = data["torches"];
    trammelphase = data["trammelphase"];
    transport = data["transport"];
    unknown1 = data["unknown1"];
    x = data["x"];
    y = data["y"];

    lastreagent = Reagent.parse(data["lastreagent"]);

    armr = new Map.fromIterable(data["armr"].keys, key: (k) => ArmourType.parse(k), value: (v) => data["armr"][v]);
    karma = new Map.fromIterable(data["karma"].keys, key: (k) => Virtue.parse(k), value: (v) => data["karma"][v]);
    mixtures = new Map.fromIterable(data["mixtures"].keys, key: (k) => Spell.parse(k), value: (v) => data["mixtures"][v]);;
    reagents = new Map.fromIterable(data["reagents"].keys, key: (k) => Reagent.parse(k), value: (v) => data["reagents"][v]);;
    weapons = new Map.fromIterable(data["weapons"].keys, key: (k) => WeaponType.parse(k), value: (v) => data["weapons"][v]);;
        
    players = data["players"].map((p) => new SaveGamePlayerRecord.fromMap(p)).toList(growable:false);
}
  
  String toJson() {
    var data = toMap();
    return JSON.encode(data);
  }

  Map toMap() {
    var data = new Map();
    data["balloonstate"] = balloonstate;
    data["dnglevel"] = dnglevel;
    data["dngx"] = dngx;
    data["dngy"] = dngy;
    data["feluccaphase"] = feluccaphase;
    data["food"] = food;
    data["gems"] = gems;
    data["gold"] = gold;
    data["items"] = items;
    data["keys"] = keys;
    data["lastcamp"] = lastcamp;
    data["lastmeditation"] = lastmeditation;
    data["lastvirtue"] = lastvirtue;
    data["lbintro"] = lbintro;
    data["location"] = location;
    data["members"] = members;
    data["moves"] = moves;
    data["orientation"] = orientation;
    data["runes"] = runes;
    data["sextants"] = sextants;
    data["shiphull"] = shiphull;
    data["stones"] = stones;
    data["torchduration"] = torchduration;
    data["torches"] = torches;
    data["trammelphase"] = trammelphase;
    data["transport"] = transport;
    data["unknown1"] = unknown1;
    data["x"] = x;
    data["y"] = y;

    data["armr"] = new Map.fromIterable(armr.keys, key: (k) => k.value, value: (v) => armr[v]);
    data["karma"] = new Map.fromIterable(karma.keys, key: (k) => k.name, value: (v) => karma[v]);
    data["mixtures"] = new Map.fromIterable(mixtures.keys, key: (k) => k.value, value: (v) => mixtures[v]);
    data["reagents"] = new Map.fromIterable(reagents.keys, key: (k) => k.value, value: (v) => reagents[v]);
    data["weapons"] = new Map.fromIterable(weapons.keys, key: (k) => k.value, value: (v) => weapons[v]);    

    data["lastreagent"] = (lastreagent == null) ? null : lastreagent.value;

    data["players"] = players.map((p) => p.toMap()).toList(growable:false);

    return data;
  }
}

class SaveGamePlayerRecord extends Player {

  SaveGamePlayerRecord({name, sex}) {
    this.name = name;
    this.sex = sex;
  }
  
  SaveGamePlayerRecord.fromMap(Map data) {
    dex = data["dex"];
    hp = data["hp"];
    hpMax = data["hpMax"];
    intel = data["intel"];
    mp = data["mp"];
    name = data["name"];
    sex = data["sex"];
    str = data["str"];
    unknown = data["unknown"];
    xp = data["xp"];    

    armourType = ArmourType.parse(data["armourType"]);
    characterClass = ClassType.parse(data["characterClass"]);
    status = StatusType.parse(data["status"]);
    weaponType = WeaponType.parse(data["weaponType"]);
}
  
  Map toMap() {
    var data = new Map();
    data["dex"] = dex;
    data["hp"] = hp;
    data["hpMax"] = hpMax;
    data["intel"] = intel;
    data["mp"] = mp;
    data["name"] = name;
    data["sex"] = sex;
    data["str"] = str;
    data["unknown"] = unknown;
    data["xp"] = xp;

    data["armourType"] = armourType.value;
    data["characterClass"] = characterClass.value;
    data["status"] = status.value;
    data["weaponType"] = weaponType.value;

    return data;
  }
}
