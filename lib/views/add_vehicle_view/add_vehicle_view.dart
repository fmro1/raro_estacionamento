import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/locator.dart';
import 'package:raro_estacionamento/models/spot.dart';
import 'package:raro_estacionamento/views/common/app_bar_background.dart';
import 'package:raro_estacionamento/views/common/custom_form_field.dart';

class AddVehicleView extends StatefulWidget {
  const AddVehicleView({Key? key,
    this.spot,
  }) : super(key: key);

  static String ROUTE_PAGE = "/add_vehicle";

  final Spot? spot;

  @override
  State<AddVehicleView> createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController _spotController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _plateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar veículo',
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
                  child: Column(children: [
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: CustomFormField(
                          hintText: 'Data de entrada',
                          textName: "DATA",
                          textEditingController: _dateController,
                          textInputType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter
                                .digitsOnly,
                          ],
                          validator: (value){
                            if(value == null){
                              return "Seleciona uma data!";
                            } else return null;
                          },
                        ),
                      ),
                    ),
                    CustomFormField(
                        hintText: 'Digite a vaga',
                        textName: "N.º da vaga",
                      textInputType: TextInputType.number,
                      textEditingController: _spotController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly,
                      ],
                      validator: (value){
                          if(value == null){
                            return "Digite uma vaga!";
                          } else if(value.length > 0){
                            int val = int.parse(value);
                            if(val < 0 || val > locator<SpotController>().spots.length){
                              return "Vaga não é válida!";
                            }
                          } else return null;
                      },
                    ),
                    GestureDetector(
                      onTap: () => _selectTime(context),
                      child: AbsorbPointer(
                        child: CustomFormField(
                          hintText: 'Hora de entrada',
                          textName: "Hora",
                          textEditingController: _timeController,
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
                    CustomFormField(
                      textName: "Placa do veículo",
                      hintText: 'ABC1234',
                      textInputType: TextInputType.number,
                      textEditingController: _spotController,
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

                TextButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    print('validação com sucesso!');
                  }
                }, child: Text('validate')),
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
        _dateController.text = date;
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
        _timeController.text = time;
      });
  }
}
