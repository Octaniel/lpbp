import 'package:audioplayers/audioplayers.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lpbp/app/app_controller.dart';
import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/data/model/usuario.dart';
import 'package:lpbp/app/data/repository/auth_repository.dart';
import 'package:lpbp/app/data/repository/presenca_repository.dart';
import 'package:lpbp/app/data/repository/seguranca_repository.dart';
import 'package:lpbp/app/widgets/share_js.dart';
import 'package:progress_state_button/progress_button.dart';

class HomeController extends GetxController {
  final repository = SegurancaRepository();
  final repositoryPresenca = PresencaRepository();
  final repositoryAuth = AuthRepository();
  final pikedDate = DateTime.now().obs;
  final timeOfDayStar = TimeOfDay.now().obs;
  final timeOfDayEnd = TimeOfDay.now().obs;
  final _empregados = <Usuario>[].obs;
  final _audio = ''.obs;
  final _presenca = Presenca().obs;
  final _boxShadow = true.obs;
  final _isPlay = false.obs;
  final _circularProgressButaoRegistrar = false.obs;
  var pessoa = Pessoa();
  var presencaa = Presenca();
  var usuario = Usuario();
  final _pauseGrav = false.obs;
  AudioPlayer audioPlayer = AudioPlayer();
  final _gravando = false.obs;
  final refres = "".obs;

  final _buttonState = ButtonState.idle.obs;

  get buttonState => _buttonState.value;

  set buttonState(ButtonState buttonStates) {
    _buttonState.value = buttonStates;
    refres.value = refres.value + "g";
    update(['buttonState']);
  }

  get gravando => _gravando.value;

  set gravando(value) {
    _gravando.value = value;
    update(['gravando']);
  }

  get pauseGrav => _pauseGrav.value;

  set pauseGrav(value) {
    _pauseGrav.value = value;
    update(['playReplay']);
  }

  get circularProgressButaoRegistrar => _circularProgressButaoRegistrar.value;

  set circularProgressButaoRegistrar(value) {
    _circularProgressButaoRegistrar.value = value;
  }

  void updat(String id) {
    update([id]);
  }

  bool get isPlay => _isPlay.value;

  set isPlay(bool value) {
    _isPlay.value = value;
    update(['isPlay', 'playReplay']);
  }

  bool get boxShadow => _boxShadow.value;

  set boxShadow(bool value) {
    _boxShadow.value = value;
    update(['boxShadow']);
  }

  Presenca get presenca => _presenca.value;

  set presenca(Presenca value) {
    _presenca.value = value;
  }

  String get audio => _audio.value;

  set audio(String value) {
    _audio.value = value;
    update(['playReplay']);
  }

  HomeController() {
    listarEmpregados();
  }

  // ignore: invalid_use_of_protected_member
  // List<Usuario> get empregados => _empregados.value;
  //
  // set empregados(List<Usuario> value) {
  //   _empregados.assignAll(value);
  // }

  listarEmpregados() async {
    // empregados = Get.find<AppController>().empregados;
    update(['pontos', 'infoPresenca']);
  }

  Future<bool> salvarUsuario() async {
    if (pessoa.turno == null || pessoa.turno == 'Manhã')
      pessoa.turno = 'MANHA';
    else if (pessoa.turno == 'Tarde')
      pessoa.turno = 'TARDE';
    else
      pessoa.turno = 'FERIA';
    if (usuario.tipo == null) usuario.tipo = 'Vendedor';
    usuario.pessoa = pessoa;
    usuario.nome = pessoa.nome.toLowerCase().trim();
    return await repository.add(usuario);
  }

  Future<void> atualizarPresenca(Presenca presenca) async {
    await repositoryPresenca.atualizar(presenca);
    await Get.find<AppController>().listarEmpregados();
  }

  Future<bool> registar() async {
    return await repositoryAuth.registar();
  }

  Future<bool> setarTodosAsPresencasParaPresenteEntre(
      String de, String ate) async {
    return await repositoryAuth.setarTodosAsPresencasParaPresenteEntre(de, ate);
  }

