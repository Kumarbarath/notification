import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() {

// needed if you intend to initialize in the `main` function

  runApp(MyApp());
}

void start(hour,minutes){
  print("hours:$hour,minutes:$minutes");
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(

    // The top level function, aka callbackDispatcher
      callbackDispatcher,

      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: true
  );
// Periodic task registration
  Workmanager.registerPeriodicTask(
    "2",
    "simplePeriodicTask",


    frequency: Duration(hours: hour,minutes:minutes),

  );
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    print("call back ");

    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip);
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip) async {

// Show a notification after every 15 minute with the first
// appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'Time to wash your face',
      importance: Importance.max,
      priority: Priority.high
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

// initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
  );
  await flip.show(0, 'Onwords',
      'Hello,Its face time Buddy.Lets wash the bad thoughts da bhoi ',
      platformChannelSpecifics, payload: 'Default_Sound'
  );
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geeks Demo',
      theme: ThemeData(

        // This is the theme
        // of your application.
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(title: "Onwords"),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int hour=0;
  int minutes=15;
  int seconds=0;
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        // Here we take the value from
        // the MyHomePage object that was created by
        // the App.build method, and use it
        // to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Row(
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              children: [
               Column(
                 children: [
                   Text("Hours",
                   style: TextStyle(
                     fontSize: 20,

                   ),
                   ),
                   Text("$hour",
                   style: TextStyle(
                     fontSize: 40,
                   ),
                   ),
                   Row(
                     children: [
                       
                       FloatingActionButton(

                           onPressed: ()
                       {
                          setState(() {
                            if(hour<12){
                              hour++;
                            }

                          });
                       },
                         child: Icon(Icons.arrow_circle_up_sharp,
                         size: 30,
                         ),
                       ),

                       FloatingActionButton(onPressed: (){
                         setState(() {
                           if(hour>=1){
                             hour--;
                           }

                         });

                       },
                       child: Icon(Icons.arrow_circle_down_sharp,
                       size: 30 ,),
                       )
                     ],
                   )
                 ],
               ),


                Column(
                  children: [
                    Text("Minutes",
                      style: TextStyle(
                        fontSize: 20,

                      ),
                    ),
                    Text("$minutes",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Row(
                      children: [

                        FloatingActionButton(

                          onPressed: ()
                          {
                            setState(() {
                              if(minutes<60){
                                minutes++;
                              }

                            });
                          },
                          child: Icon(Icons.arrow_circle_up_sharp,
                            size: 30,
                          ),
                        ),

                        FloatingActionButton(onPressed: (){
                          setState(() {
                            if(minutes>=16){
                              minutes--;
                            }

                          });

                        },
                          child: Icon(Icons.arrow_circle_down_sharp,
                            size: 30 ,),
                        )
                      ],
                    )
                  ],
                ),



                Column(
                  children: [
                    Text("Seconds",
                      style: TextStyle(
                        fontSize: 20,

                      ),
                    ),
                    Text("$seconds",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Row(
                      children: [

                        FloatingActionButton(

                          onPressed: ()
                          {
                            setState(() {

                            });
                          },
                          child: Icon(Icons.arrow_circle_up_sharp,
                            size: 30,
                          ),
                        ),

                        FloatingActionButton(onPressed: (){
                          setState(() {

                          });

                        },
                          child: Icon(Icons.arrow_circle_down_sharp,
                            size: 30 ,),
                        )
                      ],
                    )
                  ],
                ),





              ],
            ),
            RaisedButton(onPressed: (){
              setState(() {
                start(hour,minutes);
              });


            },
            child: Text("Start"),
            ),



          ],
        ),
      ),
    );
  }
}
