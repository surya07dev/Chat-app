import 'package:chat_app/constants/app_constants.dart';
import 'package:chat_app/constants/color_constants.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/providers/home_provider.dart';
import 'package:chat_app/providers/setting_provider.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isWhite = false;
final _messageStreamController = BehaviorSubject<RemoteMessage>();


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 await Firebase.initializeApp();

 if (kDebugMode) {
   print("Handling a background message: ${message.messageId}");
   print('Message data: ${message.data}');
   print('Message notification: ${message.notification?.title}');
   print('Message notification: ${message.notification?.body}');
 }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
  playSound: true,
);

SharedPreferences prefs = await SharedPreferences.getInstance();

  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
 alert: true,
 announcement: false,
 badge: true,
 carPlay: false,
 criticalAlert: false,
 provisional: false,
 sound: true,
);

 if (kDebugMode) {
   print('Permission granted: ${settings.authorizationStatus}');
 }

String? token = await messaging.getToken();

if (kDebugMode) {
  print('Registration Token=$token');
}


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
   if (kDebugMode) {
     print('Handling a foreground message: ${message.messageId}');
     print('Message data: ${message.data}');
     print('Message notification: ${message.notification?.title}');
     print('Message notification: ${message.notification?.body}');
   }

   _messageStreamController.sink.add(message);
 });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);


  runApp(MyHomePage(prefs: prefs,));
}
class MyHomePage extends StatefulWidget {
   final SharedPreferences prefs;
  
  const MyHomePage({super.key, required this.prefs});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 String _lastMessage = "";


final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

 _MyHomePageState() {
   _messageStreamController.listen((message) {
     setState(() {
       if (message.notification != null) {
         _lastMessage = 'Received a notification message:'
             '\nTitle=${message.notification?.title},'
             '\nBody=${message.notification?.body},'
             '\nData=${message.data}';
       } else {
         _lastMessage = 'Received a data message: ${message.data}';
       }
     });
   });
 }

 @override
 Widget build(BuildContext context) {
  
   return 
   MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
              firebaseAuth: FirebaseAuth.instance,
              firebaseFirestore: firebaseFirestore,
              googleSignIn: GoogleSignIn(),
              prefs: widget.prefs),
        ),
        Provider<SettingProvider>(
          create: (_) => SettingProvider(
              prefs: widget.prefs,
              firebaseFirestore: firebaseFirestore,
              firebaseStorage: firebaseStorage),
        ),
        Provider<HomeProvider>(
          create: (_) => HomeProvider(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: widget.prefs,
            firebaseFirestore: firebaseFirestore,
            firebaseStorage: firebaseStorage,
          ),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(
          primaryColor: ColorConstants.themeColor,
          primarySwatch: MaterialColor(0xfff5a623, ColorConstants.swatchColor),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
 }
}