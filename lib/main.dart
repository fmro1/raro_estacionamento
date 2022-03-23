import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raro_estacionamento/controllers/firebase_database_controller.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/default_constants/default_ui_sizes.dart';
import 'package:raro_estacionamento/locator.dart';
import 'package:raro_estacionamento/views/add_vehicle_view/add_vehicle_view.dart';
import 'package:raro_estacionamento/views/common/app_bar_background.dart';
import 'package:raro_estacionamento/views/common/create_route.dart';
import 'package:raro_estacionamento/views/common/main_big_button.dart';
import 'package:raro_estacionamento/views/history_today/history_today_view.dart';
import 'package:raro_estacionamento/views/my_spots/my_spots.dart';
import 'package:raro_estacionamento/views/remove_vehicle_view/remove_vehicle_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SpotController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        // routes: {
        //   AddVehicleView.ROUTE_PAGE : (context) => AddVehicleView(),
        //   "/remove_vehicle": (context) => RemoveVehicleView(),
        //   //"/today_history": () => Container(),
        // },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    //locator<FirebaseDatabaseController>().setInitialData();
    locator<FirebaseDatabaseController>().testFunction();

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        flexibleSpace: MyAppBarBackground(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kHPadding/2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: kHPadding/2,),
                    Row(
                      children: [
                        Expanded(child: MainBigButton(
                          backgroundColor: Colors.green,
                          text: "Entrada",
                          iconData: Icons.arrow_forward_ios,
                          textColor: Colors.white,
                          onTap: (){
                            Navigator.of(context).push(
                                CreateRoute.pushRoute(AddVehicleView())
                            );
                          },
                        )),
                        SizedBox(width: 6,),
                        Expanded(child: MainBigButton(
                          backgroundColor: Colors.redAccent,
                          text: "Saída",
                          iconData: Icons.arrow_back_ios,
                          textColor: Colors.white,
                          onTap: (){
                            Navigator.of(context).push(
                                CreateRoute.pushRoute(RemoveVehicleView())
                            );
                          },
                        ),)
                      ],
                    ),
                    SizedBox(height: 6,),
                    Row(
                      children: [
                        Expanded(child: MainBigButton(
                          backgroundColor: Colors.orange,
                          text: "Hoje",
                          iconData: Icons.event_available_outlined,
                          textColor: Colors.white,
                          onTap: (){
                            Navigator.of(context).push(
                                CreateRoute.pushRoute(HistoryTodayView())
                            );
                          },
                        )),
                        SizedBox(width: 6,),
                        Expanded(child: MainBigButton(
                          backgroundColor: Colors.indigoAccent,
                          text: "Histórico",
                          iconData: Icons.assignment_outlined,
                          textColor: Colors.white,
                          onTap: (){},
                        ),)
                      ],
                    ),
                  SizedBox(height: kHPadding/2),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              MySpots(),

              // Text('Últimas movimentações'),
              // Consumer<SpotController>(builder: (_, spotController, __ ){
              //   return ListView(
              //     physics: ScrollPhysics(),
              //     shrinkWrap: true,
              //     children: [
              //       ...spotController.history.map((e) => Container(
              //         child: Text('Historico: ${e.plate}'),)
              //       ),
              //     ],
              //   );
              // }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
