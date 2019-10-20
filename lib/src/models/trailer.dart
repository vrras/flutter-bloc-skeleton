class Trailer {
  int _id;
  List<_Result> _results = [];

  Trailer.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    List<_Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<_Result> get results => _results;

  int get id => _id;
}

class _Result {
  String _id;
  String _iso6391;
  String _iso31661;
  String _key;
  String _name;
  String _site;
  int _size;
  String _type;

  _Result(result) {
    _id = result['id'];
    _iso6391 = result['iso_639_1'];
    _iso31661 = result['iso_3166_1'];
    _key = result['key'];
    _name = result['name'];
    _site = result['site'];
    _size = result['size'];
    _type = result['type'];
  }

  String get id => _id;

  String get iso6391 => _iso6391;
  
  String get iso31661 => _iso31661;
  
  String get key => _key;
  
  String get name => _name;
  
  String get site => _site;
  
  int get size => _size;
  
  String get type => _type;
}
