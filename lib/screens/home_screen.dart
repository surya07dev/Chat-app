import 'package:chat_app/constants/color_constants.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/popup_choices.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;

  late String currentUserId;
  late AuthProvider authProvider;
  // late HomeProvider homeProvidr;

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: 'Settings', icon: Icons.settings),
    PopupChoices(title: 'Sign out', icon: Icons.exit_to_app),
  ];

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    // homeProvider = context.read<HomeProvider>();

    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currentUserId = authProvider.getUserFirebaseId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false);
    }
    listScrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        appBar: AppBar(
          backgroundColor: isWhite ? Colors.white : Colors.black,
          leading: IconButton(
            icon: Switch(
              value: isWhite,
              onChanged: (value) {
                setState(() {
                  isWhite = value;
                  print(isWhite);
                });
              },
              activeColor: Colors.white,
              activeTrackColor: Colors.grey,
              inactiveTrackColor: Colors.grey,
              inactiveThumbColor: Colors.black45,
            ),
            onPressed: () {},
          ),
          actions: <Widget>[
            buildPopupMenu(),
          ],
        ));
  }

  Widget buildPopupMenu() {
    return PopupMenuButton<PopupChoices>(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.grey,
        ),
        onSelected: onItemMenuPress,
        itemBuilder: (BuildContext context) {
          return choices.map((PopupChoices choice) {
            return PopupMenuItem<PopupChoices>(
                child: Row(children: <Widget>[
              Icon(
                choice.icon,
                color: ColorConstants.primaryColor,
              ),
              Container(width: 10),
              Text(
                choice.title,
                style: const TextStyle(color: ColorConstants.primaryColor),
              )
            ]));
          }).toList();
        });
  }

// }
  void onItemMenuPress(PopupChoices choice) {
    if (choice.title == "sign out") {
      handleSignOut();
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SettingsPage()));
    }
  }

  Future<void> handleSignOut() async {
    authProvider.handleSignOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit = _limitIncrement;
      });
    }
  }
}
