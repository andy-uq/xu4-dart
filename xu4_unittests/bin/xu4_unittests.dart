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

void saveGame() {
  var saveGame = new SaveGame(new SaveGamePlayerRecord());
  print(JSON.encode(saveGame));
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
    expect(controller.init(loadStringTable), completes);
  });

  test('IntroController->showStory', () {
    var text = new List<String>();
    var imageWriter = new TestImageWriter();
    var controller = new IntroController();
    var story = controller.init(loadStringTable).then((_) => controller.beginStory((t) => text.add(t), imageWriter));
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
