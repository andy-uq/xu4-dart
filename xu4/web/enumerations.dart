library enumerations;

class Reagent {
  static const Reagent REAG_ASH = const Reagent._("ash");
  static const Reagent REAG_GINSENG = const Reagent._("ginseng");
  static const Reagent REAG_GARLIC = const Reagent._("garlic");
  static const Reagent REAG_SILK = const Reagent._("silk");
  static const Reagent REAG_MOSS = const Reagent._("moss");
  static const Reagent REAG_PEARL = const Reagent._("pearl");
  static const Reagent REAG_NIGHTSHADE = const Reagent._("nightshade");
  static const Reagent REAG_MANDRAKE = const Reagent._("mandrake");

  static List<Reagent> get values => [REAG_ASH, REAG_GINSENG, REAG_GARLIC, REAG_SILK, REAG_MOSS, REAG_PEARL, REAG_NIGHTSHADE, REAG_MANDRAKE];

  final String value;

  const Reagent._(this.value);

  static Reagent parse(String value) {
    if (value == null) {
      return null;
    }

    return values.singleWhere((c) => c.value == value);
  }
}

class Spell {
  static List<Spell> get values => [];

  final String value;

  const Spell._(this.value);

  static Spell parse(String value) {
    if (value == null) {
      return null;
    }

    return values.singleWhere((c) => c.value == value);
  }
}

class Player {
  String name, sex;

  int hp = 0,
      hpMax = 0;
  int xp = 0;
  int str = 0,
      dex = 0,
      intel = 0;
  int mp = 0;
  int unknown = 0;

  WeaponType weaponType = WeaponType.WEAP_HANDS;
  ArmourType armourType = ArmourType.ARMR_NONE;
  ClassType characterClass = ClassType.Mage;
  StatusType status = StatusType.STAT_GOOD;
  
  int get level {
    return hpMax ~/ 100;
  }
  
  int get maxLevel {
    int level = 1;
    int next = 100;

    while (xp >= next && level < 8) {
        level++;
        next <<= 1;
    }

    return level;
  }
}

typedef int GetMaxMp(Player player);

class InitialClassValues {
  String name, sex;
  int level, xp;
  int str, dex, intel;

  WeaponType weaponType = WeaponType.WEAP_HANDS;
  ArmourType armourType = ArmourType.ARMR_NONE;

  int x, y;

  InitialClassValues.fromMap(Map data) {
    dex = data["dex"];
    intel = data["intel"];
    name = data["name"];
    sex = data["sex"];
    str = data["str"];
    xp = data["xp"];
    level = data["level"];

    armourType = ArmourType.parse(data["armourType"]);
    weaponType = WeaponType.parse(data["weaponType"]);
  }

  static Map<ClassType, InitialClassValues> classValues;

  static loadFromMap(Map data) {
    classValues = new Map.fromIterable(data.keys, key: (k) => ClassType.parse(k), value: (k) => new InitialClassValues.fromMap(data[k]));
  }
}

typedef void SetInitialPlayerStats(Player player);

class Virtue {
  static final Virtue Honesty = new Virtue("honesty", (p) {
    p.intel += 3;
  });

  static final Virtue Compassion = new Virtue("compassion", (p) {
    p.dex += 3;
  });

  static final Virtue Valor = new Virtue("valor", (p) {
    p.str += 3;
  });

  static final Virtue Justice = new Virtue("justice", (p) {
    p.intel++;
    p.dex++;
  });

  static final Virtue Sacrifice = new Virtue("sacrifice", (p) {
    p.dex++;
    p.str++;
  });

  static final Virtue Honour = new Virtue("honour", (p) {
    p.intel++;
    p.str++;
  });

  static final Virtue Spirituality = new Virtue("spirituality", (p) {
    p.intel++;
    p.str++;
    p.dex++;
  });

  static final Virtue Humility = new Virtue("humilty", (p) { /* no stats for you */ });

  static List<Virtue> get values => [Honesty, Compassion, Valor, Justice, Sacrifice, Honour, Spirituality, Humility];
  final String name;
  final SetInitialPlayerStats setInitialPlayerStats;

  Virtue(this.name, this.setInitialPlayerStats);

  static Virtue fromQuestionTree(int index) {
    return values[index];
  }

  static parse(String value) {
    return values.singleWhere((c) => c.name == value);
  }
}

