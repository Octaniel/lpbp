import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class CriarFuncionarioWidget extends StatefulWidget {
  const CriarFuncionarioWidget({
    Key? key,
    this.id,
  }) : super(key: key);

  final int? id;

  @override
  _CriarFuncionarioWidgetState createState() => _CriarFuncionarioWidgetState();
}

class _CriarFuncionarioWidgetState extends State<CriarFuncionarioWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'textFieldOnPageLoadAnimation1': AnimationInfo(
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
    'textFieldOnPageLoadAnimation2': AnimationInfo(
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
    'textFieldOnPageLoadAnimation3': AnimationInfo(
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
    'textFieldOnPageLoadAnimation4': AnimationInfo(
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
    'textFieldOnPageLoadAnimation5': AnimationInfo(
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
    'textFieldOnPageLoadAnimation6': AnimationInfo(
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
    'textFieldOnPageLoadAnimation7': AnimationInfo(
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
  ApiCallResponse? apiResultlvg;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ApiCallResponse? apiResultm19;
  DateTime? datePicked;
  String? dropDownValue;
  TextEditingController? nomeUsuarioController;
  TextEditingController? apelidoController;
  TextEditingController? nomeController;
  TextEditingController? emailController;
  TextEditingController? moradaController;
  TextEditingController? telefoneController;
  TextEditingController? senhaController;

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

    apelidoController = TextEditingController();
    nomeController = TextEditingController();
    emailController = TextEditingController();
    moradaController = TextEditingController();
    telefoneController = TextEditingController();
    nomeUsuarioController = TextEditingController();
    senhaController = TextEditingController();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    apelidoController?.dispose();
    nomeController?.dispose();
    emailController?.dispose();
    moradaController?.dispose();
    telefoneController?.dispose();
    nomeUsuarioController?.dispose();
    senhaController?.dispose();
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
          'Registar Funcionario',
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
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextFormField(
                                  controller: nomeController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Nome',
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
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Preencha o nome';
                                    }

                                    if (val.length < 3) {
                                      return 'Nome deve ter mais de 2 caracteres';
                                    }

                                    return null;
                                  },
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'textFieldOnPageLoadAnimation1']!),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextFormField(
                                  controller: apelidoController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Apelido',
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
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Preencha o apelido';
                                    }

                                    if (val.length < 3) {
                                      return 'Apelido deve ter mais de 2 caracteres';
                                    }

                                    return null;
                                  },
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'textFieldOnPageLoadAnimation2']!),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: TextFormField(
                                    controller: emailController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
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
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Preencha o email';
                                      }

                                      if (val.length < 5) {
                                        return 'Email deve ter mais de 4 caracteres';
                                      }

                                      if (!RegExp(kTextValidatorEmailRegex)
                                          .hasMatch(val)) {
                                        return 'Email Invalido';
                                      }
                                      return null;
                                    },
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'textFieldOnPageLoadAnimation3']!),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: TextFormField(
                                    controller: moradaController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Morada',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
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
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Preenche a Morada';
                                      }

                                      if (val.length < 3) {
                                        return 'Morada deve ter mais de 2 caracteres';
                                      }

                                      return null;
                                    },
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'textFieldOnPageLoadAnimation4']!),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: TextFormField(
                                    controller: telefoneController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Telefone',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
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
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Preencha o Telefone';
                                      }

                                      if (val.length < 7) {
                                        return 'Telefone deve ter mais de 6 caracteres';
                                      }

                                      return null;
                                    },
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'textFieldOnPageLoadAnimation5']!),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: InkWell(
                                onTap: () async {
                                  if (kIsWeb) {
                                    final _datePickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: FFAppState().dataNascimento!,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2050),
                                    );

                                    if (_datePickedDate != null) {
                                      setState(
                                        () => datePicked = DateTime(
                                          _datePickedDate.year,
                                          _datePickedDate.month,
                                          _datePickedDate.day,
                                        ),
                                      );
                                    }
                                  } else {
                                    await DatePicker.showDatePicker(
                                      context,
                                      showTitleActions: true,
                                      onConfirm: (date) {
                                        setState(() => datePicked = date);
                                      },
                                      currentTime: FFAppState().dataNascimento!,
                                      minTime: DateTime(0, 0, 0),
                                    );
                                  }

                                  setState(() =>
                                      FFAppState().dataNascimento = datePicked);
                                },
                                child: Text(
                                  valueOrDefault<String>(
                                    dateTimeFormat('d/M/y', datePicked),
                                    'Data Nascimento',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: FlutterFlowDropDown<String>(
                                options: ['MANHA', 'TARDE', 'FERIA'],
                                onChanged: (val) =>
                                    setState(() => dropDownValue = val),
                                width: 180,
                                height: 50,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                hintText: 'Selecione o turno',
                                fillColor: Colors.white,
                                elevation: 2,
                                borderColor: Color(0xFF0985A8),
                                borderWidth: 0,
                                borderRadius: 10,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: TextFormField(
                                    controller: nomeUsuarioController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Nome Usuario',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
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
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Preencha o nome usuario';
                                      }

                                      if (val.length < 3) {
                                        return 'Nome usuario deve ter mais de 2 caracteres';
                                      }

                                      if (!RegExp(kTextValidatorUsernameRegex)
                                          .hasMatch(val)) {
                                        return 'Nome de usuario invalido';
                                      }
                                      return null;
                                    },
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'textFieldOnPageLoadAnimation6']!),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 800, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: TextFormField(
                                    controller: senhaController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Senha',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
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
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Preencha a Senha';
                                      }

                                      if (val.length < 7) {
                                        return 'Senha deve ter mais de 6 caracteres';
                                      }

                                      return null;
                                    },
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'textFieldOnPageLoadAnimation7']!),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  var _shouldSetState = false;
                                  if (formKey.currentState == null ||
                                      !formKey.currentState!.validate()) {
                                    return;
                                  }

                                  if (dropDownValue == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Selecione o turno',
                                          style: TextStyle(),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: Color(0x00000000),
                                      ),
                                    );
                                    return;
                                  }
                                  if (datePicked == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Preencha a data de nascimento',
                                          style: TextStyle(),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: Color(0x00000000),
                                      ),
                                    );
                                    return;
                                  }

                                  apiResultm19 = await AdicionarPessoaCall.call(
                                    nomeUs: nomeUsuarioController!.text,
                                    senha: senhaController!.text,
                                    tipo: 'Vendendor',
                                    nomePes: nomeController!.text,
                                    apelido: apelidoController!.text,
                                    email: emailController!.text,
                                    morada: moradaController!.text,
                                    telemovel: telefoneController!.text,
                                    dataNascimento:
                                        functions.formatDateParaBack(
                                            datePicked?.toString()),
                                    turno: dropDownValue,
                                    acessToken: FFAppState().accesstoken,
                                  );
                                  _shouldSetState = true;
                                  if ((apiResultm19?.succeeded ?? true)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Funcionario registado com sucesso',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryColor,
                                      ),
                                    );
                                    setState(() {
                                      nomeController?.clear();
                                      apelidoController?.clear();
                                      emailController?.clear();
                                      moradaController?.clear();
                                      telefoneController?.clear();
                                      nomeUsuarioController?.clear();
                                      senhaController?.clear();
                                    });
                                    if (_shouldSetState) setState(() {});
                                    return;
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          getJsonField(
                                            (apiResultm19?.jsonBody ?? ''),
                                            r'''$[0].mensagemUsuario''',
                                          ).toString(),
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                      ),
                                    );
                                    if (_shouldSetState) setState(() {});
                                    return;
                                  }

                                  if (_shouldSetState) setState(() {});
                                },
                                text: 'Registar',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 50,
                                  color: Color(0xFF0985A8),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                  elevation: 10,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
