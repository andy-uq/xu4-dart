library intro;

import 'dart:async';
import 'dart:math';
import 'dart:convert';

import '../enumerations.dart';
import '../savegame.dart';

typedef Future LoadStringTableAsync(String name);
typedef void ShowText(String text);

class Image {
  int width;
  int height;

  int origX;
  int origY;

  String name;

  Image(String this.name, int this.width, int this.height);

  Image.offset(String this.name, int this.width, int this.height, this.origX, this.origY) {
  }
}

abstract class ImageWriter {
  void Render(Image image);
  void RenderSubImage(Image image, int x, int y);
  void ResetImage();
}

class IntroBinData {
  List<String> introText, introQuestions, introGypsy;

  Future load(LoadStringTableAsync loadStringTable) {
    var introTextFuture = loadStringTable("introText").then((r) => introText = r);
    var introQuestionsFuture = loadStringTable("introQuestions").then((r) => introQuestions = r);
    var introGypsyFuture = loadStringTable("introGypsy").then((r) => introGypsy = r);
    return Future.wait([introTextFuture, introQuestionsFuture, introGypsyFuture]);
  }
}

class Story {
  List<String> _introText;
  ShowText _showText;
  ImageWriter _imageWriter;

  int _storyInd = 22;

  Story(this._introText, this._showText, this._imageWriter) {
    showNextPanel();
  }

  bool advance() {
    showNextPanel();
    return _storyInd < _introText.length;
  }

  Image _image(String name) {
    return new Image(name, 320, 152);
  }

  void showNextPanel() {
    if (_storyInd == 0) {
      _imageWriter.Render(_image("tree"));
    } else if (_storyInd == 3) {
      var overlay = new Image("tree", 24, 24);
      overlay.origX = 0;
      overlay.origY = 48;
      _imageWriter.Render(_image("tree"));
      _imageWriter.RenderSubImage(overlay, 72, 68);
    } else if (_storyInd == 5) {
      var overlay = new Image("tree", 24, 24);
      overlay.origX = -24;
      overlay.origY = 48;
      _imageWriter.Render(_image("tree"));
      _imageWriter.RenderSubImage(overlay, 72, 68);
    } else if (_storyInd == 6) {
      _imageWriter.Render(_image("portal"));
    } else if (_storyInd == 11) {
      _imageWriter.Render(_image("tree"));
    } else if (_storyInd == 15) {
      _imageWriter.Render(_image("outside"));
    } else if (_storyInd == 17) {
      _imageWriter.Render(_image("inside"));
    } else if (_storyInd == 20) {
      _imageWriter.Render(_image("wagon"));
    } else if (_storyInd == 21) {
      _imageWriter.Render(_image("gypsy"));
    } else if (_storyInd == 23) {
      _imageWriter.Render(_image("abacus"));
    }

    var storyText = _introText[_storyInd];
    _storyInd++;

    _showText(storyText);
  }
}

class Questions {
  int _questionRound = 0,
      _answerInd = 8;
  List<String> _questions, _gypsyText;
  List<int> _questionTree;
  ShowText _showText;
  ImageWriter _imageWriter;

  static const int GYP_PLACES_FIRST = 0;
  static const int GYP_PLACES_TWOMORE = 1;
  static const int GYP_PLACES_LAST = 2;
  static const int GYP_UPON_TABLE = 3;

  Questions(this._questions, this._gypsyText, this._showText, this._imageWriter) {
    _initQuestionTree();
    nextQuestion();
  }

  void _initQuestionTree() {
    _questionTree = new List<int>(15);
    var random = new Random();
    for (var i = 0; i < 8; i++) _questionTree[i] = i;

    for (var i = 0; i < 8; i++) {
      var r = random.nextInt(8);
      _swap(r, i);
    }

    if (_questionTree[0] > _questionTree[1]) {
      _swap(0, 1);
    }
  }

  void _swap(int left, int right) {
    var tmp = _questionTree[left];
    _questionTree[left] = _questionTree[right];
    _questionTree[right] = tmp;
  }

  bool answer(String answer) {
    if (answer == "a") {
      _questionTree[_answerInd] = _questionTree[_questionRound * 2];
    } else {
      _questionTree[_answerInd] = _questionTree[_questionRound * 2 + 1];
    }

    _drawAbacusBeads(_questionRound, _questionTree[_answerInd], _questionTree[_questionRound * 2 + ((answer == "b") ? 0 : 1)]);
    _answerInd++;
    _questionRound++;

    if (_questionRound > 6) {
      return true;
    }

    if (_questionTree[_questionRound * 2] > _questionTree[_questionRound * 2 + 1]) {
      _swap(_questionRound * 2, _questionRound * 2 + 1);
    }

    nextQuestion();
    return false;
  }

