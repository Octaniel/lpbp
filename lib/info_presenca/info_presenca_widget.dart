import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPresencaWidget extends StatefulWidget {
  const InfoPresencaWidget({
    Key? key,
    this.id,
  }) : super(key: key);

  final int? id;

  @override
  _InfoPresencaWidgetState createState() => _InfoPresencaWidgetState();
}

class _InfoPresencaWidgetState extends State<InfoPresencaWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Informação da Presença',
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
          child: FutureBuilder<ApiCallResponse>(
            future: GetPresencaPorIdCall.call(
              id: widget.id,
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
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
              final listViewGetPresencaPorIdResponse = snapshot.data!;
              return ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  if (functions.podeApresentarVideoJustificando(
                      getJsonField(
                        listViewGetPresencaPorIdResponse.jsonBody,
                        r'''$.presente''',
                      ),
                      getJsonField(
                        listViewGetPresencaPorIdResponse.jsonBody,
                        r'''$.justificada''',
                      ),
                      getJsonField(
                        listViewGetPresencaPorIdResponse.jsonBody,
                        r'''$.nomeAudio''',
                      ).toString()))
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(50, 25, 50, 0),
                      child: FlutterFlowVideoPlayer(
                        path: functions.formatUrlUploadFile(getJsonField(
                          listViewGetPresencaPorIdResponse.jsonBody,
                          r'''$.nomeAudio''',
                        ).toString()),
                        videoType: VideoType.network,
                        autoPlay: false,
                        looping: true,
                        showControls: true,
                        allowFullScreen: true,
                        allowPlaybackSpeedMenu: false,
                      ),
                    ),
                  if (functions.podeApresentarFotoPresenca(
                      getJsonField(
                        listViewGetPresencaPorIdResponse.jsonBody,
                        r'''$.presente''',
                      ),
                      getJsonField(
                        listViewGetPresencaPorIdResponse.jsonBody,
                        r'''$.nomeFoto''',
                      ).toString()))
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(50, 25, 50, 0),
                      child: Image.network(
                        getJsonField(
                          listViewGetPresencaPorIdResponse.jsonBody,
                          r'''$.nomeFoto''',
                        ),
                        width: 100,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Presente? ',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            getJsonField(
                              listViewGetPresencaPorIdResponse.jsonBody,
                              r'''$.presente''',
                            ).toString(),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Justificado? ',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            getJsonField(
                              listViewGetPresencaPorIdResponse.jsonBody,
                              r'''$.justificada''',
                            ).toString(),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Aceito Por Gerente? ',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            getJsonField(
                              listViewGetPresencaPorIdResponse.jsonBody,
                              r'''$.justificacaoAceitoPorGerente''',
                            ).toString(),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Aceito Por Administrador? ',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            getJsonField(
                              listViewGetPresencaPorIdResponse.jsonBody,
                              r'''$.justificacaoAceitoPorAdministrador''',
                            ).toString(),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Data da Marcação? ',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            functions.formatDate(getJsonField(
                              listViewGetPresencaPorIdResponse.jsonBody,
                              r'''$.dataCriacao''',
                            ).toString()),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
