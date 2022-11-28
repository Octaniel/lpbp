import 'dart:collection';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';

class MarcacaoWidget extends StatefulWidget {
  const MarcacaoWidget({Key? key}) : super(key: key);

  @override
  _MarcacaoWidgetState createState() => _MarcacaoWidgetState();
}

class _MarcacaoWidgetState extends State<MarcacaoWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'textFieldOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: Offset(0, 20),
          end: Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: 1,
          end: 1,
        ),
      ],
    ),
  };
  bool isMediaUploading = false;
  String uploadedFileUrl = '';
  var selectedMedia;
  var box = new GetStorage();

  TextEditingController? seucodigoController;

  late bool seucodigoVisibility;
  var presencas = [];
  ApiCallResponse? apiResultkvw;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
    seucodigoController = TextEditingController();
    seucodigoVisibility = false;
  }

  @override
  Future<void> dispose() async {
    seucodigoController?.dispose();
    selectedMedia = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Marcação',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Color(0xFF57636C),
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: GetFuncionarioCall.call(),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData && !snapshot.hasError) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                      final listViewGetFuncionarioResponse = snapshot.hasData
                          ? snapshot.data?.jsonBody
                          : box.read('pessoas');
                      if (snapshot.hasData) {
                        box.write('pessoas', snapshot.data?.jsonBody);
                      }
                      return ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                Get.width * .2, 0, Get.width * .2, 0),
                            child: InkWell(
                              onTap: () async {
                                selectedMedia = await selectMedia(
                                  multiImage: false,
                                );
                                setState(() {});
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: selectedMedia != null
                                    ? Image.memory(selectedMedia.first.bytes)
                                    : Icon(Icons.camera_alt),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                Get.width * .2, 20, Get.width * .2, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                controller: seucodigoController,
                                obscureText: !seucodigoVisibility,
                                decoration: InputDecoration(
                                  labelText: 'Seu codigo',
                                  labelStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF0985A8),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF0985A8),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          20, 24, 20, 24),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => seucodigoVisibility =
                                          !seucodigoVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      seucodigoVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFF757575),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                keyboardType: TextInputType.number,
                              ),
                            ).animateOnPageLoad(
                                animationsMap['textFieldOnPageLoadAnimation']!),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                Get.width * .2, 25, Get.width * .2, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (selectedMedia == null) {
                                  showUploadMessage(
                                      context,
                                      'Por favor, tire uma foto!',
                                      Colors.redAccent);
                                } else if (functions.checarCodigoMarcacao(
                                    seucodigoController!.text,
                                    (GetFuncionarioCall.codigo(
                                      listViewGetFuncionarioResponse,
                                    ) as List)
                                        .map<String>((s) => s.toString())
                                        .toList())) {
                                  setState(() => isMediaUploading = true);

                                  var dateTime = DateTime.now();
                                  presencas.add({
                                    'urlFoto': selectedMedia.first.storagePath,
                                    'codigo': seucodigoController!.text,
                                    'presente': true,
                                    'bytes': selectedMedia.first.bytes,
                                    'data':
                                        '${dateTime.year}-${dateTime.month}-${dateTime.day}-${dateTime.hour}-${dateTime.minute}-${dateTime.second}'
                                  });
                                  await box.write('presencasTemp', presencas);
                                  showUploadMessage(
                                      context,
                                      'Marcacão registrada com sucesso!',
                                      Colors.orangeAccent);
                                  seucodigoController?.text = '';
                                  selectedMedia = null;
                                  return;
                                } else {
                                  showUploadMessage(
                                      context,
                                      'Não Existe Funcionario com este Codigo',
                                      Colors.redAccent);
                                  return;
                                }
                              },
                              text: 'MARCAR',
                              options: FFButtonOptions(
                                width: 20,
                                height: 50,
                                color: Color(0xFF0985A8),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
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
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
