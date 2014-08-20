library xu4;

import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'intro/introcontroller.dart';

part 'load_string_table.dart';

IntroController controller = new IntroController();

void _showText(text) {
  querySelector('#intro p').text = text;
}

class HtmlImageWriter implements ImageWriter {
  DivElement img;
  Function _formatUrl;

  HtmlImageWriter(String selector, this._formatUrl) {
    img = querySelector(selector) as DivElement;
  }

  void _setBackground(Image image, Element img) {
    img.style.backgroundImage = _formatUrl(image.name);
    img.style.width = '${image.width}px';
    img.style.height = '${image.height}px';
  }

  @override
  void Render(Image image) {
    ResetImage();
    _setBackground(image, img);
  }

  @override
  void RenderSubImage(Image image, int x, int y) {
    var overlay = new SpanElement();
    overlay.style.position = 'absolute';
    overlay.style.display = 'inline-block';
    overlay.style.left = '${x}px';
    overlay.style.top = '${y}px';
    overlay.style.backgroundPosition = '-${image.origX}px -${image.origY}px';
    _setBackground(image, overlay);
    img.children.add(overlay);
  }

  @override
  void ResetImage() {
    img.children.clear();
  }
}

void setupStoryAndQuestions(Story story) {
  var nextButton = querySelector('#intro button.next');
  var answers = querySelector('#answer');

  var answerQuestion = (questions, id) {
    if (questions.answer(id)) {
      answers.hidden = true;
      querySelector('#intro p').hidden = true;
      controller.save();
    }
  };

  var advance = (_) {
    if (!story.advance()) {
      nextButton.hidden = true;
      var questions = controller.beginQuestions(_showText, new HtmlImageWriter("#intro div.image", (n) => "url('images/cards/${n}.png')"));
      querySelectorAll('#answer button').onClick.listen((e) => answerQuestion(questions, e.target.id));
      answers.hidden = false;
    }
  };

  nextButton.onClick.listen(advance);
  querySelector('#intro').hidden = false;
}

void main() {
  controller.init(loadStringTableAsync).then((_) => controller.queryNameAndSex(new NameAndSexForm())).then((_) => setupStoryAndQuestions(controller.beginStory(_showText, new HtmlImageWriter("#intro div.image", (n) => "url('images/intro/${n}.png')"))));
}

class NameAndSexForm implements NameAndSex {
  SetNameAndSex _handler;

  NameAndSexForm() {
    querySelector('#name-and-sex button.next').onClick.listen((_) => onNext());
  }

  String get _name => (querySelector('#name') as InputElement).value;
  String get _sex => querySelectorAll('#sex input').map((e) => e as InputElement).firstWhere((e) => e.checked).value;

  @override
  setHandler(SetNameAndSex handler) {
    _handler = handler;
  }

  onNext() {
    querySelector('#name-and-sex').hidden = true;
    _handler(_name, _sex);
  }
}