  Future<void> gerarExcel() async {
    final f = new DateFormat('dd/MM/yyyy HH:mm');
    var presencaResumo = await repositoryPresenca.getPresencaResumo(
        "2010-01-01'T'01:01:01", "2050-01-01'T'01:01:01");
    CellStyle cellStyle = CellStyle(
        fontSize: 12, bold: true, fontFamily: getFontFamily(FontFamily.Arial));
    CellStyle cellStyleb1 = CellStyle(
        fontColorHex: "#d0170d",
        fontSize: 12,
        bold: true,
        fontFamily: getFontFamily(FontFamily.Arial));
    CellStyle cellStylec1 = CellStyle(
        fontColorHex: "#d0790d",
        fontSize: 12,
        bold: true,
        fontFamily: getFontFamily(FontFamily.Arial));
    CellStyle cellStyled1 = CellStyle(
        fontColorHex: "#69920f",
        fontSize: 12,
        bold: true,
        fontFamily: getFontFamily(FontFamily.Arial));
    CellStyle cellStylee1 = CellStyle(
        fontColorHex: "#169412",
        fontSize: 12,
        bold: true,
        fontFamily: getFontFamily(FontFamily.Arial));

    CellStyle cellStylea =
        CellStyle(fontSize: 10, fontFamily: getFontFamily(FontFamily.Arial));
    CellStyle cellStyleb = CellStyle(
        fontColorHex: "#d0170d",
        fontSize: 10,
        fontFamily: getFontFamily(FontFamily.Arial));
    CellStyle cellStylec = CellStyle(
        fontColorHex: "#d0790d",
        fontSize: 10,
        fontFamily: getFontFamily(FontFamily.Arial));
    CellStyle cellStyled = CellStyle(
        fontColorHex: "#69920f",
        fontSize: 10,
        fontFamily: getFontFamily(FontFamily.Arial));
    CellStyle cellStylee = CellStyle(
        fontColorHex: "#169412",
        fontSize: 10,
        fontFamily: getFontFamily(FontFamily.Arial));

    var excel = Excel.createExcel();
    Sheet sheetObject = excel['folha1'];
    var cella1 = sheetObject.cell(CellIndex.indexByString("A1"));
    cella1.cellStyle = cellStyle;
    var cellb1 = sheetObject.cell(CellIndex.indexByString("B1"));
    cellb1.cellStyle = cellStyleb1;
    var cellc1 = sheetObject.cell(CellIndex.indexByString("C1"));
    cellc1.cellStyle = cellStylec1;
    var celld1 = sheetObject.cell(CellIndex.indexByString("D1"));
    celld1.cellStyle = cellStyled1;
    var celle1 = sheetObject.cell(CellIndex.indexByString("E1"));
    celle1.cellStyle = cellStylee1;
    List<String> dataList = [
      "Nome",
      "Faltas",
      "Faltas Justificadas",
      "Faltas Aceitas",
      "Presenças"
    ];
    sheetObject.insertRowIterables(dataList, 0);
    int i = 1;
    int l = 2;
    presencaResumo.forEach((element) {
      List<String> dataList = [
        "${element.nome}",
        "${element.falta}",
        "${element.faltaJustificada}",
        "${element.faltaJustificadaAceitas}",
        "${element.presenca}"
      ];
      sheetObject.insertRowIterables(dataList, i);
      var cella1 = sheetObject.cell(CellIndex.indexByString("A$l"));
      cella1.cellStyle = cellStylea;
      var cellb1 = sheetObject.cell(CellIndex.indexByString("B$l"));
      cellb1.cellStyle = cellStyleb;
      var cellc1 = sheetObject.cell(CellIndex.indexByString("C$l"));
      cellc1.cellStyle = cellStylec;
      var celld1 = sheetObject.cell(CellIndex.indexByString("D$l"));
      celld1.cellStyle = cellStyled;
      var celle1 = sheetObject.cell(CellIndex.indexByString("E$l"));
      celle1.cellStyle = cellStylee;
      i++;
      l++;
    });

    excel.setDefaultSheet('folha1');
    share(
        bytes: excel.encode(),
        filename: 'excel1.xlsx',
        mimetype: 'application/xlsx');
  }

  @override
  void onInit() {
    super.onInit();
  }
}
