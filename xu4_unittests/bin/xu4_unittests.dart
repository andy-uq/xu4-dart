import 'dart:async';
import 'dart:convert';
import 'package:unittest/unittest.dart';
import '../../xu4/web/intro/introcontroller.dart';
import '../../xu4/web/savegame.dart';

void main() {
  story();
  introBinData();
  introController();
  saveGame();
}

class obj { 
//  var x = [1,2,3];
//  var y = 'a'; 
//z = new Map.fromIterable([1, 2, 3], key: (k) => k, value: (v) => v.toString()); 
}

void saveGame() {
  var player = new SaveGamePlayerRecord(name:'andy', sex:'m');
  print(JSON.encode(new List.filled(10, player).map((f) => f.toMap()).toList()));
  
  var p2 = new SaveGamePlayerRecord.fromMap(player.toMap());
  test('Can deserialise player', () {
    expect(p2.name, equals(player.name));
    expect(p2.sex, equals(player.sex));
    expect(p2.characterClass, equals(player.characterClass));
  });
  
  var saveGame = new SaveGame(player);
  print(saveGame.toJson());
  var s2 = new SaveGame.fromMap(saveGame.toMap());
  test('Can deserialise save game', () {
    expect(s2.karma[0], equals(saveGame.karma[0]));
    expect(s2.players[0].name, equals(player.name));
    expect(s2.players[0].sex, equals(player.sex));
  });
}

class TestImageWriter implements ImageWriter {

  @override
  void Render(Image image) {
    // TODO: implement Render
  }

  @override
  void RenderSubImage(Image image, int x, int y) {
    // TODO: implement RenderSubImage
  }

  @override
  void ResetImage() {
    // TODO: implement ResetImage
  }
}

void introController() {
  LoadStringTableAsync loadStringTable = (n) => new Future(() => new List<String>(24));

  test('IntroController->init', () {
    var controller = new IntroController();
    expect(controller.init(loadStringTable, () => new Future(() => 0)), completes);
  });

  test('IntroController->showStory', () {
    var text = new List<String>();
    var imageWriter = new TestImageWriter();
    var controller = new IntroController();
    var story = controller.init(loadStringTable, () => new Future(() => 0)).then((_) => controller.beginStory((t) => text.add(t), imageWriter));
    expect(story, completes);
  });
}

void story() {
  test('Story', () {
    var text = new List<String>();
    var story = new Story(['a', 'b', 'c'], (t) => text.add(t), new TestImageWriter());
    expect(text.length, equals(1)); // a
    expect(story.advance(), equals(true)); // b
    expect(story.advance(), equals(false)); // c
  });
}

void introBinData() {
  LoadStringTableAsync loadStringTable = (n) => new Future(() => [n]);
  IntroBinData introBinData = new IntroBinData();

  test('IntroBinData->load', () {
    var load = introBinData.load(loadStringTable).then((_) {
      expect(introBinData.introText, equals(['introText']));
      expect(introBinData.introQuestions, equals(['introQuestions']));
      expect(introBinData.introGypsy, equals(['introGypsy']));
    });
    expect(load, completes);
  });
}
