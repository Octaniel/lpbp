import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _accesstoken = prefs.getString('ff_accesstoken') ?? _accesstoken;
  }

  late SharedPreferences prefs;

  DateTime? dataNascimento = DateTime.fromMillisecondsSinceEpoch(1669378320000);

  String _accesstoken = '';
  String get accesstoken => _accesstoken;
  set accesstoken(String _value) {
    _accesstoken = _value;
    prefs.setString('ff_accesstoken', _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