  void _drawCard(int leftCard, int rightCard) {
    var cardNames = ["honestycard", "compassioncard", "valorcard", "justicecard", "sacrificecard", "honorcard", "spiritualitycard", "humilitycard"];
    var height = 136;
    var width = 90;

    var origX_left = 12;
    var origX_right = 218;
    var origY = 12;

    var images = {
      "honestycard": new Image.offset("honcom", width, height, origX_left, origY),
      "compassioncard": new Image.offset("honcom", width, height, origX_right, origY),

      "valorcard": new Image.offset("valjus", width, height, origX_left, origY),
      "justicecard": new Image.offset("valjus", width, height, origX_right, origY),

      "sacrificecard": new Image.offset("sachonor", width, height, origX_left, origY),
      "honorcard": new Image.offset("sachonor", width, height, origX_right, origY),

      "spiritualitycard": new Image.offset("spirhum", width, height, origX_left, origY),
      "humilitycard": new Image.offset("spirhum", width, height, origX_right, origY),
    };

    _imageWriter.RenderSubImage(images[cardNames[leftCard]], 12, 12);
    _imageWriter.RenderSubImage(images[cardNames[rightCard]], 218, 12);
  }

  void _drawAbacusBeads(int row, int selectedVirtue, int rejectedVirtue) {
    _imageWriter.RenderSubImage(new Image.offset("../intro/abacus", 8, 12, 8, 187), 128 + (selectedVirtue * 9), 24 + (row * 15));
    _imageWriter.RenderSubImage(new Image.offset("../intro/abacus", 8, 12, 24, 187), 128 + (rejectedVirtue * 9), 24 + (row * 15));
  }

  void nextQuestion() {
    var text = _gypsyText[_questionRound == 0 ? GYP_PLACES_FIRST : (_questionRound == 6 ? GYP_PLACES_LAST : GYP_PLACES_TWOMORE)];
    var uponTable = _gypsyText[GYP_UPON_TABLE];
    var left = _questionTree[_questionRound * 2];
    var right = _questionTree[_questionRound * 2 + 1];
    var a = _gypsyText[4 + left];
    var b = _gypsyText[4 + right];
    var question = _getQuestion(left, right);

    _showText('$text $uponTable $a and $b. She says Consider this: $question');
    _drawCard(left, right);
  }

  String _getQuestion(int left, int right) {
    int i = 0;
    int d = 7;

    assert(left < right); // "first virtue must be smaller (v1 = %d, v2 = %d)", v1, v2);

    while (left > 0) {
      i += d;
      d--;
      left--;
      right--;
    }

    return _questions[i + right - 1];
  }
}

class IntroController {
  IntroBinData _introBinData = new IntroBinData();
  Questions _questions;
  String _name, _sex;

  Future init(LoadStringTableAsync loadStringTable) {
    return _introBinData.load(loadStringTable);
  }

  Questions beginQuestions(ShowText showText, ImageWriter imageWriter) {
    _questions = new Questions(_introBinData.introQuestions, _introBinData.introGypsy, showText, imageWriter);
    return _questions;
  }

  Story beginStory(ShowText showText, ImageWriter imageWriter) {
    return new Story(_introBinData.introText, showText, imageWriter);
  }

  void save(Store store) {
    var avatar = new SaveGamePlayerRecord(name:_name, sex:_sex);
    SaveGame saveGame = new SaveGame(avatar);

    store.write("party.sav", JSON.encode(saveGame));
  }

  Future queryNameAndSex(NameAndSex nameAndSex) {
    var query = new QueryNameAndSex(nameAndSex);
    var future = query.getNameAndSex().then((_) {
      _name = query.name;
      _sex = query.sex;
    });
    return future;
  }
}

abstract class Store {
  void write(String name, String value);
}

typedef SetNameAndSex(String name, String sex);

abstract class NameAndSex {
  setHandler(SetNameAndSex handler);
}

class QueryNameAndSex {
  Completer _completer = new Completer();
  String name, sex;

  QueryNameAndSex(NameAndSex nameAndSex) {
    nameAndSex.setHandler(this.setNameAndSex);
  }

  Future getNameAndSex() {
    return _completer.future;
  }

  setNameAndSex(String name, String sex) {
    this.name = name;
    this.sex = sex;
    _completer.complete(this);
  }
}
