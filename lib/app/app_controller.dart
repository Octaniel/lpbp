import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:lpbp/app/routes/app_routes.dart';

class AppController extends GetxController {
  final assetsAudioPlayer = AssetsAudioPlayer();

  AppController() {
    assetsAudioPlayer.open(
      Audio("assets/audio/1.mp3"),
      autoStart: false,
    );
    entrada();
    saida();
    momentoDeTocar();
  }

  tocarOuPausar() async {
   await assetsAudioPlayer.playOrPause();
  }

  parar() {
    assetsAudioPlayer.stop();
  }

  saida() async {
    while (true) {
      await Future.delayed(Duration(minutes: 1), () async {
        var dateTime = DateTime.now();
        var dateTime2 = DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day,
            13,
            30,
            dateTime.second,
            dateTime.millisecond,
            dateTime.microsecond);
        var dateTime3 = DateTime(dateTime.year, dateTime.month, dateTime.day,
            19, 0, dateTime.second, dateTime.millisecond, dateTime.microsecond);
        if (dateTime.isAtSameMomentAs(dateTime2) ||
            dateTime.isAtSameMomentAs(dateTime3)) {
          Get.offNamed(Routes.MARCAPONTO);
          tocarOuPausar();
          await Future.delayed(Duration(minutes: 2), () async {
            tocarOuPausar();
            await Future.delayed(Duration(minutes: 8), () {
              Get.offNamed(Routes.LISTAPRESENCA);
            });
          });
        }
      });
    }
  }

  entrada() async {
    while (true) {
      await Future.delayed(Duration(minutes: 1), () async {
        // tocarOuPausar();
        var dateTime = DateTime.now();
        var dateTime2 = DateTime(dateTime.year, dateTime.month, dateTime.day, 7,
            0, dateTime.second, dateTime.millisecond, dateTime.microsecond);
        var dateTime3 = DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day,
            13,
            30,
            dateTime.second,
            dateTime.millisecond,
            dateTime.microsecond);
        if (dateTime.isAtSameMomentAs(dateTime2) ||
            dateTime.isAtSameMomentAs(dateTime3)) {
          Get.offNamed(Routes.MARCAPONTO);
          tocarOuPausar();
          await Future.delayed(Duration(minutes: 2), () async {
            tocarOuPausar();
            await Future.delayed(Duration(minutes: 8), () {
              Get.offNamed(Routes.LISTAPRESENCA);
            });
          });
        }
      });
    }
  }

  momentoDeTocar() async {
    while (true) {
      await Future.delayed(Duration(minutes: 60), () async {
        var dateTime = DateTime.now();
        var add = DateTime(dateTime.year, dateTime.month, dateTime.day, 19, 1,
            dateTime.second, dateTime.millisecond, dateTime.microsecond);
        var subtract = DateTime(dateTime.year, dateTime.month, dateTime.day, 6,
            59, dateTime.second, dateTime.millisecond, dateTime.microsecond);
        if (dateTime.isBefore(add) && dateTime.isAfter(subtract)) {
          var random = Random();
          var nextInt = random.nextInt(61);
          await Future.delayed(Duration(minutes: nextInt), () async {
            Get.offNamed(Routes.MARCAPONTO);
            tocarOuPausar();
            await Future.delayed(Duration(minutes: 2), () async {
              tocarOuPausar();
              await Future.delayed(Duration(minutes: 8), () {
                Get.offNamed(Routes.LISTAPRESENCA);
              });
            });
          });
        }
      });
    }
  }

  @override
  void onClose() {
    print("object");
    super.onClose();
  }
}
