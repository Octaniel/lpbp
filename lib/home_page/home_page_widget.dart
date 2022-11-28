import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  var box = new GetStorage();

  @override
  void initState() {
    super.initState();
    var rng = Random();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      var nextInt = rng.nextInt(60);
      while (true) {
        var nextInt = rng.nextInt(60);
        await Future.delayed(Duration(seconds: nextInt + 60), () async {
          await assetsAudioPlayer.open(
            Audio("assets/audios/1.mp3"),
            autoStart: false,
          );
          await assetsAudioPlayer.play();
          context.pushNamed('marcacao');
          await Future.delayed(Duration(seconds: 30), () async {
            await assetsAudioPlayer.pause();
          });
          await Future.delayed(Duration(minutes: 1), () async {
            var read = box.read('presencas');
            List<dynamic> pessoas = box.read('pessoas');
            List<dynamic> presencas = box.read('presencasTemp');
            var list = presencas.map((e) => e['codigo']).toList();
            var list2 = pessoas
                .where((element) => !list.contains(element['codigo']))
                .map((e) => e['codigo'])
                .toList();
            var dateTime = DateTime.now();
            list2.forEach((element) {
              presencas.add({
                'codigo': element,
                'presente': false,
                'data':
                '${dateTime.year}-${dateTime.month}-${dateTime.day}-${dateTime
                    .hour}-${dateTime.minute}-${dateTime.second}'
              });
            });

            if (read == null) {
              read = presencas;
            } else {
              read.addAll(presencas);
            }
            await box.write('presencas', read);
            await box.write('presencasTemp', []);
            if (await functions.checkInternetConnection()) {
              await functions.savePresentcaOffline();
            }
          });
          context.pop();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      //event.complete(event.notification);
      context.pushNamed('marcacao');
    });
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      context.pushNamed('marcacao');
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Material(
              color: Colors.transparent,
              elevation: 20,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(100, 100, 100, 50),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed('listafuncionario');
                          },
                          text: 'STATUS',
                          options: FFButtonOptions(
                            width: 130,
                            height: 50,
                            color: Color(0xFF0985A8),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                            elevation: 20,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                     /* Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () {
                          },
                          text: 'ATUALIZAR',
                          options: FFButtonOptions(
                            width: 130,
                            height: 50,
                            color: Color(0xFF0985A8),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                            elevation: 20,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed('marcacao');
                          },
                          text: 'COMUNICAR',
                          options: FFButtonOptions(
                            width: 130,
                            height: 50,
                            color: Color(0xFF0985A8),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                            elevation: 20,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
