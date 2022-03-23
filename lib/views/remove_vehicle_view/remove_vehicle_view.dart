import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/default_constants/default_ui_sizes.dart';
import 'package:raro_estacionamento/helpers/date_converter.dart';
import 'package:raro_estacionamento/locator.dart';
import 'package:raro_estacionamento/models/spot.dart';
import 'package:raro_estacionamento/views/common/app_bar_background.dart';
import 'package:raro_estacionamento/views/common/custom_form_field.dart';
import 'package:raro_estacionamento/views/common/custom_outlined_button.dart';

class RemoveVehicleView extends StatefulWidget {
  const RemoveVehicleView({Key? key,
    this.spot
  }) : super(key: key);

  final Spot? spot;
  @override
  State<RemoveVehicleView> createState() => _RemoveVehicleViewState();
}

class _RemoveVehicleViewState extends State<RemoveVehicleView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateOutController = TextEditingController();
  TextEditingController _timeOutController = TextEditingController();
  TextEditingController _dateInController = TextEditingController();
  TextEditingController _timeInController = TextEditingController();
  TextEditingController _plateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Spot? selectedSpot;

  @override
  void initState() {
    /*seta valore iniciais de data e hora now()*/
    _dateOutController.text = DateConverter.dateToString(selectedDate, format: "dd/MM/yyyy");
    _timeOutController.text = DateConverter.dateToString(selectedDate, format: "HH:mm");
    /*verifica se já veio spot pra setar os valores*/
    if(widget.spot != null){
      DateTime spotInDateTime = widget.spot!.inDateTime ?? DateTime.now();
      _dateInController.text = DateConverter.dateToString(spotInDateTime);
      _timeInController.text = DateConverter.dateToString(spotInDateTime, format: "HH:mm");
      _plateController.text = widget.spot!.plate ?? '';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Remover veículo',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          flexibleSpace: MyAppBarBackground(),
        ),
        body: SingleChildScrollView(child:
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(6),
          child: Consumer<SpotController>(
            builder: (_, spotController, __){
              return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: kHPadding/2),
                        child: Row(
                          children: [
                            Text('Vaga: ', textAlign: TextAlign.left,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<Spot>(
                          mode: Mode.DIALOG,
                          showSearchBox: true,
                          selectedItem: widget.spot,
                          popupItemDisabled: (Spot s) => s.plate == null,
                          items: context.read<SpotController>().spots,
                          itemAsString: (Spot? s) => s?.spotAsString() ?? '',
                          onChanged: (Spot? s) {
                            selectedSpot = s;
                            String? date;
                            String? time;
                            if(s?.inDateTime != null){
                              date = DateConverter.dateToString(s!.inDateTime!);
                              time = DateConverter.dateToString(s.inDateTime!, format: "HH:mm");
                             } else {
                              time = "-";
                              date = "-";
                            }
                            _dateInController.text = date;
                            _timeInController.text = time;
                            _plateController.text = s?.plate ?? "-";
                          },
                        ),
                      ),
                      Row(children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => null,
                            child: AbsorbPointer(
                              child: CustomFormField(
                                textName: "Data de entrada",
                                hintText: "",
                                enabled: false,
                                textEditingController: _dateInController,
                                textInputType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .digitsOnly,
                                ],
                                // validator: (value){
                                //   if(value == null){
                                //     return "Selecione uma data!";
                                //   } else return null;
                                // },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => null,
                            child: AbsorbPointer(
                              child: CustomFormField(
                                textName: "Hora de entrada",
                                hintText: '',
                                enabled: false,
                                textEditingController: _timeInController,
                                textInputType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .digitsOnly,
                                ],
                                // validator: (value){
                                //   if(value == null){
                                //     return "Selecione uma hora!";
                                //   } else return null;
                                // },
                              ),
                            ),
                          ),
                        ),
                      ],),

                      Row(children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: CustomFormField(
                                textName: "Data de saída",
                                hintText: "Saída",
                                textEditingController: _dateOutController,
                                textInputType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .digitsOnly,
                                ],
                                validator: (value){
                                  if(value == null){
                                    return "Selecione uma data!";
                                  } else return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectTime(context),
                            child: AbsorbPointer(
                              child: CustomFormField(
                                textName: "Hora de saída",
                                hintText: 'Hora',
                                textEditingController: _timeOutController,
                                textInputType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .digitsOnly,
                                ],
                                validator: (value){
                                  if(value == null){
                                    return "Seleciona uma hora!";
                                  } else return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],),
                      SizedBox(height: 8,),
                      CustomFormField(
                        textName: "Placa do veículo",
                        hintText: '',
                        enabled: false,
                        textInputType: TextInputType.text,
                        textEditingController: _plateController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                          LengthLimitingTextInputFormatter(7),
                        ],
                        validator: (value){
                          if(value == null || value == ""){
                            return "Digite uma placa!";
                          } else return null;
                        },
                      ),
                      SizedBox(height: 8,),
                      CustomOutlinedButton(
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              print('validação com sucesso!');
                              if(selectedSpot == null && widget.spot == null){
                                await CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "Selecione a vaga",
                                );
                              } else {
                                locator<SpotController>().vehicleOut(
                                  spotId: selectedSpot?.id ?? widget.spot!.id,
                                  inDate: selectedSpot?.inDateTime
                                      ?? widget.spot!.inDateTime
                                      ?? DateTime.now(),
                                  outDate: selectedDate,
                                  outTime: selectedTime,
                                  plate: _plateController.text,
                                ).whenComplete(() => Navigator.of(context).pop());
                              }
                            }
                          },
                        text: "Salvar",
                      ),
                    ],));
            },
          ),
        )));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2011, 1),
        lastDate: DateTime.now().add(Duration(days: 1))
    ) ?? DateTime.now();
    if (picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateOutController.text = date;
      });
  }
  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay.now(),
    ) ?? TimeOfDay.now();
    if (picked != selectedTime)
      setState(() {
        selectedTime = picked;
        var time = "${picked.hour}:${picked.minute}";
        _timeOutController.text = time;
      });
  }
}
