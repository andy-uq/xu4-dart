library savegame;

import 'enumerations.dart';

class SaveGame {
  int unknown1 = 0;
  int moves = 0;

  List<SaveGamePlayerRecord> players = new List.generate(8, (_) => new SaveGamePlayerRecord());

  int food = 0;

  int gold = 0;
  List<int> karma = new List.filled(8, 20);
  int torches = 0;
  int gems = 0;
  int keys = 0;
  int sextants = 0;
  Map<String, int> armr = new Map.fromIterable(ArmourType.values, key: (k) => k.value, value: (v) => 0);
  Map<String, int> weapons = new Map.fromIterable(WeaponType.values, key: (k) => k.value, value: (v) => 0);
  Map<String, int> reagents = new Map.fromIterable(Reagent.values, key: (k) => k.value, value: (v) => 0);
  Map<String, int> mixtures = new Map.fromIterable(Spell.values, key: (k) => k.value, value: (v) => 0);
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
  int lastreagent = 0;
  int lastmeditation = 0;
  int lastvirtue = 0;
  int dngx = 0,
      dngy = 0;
  int orientation = 0;
  int dnglevel = 0xffff;
  int location = 0;

  SaveGame(SaveGamePlayerRecord avatar) {
    players[0] = avatar;
  }
}

class SaveGamePlayerRecord {
  String name, sex;

  int hp = 0,
      hpMax = 0;
  int xp = 0;
  int str = 0,
      dex = 0,
      intel = 0;
  int mp = 0;
  int unknown = 0;

  String weaponType = WeaponType.WEAP_HANDS.value;
  String armourType = ArmourType.ARMR_NONE.value;
  String characterClass = ClassType.CLASS_MAGE.value;
  String status = StatusType.STAT_GOOD.value;

  SaveGamePlayerRecord({name, sex}) {
    this.name = name;
    this.sex = sex;
  }
}