class ClassType {
  static final Mage = new ClassType._("mage", (p) => p.intel * 2);
  static final Bard = new ClassType._("bard", (p) => p.intel);
  static final Fighter = new ClassType._("fighter", (p) => 0);
  static final Druid = new ClassType._("druid", (p) => p.intel * 3 ~/ 2);
  static final Tinker = new ClassType._("tinker", (p) => p.intel ~/ 2);
  static final Paladin = new ClassType._("paladin", (p) => p.intel);
  static final Ranger = new ClassType._("ranger", (p) => p.intel);
  static final Shepherd = new ClassType._("shepherd", (p) => 0);

  static List<ClassType> get values => [Mage, Bard, Fighter, Druid, Tinker, Paladin, Ranger, Shepherd];
  final String value;
  final GetMaxMp _getMaxMp;

  ClassType._(this.value, this._getMaxMp);

  int getMaxMp(Player player) {
    int mp = _getMaxMp(player);
    return mp > 99 ? 99 : mp;
  }

  static ClassType parse(String value) {
    return values.singleWhere((c) => c.value == value);
  }

  static ClassType fromQuestionTree(int index) {
    return values[index];
  }
}

class StatusType {
  static const STAT_GOOD = const StatusType._('G');
  static const STAT_POISONED = const StatusType._('P');
  static const STAT_SLEEPING = const StatusType._('S');
  static const STAT_DEAD = const StatusType._('D');

  static List<StatusType> get values => [STAT_GOOD, STAT_POISONED, STAT_SLEEPING, STAT_DEAD];

  final String value;

  const StatusType._(this.value);

  static StatusType parse(String value) {
    return values.singleWhere((c) => c.value == value);
  }
}

class ArmourType {

  static const ArmourType ARMR_NONE = const ArmourType._("none");
  static const ArmourType ARMR_CLOTH = const ArmourType._("cloth");
  static const ArmourType ARMR_LEATHER = const ArmourType._("leather");
  static const ArmourType ARMR_CHAIN = const ArmourType._("chain");
  static const ArmourType ARMR_PLATE = const ArmourType._("plate");
  static const ArmourType ARMR_MAGICCHAIN = const ArmourType._("magic_chain");
  static const ArmourType ARMR_MAGICPLATE = const ArmourType._("magic_plate");
  static const ArmourType ARMR_MYSTICROBES = const ArmourType._("mystic_robes");

  static List<ArmourType> get values => [ARMR_NONE, ARMR_CLOTH, ARMR_LEATHER, ARMR_CHAIN, ARMR_PLATE, ARMR_MAGICCHAIN, ARMR_MAGICPLATE, ARMR_MYSTICROBES];

  final String value;

  const ArmourType._(this.value);

  static ArmourType parse(String value) {
    return values.singleWhere((c) => c.value == value);
  }
}

class WeaponType {
  static const WEAP_HANDS = const WeaponType._("hands");
  static const WEAP_STAFF = const WeaponType._("staff");
  static const WEAP_DAGGER = const WeaponType._("dagger");
  static const WEAP_SLING = const WeaponType._("sling");
  static const WEAP_MACE = const WeaponType._("mace");
  static const WEAP_AXE = const WeaponType._("axe");
  static const WEAP_SWORD = const WeaponType._("sword");
  static const WEAP_BOW = const WeaponType._("bow");
  static const WEAP_CROSSBOW = const WeaponType._("xbow");
  static const WEAP_OIL = const WeaponType._("oil");
  static const WEAP_HALBERD = const WeaponType._("halberd");
  static const WEAP_MAGICAXE = const WeaponType._("magic_axe");
  static const WEAP_MAGICSWORD = const WeaponType._("magic_sword");
  static const WEAP_MAGICBOW = const WeaponType._("magic_bow");
  static const WEAP_MAGICWAND = const WeaponType._("wand");
  static const WEAP_MYSTICSWORD = const WeaponType._("mystic_sword");

  static List<WeaponType> get values => [WEAP_HANDS, WEAP_STAFF, WEAP_DAGGER, WEAP_SLING, WEAP_MACE, WEAP_AXE, WEAP_SWORD, WEAP_BOW, WEAP_CROSSBOW, WEAP_OIL, WEAP_HALBERD, WEAP_MAGICAXE, WEAP_MAGICSWORD, WEAP_MAGICBOW, WEAP_MAGICWAND, WEAP_MYSTICSWORD];

  final String value;

  const WeaponType._(this.value);

  static WeaponType parse(String value) {
    return values.singleWhere((c) => c.value == value);
  }
}
