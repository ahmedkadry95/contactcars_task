import 'package:contactcars_task/core/constants/strings/constant_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Box? popularMoviesBox;

openHiveBox() async {
  if (!Hive.isBoxOpen(AppStrings.popularMoviesBoxDB)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    popularMoviesBox = await Hive.openBox(AppStrings.popularMoviesBoxDB);
    debugPrint('hiveBox state : ${popularMoviesBox!.isOpen}');
  } else {
    debugPrint('hiveBox state :already  ${popularMoviesBox!.isOpen}');
  }
}
