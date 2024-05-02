///////////////////////////
// Helper functions
///////////////////////////
Map<String, dynamic> hiveObjectConvertorToMap(dynamic hiveObject) {
  Map<String, dynamic> map = {};
  for (var key in hiveObject.keys) {
    map[key.toString()] = hiveObject[key]; // Convert keys to strings
  }
  return map;
}
