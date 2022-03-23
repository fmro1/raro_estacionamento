import 'package:cool_alert/cool_alert.dart';
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
import 'package:dropdown_search/dropdown_search.dart';
import 'package:raro_estacionamento/views/common/custom_outlined_button.dart';

class AddVehicleView extends StatefulWidget {
  const AddVehicleView({
    Key? key,
    this.spot,
  }) : super(key: key);

  static String ROUTE_PAGE = "/add_vehicle";

  final Spot? spot;

  @override
  State<AddVehicleView> createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _plateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Spot? selectedSpot;

  @override
  void initState() {
    _dateController.text =
        DateConverter.dateToString(selectedDate, format: "dd/MM/yyyy");
    _timeController.text =
        DateConverter.dateToString(selectedDate, format: "HH:mm");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Adicionar veículo',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          flexibleSpace: MyAppBarBackground(),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(6),
          child: Consumer<SpotController>(
            builder: (_, spotController, __) {
              return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: CustomFormField(
                                  hintText: "Entrada",
                                  textName: "Data",
                                  textEditingController: _dateController,
                                  textInputType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator: (value) {
                                    if (value == null) {
                                      return "Selecione uma data!";
                                    } else
                                      return null;
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
                                  hintText: 'Hora de entrada',
                                  textName: "Hora",
                                  textEditingController: _timeController,
                                  textInputType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator: (value) {
                                    if (value == null) {
                                      return "Selecione uma hora!";
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kHPadding / 2),
                        child: Row(
                          children: [
                            Text(
                              'Vaga: ',
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<Spot>(
                          mode: Mode.DIALOG,
                          showSearchBox: true,
                          selectedItem: widget.spot,
                          popupItemDisabled: (Spot s) => s.plate != null,
                          items: context.read<SpotController>().spots,
                          itemAsString: (Spot? s) => s?.spotAsString() ?? '',
                          onChanged: (Spot? s) {
                            print("Spot selecionado: $s");
                            selectedSpot = s;
                          },
                        ),
                      ),
                      CustomFormField(
                        textName: "Placa do veículo",
                        hintText: 'ABC1234',
                        textInputType: TextInputType.text,
                        textEditingController: _plateController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9a-zA-Z]")),
                          LengthLimitingTextInputFormatter(7),
                        ],
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Digite uma placa!";
                          } else
                            return null;
                        },
                      ),
                      SizedBox(height: 8,),
                      CustomOutlinedButton(
                        text: "Salvar",
                          onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          print('validação com sucesso!\nVerificando vaga...');
                          if (selectedSpot == null && widget.spot == null) {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: "Selecione uma vaga!",
                            );
                          } else {
                            print("sucesso");
                            locator<SpotController>().vehicleIn(
                              spotId: selectedSpot?.id ?? widget.spot!.id,
                              inDate: selectedDate,
                              inTime: selectedTime,
                              plate: _plateController.text,
                            ).whenComplete(() async {
                              await CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "Sucesso",
                              );
                              Navigator.of(context).pop();
                            });
                          }
                        }
                      }),
                    ],
                  ));
            },
          ),
        )));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2011, 1),
            lastDate: DateTime.now().add(Duration(days: 1))) ??
        DateTime.now();
    if (picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
          initialEntryMode: TimePickerEntryMode.input,
          context: context,
          initialTime: TimeOfDay.now(),
        ) ??
        TimeOfDay.now();
    if (picked != selectedTime)
      setState(() {
        selectedTime = picked;
        var time = "${picked.hour}:${picked.minute}";
        _timeController.text = time;
      });
  }
}
