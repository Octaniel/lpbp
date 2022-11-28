import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class PresencaWidget extends StatefulWidget {
  const PresencaWidget({
    Key? key,
    this.presen,
  }) : super(key: key);

  final int? presen;

  @override
  _PresencaWidgetState createState() => _PresencaWidgetState();
}

class _PresencaWidgetState extends State<PresencaWidget> {
  ApiCallResponse? apiResultlvg;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      apiResultlvg = await CheckTokenCall.call(
        acessToken: FFAppState().accesstoken,
      );
      if ((apiResultlvg?.succeeded ?? true)) {
        return;
      }

      context.goNamed(
        'login',
        extra: <String, dynamic>{
          kTransitionInfoKey: TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.topToBottom,
          ),
        },
      );

      return;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Presenças',
          style: FlutterFlowTheme.of(context).title2,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: FutureBuilder<ApiCallResponse>(
          future: GetPresencaPorIdFuncionarioCall.call(
            idPessoa: widget.presen,
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
            final listViewGetPresencaPorIdFuncionarioResponse = snapshot.data!;
            return Builder(
              builder: (context) {
                final listPresenca = getJsonField(
                  listViewGetPresencaPorIdFuncionarioResponse.jsonBody,
                  r'''$''',
                ).toList();
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: listPresenca.length,
                  itemBuilder: (context, listPresencaIndex) {
                    final listPresencaItem = listPresenca[listPresencaIndex];
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                      child: InkWell(
                        onTap: () async {
                          context.pushNamed(
                            'infoPresenca',
                            queryParams: {
                              'id': serializeParam(
                                getJsonField(
                                  listPresencaItem,
                                  r'''$.id''',
                                ),
                                ParamType.int,
                              ),
                            }.withoutNulls,
                          );
                        },
                        onLongPress: () async {
                          context.pushNamed(
                            'Justificar',
                            queryParams: {
                              'id': serializeParam(
                                getJsonField(
                                  listPresencaItem,
                                  r'''$.id''',
                                ),
                                ParamType.int,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0,
                                color: FlutterFlowTheme.of(context).lineColor,
                                offset: Offset(0, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 4,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: functions
                                        .getColorByPresente(getJsonField(
                                      listPresencaItem,
                                      r'''$.presente''',
                                    )),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Text(
                                      functions
                                          .presencaBoleanToString(getJsonField(
                                        listPresencaItem,
                                        r'''$.presente''',
                                      )),
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Text(
                                    functions.formatDate(getJsonField(
                                      listPresencaItem,
                                      r'''$.dataCriacao''',
                                    ).toString()),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
