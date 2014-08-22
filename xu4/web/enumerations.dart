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

  static get values => [REAG_ASH, REAG_GINSENG, REAG_GARLIC, REAG_SILK, REAG_MOSS, REAG_PEARL, REAG_NIGHTSHADE, REAG_MANDRAKE];

  final String value;

  const Reagent._(this.value);
}

class Spell {
  static get values => [];
}

class ClassType {
  static const CLASS_MAGE = const ClassType._("mage");
  static const CLASS_BARD = const ClassType._("bard");
  static const CLASS_FIGHTER = const ClassType._("fighter");
  static const CLASS_DRUID = const ClassType._("druid");
  static const CLASS_TINKER = const ClassType._("tinker");
  static const CLASS_PALADIN = const ClassType._("paladin");
  static const CLASS_RANGER = const ClassType._("ranger");
  static const CLASS_SHEPHERD = const ClassType._("shepherd");

  final String value;

  const ClassType._(this.value);
}

class StatusType {
  static const STAT_GOOD = const StatusType._('G');
  static const STAT_POISONED = const StatusType._('P');
  static const STAT_SLEEPING = const StatusType._('S');
  static const STAT_DEAD = const StatusType._('D');

  static get values => [STAT_GOOD, STAT_POISONED, STAT_SLEEPING, STAT_DEAD];

  final String value;

  const StatusType._(this.value);
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
}