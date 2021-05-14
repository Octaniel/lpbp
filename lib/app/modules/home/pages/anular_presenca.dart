import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:velocity_x/velocity_x.dart';

class AnularPresenca extends GetView<HomeController> {
  final f = new DateFormat('dd/MM/yyyy');
  final localizations = MaterialLocalizations.of(Get.context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anular faltas"),
      ),
      body: GetBuilder<HomeController>(
        builder: (_) {
          return Container(
            height: Get.height*.5,
            child: Card(
              child: ListView(
                children: [
                  Wrap(
                    spacing: 10,
                    children: [
                      Container(
                        width: Get.width*.2,
                        child: ListTile(
                          title: Text(f.format(controller.pikedDate.value)),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          onTap: _pickDate,
                        ),
                      ),
                      // SizedBox(
                      //   width: Get.width*.02,
                      // ),
                      Container(
                        width: Get.width*.2,
                        child: ListTile(
                          title: Text(localizations.formatTimeOfDay(controller.timeOfDayStar.value, alwaysUse24HourFormat: true)),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          onTap: _pickTimeStart,
                        ),
                      ),
                      // SizedBox(
                      //   width: Get.width*.02,
                      // ),
                      Container(
                        width: Get.width*.2,
                        child: ListTile(
                          title: Text("${controller.timeOfDayEnd.value.hour}:"
                              "${controller.timeOfDayEnd.value.minute}"),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          onTap: _pickTimeEnd,
                        ),
                      ),
                      GetBuilder<HomeController>(
                        builder: (_) {
                          return Column(
                            children: [
                              Text(controller.refres.value, style: TextStyle(color: Colors.transparent),),
                              ProgressButton.icon(
                                  iconedButtons: {
                                    ButtonState.idle: IconedButton(
                                        text: "Anular",
                                        icon:
                                        Icon(FontAwesomeIcons.times, color: Colors.white),
                                        color: Color.fromARGB(255, 4, 125, 141)),
                                    ButtonState.loading: IconedButton(
                                        text: "Carregando",
                                        color: Color.fromARGB(255, 4, 125, 141)),
                                    ButtonState.fail: IconedButton(
                                        text: "Falha",
                                        icon: Icon(Icons.cancel,
                                            color: Colors.white),
                                        color: Colors.redAccent),
                                    ButtonState.success: IconedButton(
                                        text: "Sucesso",
                                        icon: Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                        ),
                                        color: Colors.green.shade400)
                                  },
                                  onPressed: () async {
                                    controller.buttonState = ButtonState.loading;
                                    validarForm();
                                  },
                                  state: controller.buttonState)
                            ],
                          );
                        },
                        id: 'buttonState',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        id: "pikedDate",
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
        context: Get.context,
        initialDate: controller.pikedDate.value,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      controller.pikedDate.value = date;
      controller.updat("pikedDate");
    }
  }

  _pickTimeStart() async {
    TimeOfDay time = await showTimePicker(
      context: Get.context,
      initialTime: controller.timeOfDayStar.value,
    );
    if (time != null) {
      controller.timeOfDayStar.value = time;
      controller.updat("pikedDate");
    }
  }

  _pickTimeEnd() async {
    TimeOfDay time = await showTimePicker(
      context: Get.context,
      initialTime: controller.timeOfDayEnd.value,
    );
    if (time != null) {
      controller.timeOfDayEnd.value = time;
      controller.updat("pikedDate");
    }
  }

  void validarForm() async {
    // const v = 'yyyy-MM-dd'T'HH:mm:ss';
    var s = "${controller.pikedDate.value.year}-"
        "${controller.pikedDate.value.month.toString().length==1?'0${controller.pikedDate.value.month}':controller.pikedDate.value.month}-"
        "${controller.pikedDate.value.day.toString().length==1?'0${controller.pikedDate.value.day}':controller.pikedDate.value.day}T"
        "${controller.timeOfDayStar.value.hour.toString().length==1?'0${controller.timeOfDayStar.value.hour}':controller.timeOfDayStar.value.hour}:"
        "${controller.timeOfDayStar.value.minute.toString().length==1?'0${controller.timeOfDayStar.value.minute}':controller.timeOfDayStar.value.minute}:00";
    var s1 = "${controller.pikedDate.value.year}-"
        "${controller.pikedDate.value.month.toString().length==1?'0${controller.pikedDate.value.month}':controller.pikedDate.value.month}-"
        "${controller.pikedDate.value.day.toString().length==1?'0${controller.pikedDate.value.day}':controller.pikedDate.value.day}T"
        "${controller.timeOfDayEnd.value.hour.toString().length==1?'0${controller.timeOfDayEnd.value.hour}':controller.timeOfDayEnd.value.hour}:"
        "${controller.timeOfDayEnd.value.minute.toString().length==1?'0${controller.timeOfDayEnd.value.minute}':controller.timeOfDayEnd.value.minute}:00";
    if(await controller.setarTodosAsPresencasParaPresenteEntre(s,s1)){
      controller.buttonState = ButtonState.success;
      controller.updat("buttonState");
      Get.snackbar("", "",
          titleText: 'Sucesso'
              .text
              .color(Colors.white)
              .size(16)
              .bold
              .make(),
          snackPosition: SnackPosition.BOTTOM,
          messageText: 'Faltas anuladas com sucesso'
              .text
              .color(Colors.white)
              .size(15)
              .bold
              .make(),
          icon: Icon(
            FontAwesomeIcons.check,
            color: Colors.white,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF3CFEB5),
          borderRadius: 10,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
      Future.delayed(Duration(seconds: 2), (){
        controller.buttonState = ButtonState.idle;
        controller.updat("buttonState");
      });
    }else{
      controller.buttonState = ButtonState.fail;
      controller.updat("buttonState");
    }
  }
}
