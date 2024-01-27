import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:fnf_fitness/screens/dashboard.dart';
import 'package:fnf_fitness/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FirebaseMessaging _messaging;

  @override
  void initState() {
    registerNotification();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FNF Fitness',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffEAFAF5),
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xffEAFAF5),
          titleTextStyle: GoogleFonts.lobster(
              color: Color(0xff108319),
              fontSize: 30,
              fontWeight: FontWeight.bold),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xff108319)),
        ),
      ),
      home: SplashScreen(),
      routes: {
        Dashboard.routeName: (context) => Dashboard(),
      },
    );
  }

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    String? token = await _messaging.getToken();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      var initiizationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInit = const DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      var initializationSettings = InitializationSettings(
          android: initiizationSettingsAndroid, iOS: iosInit);

      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
          switch (notificationResponse.notificationResponseType) {
            case NotificationResponseType.selectedNotification:
              // selectNotification(notificationResponse.id.toString());
              break;
            case NotificationResponseType.selectedNotificationAction:
              // if (notificationResponse.actionId == navigationActionId) {
              //   selectNotificationStream.add(notificationResponse.payload);
              // }
              break;
          }
        },
      );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        var data = message.data;

        // AndroidNotification? android = message.notification?.android;
        if (notification != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              const NotificationDetails(
                  iOS: DarwinNotificationDetails(
                    presentAlert: true,
                    presentBadge: true,
                    presentSound: true,
                  ),
                  android: AndroidNotificationDetails('1', 'pushnotification',
                      channelDescription: 'Test',
                      color: Color(0xffff9d89),
                      colorized: true,
                      priority: Priority.max,
                      channelShowBadge: true,
                      importance: Importance.high,
                      playSound: true)));
        }
      });
    }
  }

  Future<String?> getToken() async {
    Future<String?> token = FirebaseMessaging.instance.getToken();
    return token;
  }
}

class PushData {
  String? id;
  String? action;

  PushData({this.id, this.action});
}
