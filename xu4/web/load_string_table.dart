part of xu4;

Future<List<String>> loadStringTableAsync(String name) {
  var url = 'intro/$name.json';
  return HttpRequest.getString(url).then((data) {
    List<String> result = JSON.decode(data);
    return result;
  });
}