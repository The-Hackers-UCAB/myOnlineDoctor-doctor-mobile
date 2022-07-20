//Package imports:
// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/firebase-handler/local_notifications.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dialog_component.dart';

//Project imports:
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';
import 'package:my_online_doctor/infrastructure/ui/video_call/call.dart';

class BottomMenuComponent extends StatefulWidget {
  static const routeName = '/bottom_menu';

  final items;
  final screens;
  int index;

  BottomMenuComponent({
    Key? key,
    required this.items,
    required this.screens,
    required this.index,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomMenuComponent();
}

class _BottomMenuComponent extends State<BottomMenuComponent> {
  _BottomMenuComponent();

  @override
  void initState()  {
    localNotificationService.initialize();
    super.initState();
    //Terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        localNotificationService.showNotificationOnForeground(message);
      }
      print('//////////////////////////////////////////////////////////////////////////////////////////////////////');
      print('getInitialMessage: ${message!.data}');
      print('//////////////////////////////////////////////////////////////////////////////////////////////////////');
    });
    //Foreground state
    FirebaseMessaging.onMessage.listen((message) async {
      localNotificationService.showNotificationOnForeground(message);

     

      print('//////////////////////////////////////////////////////////////////////////////////////////////////////');
      print('onMessage: ${message.data['payload']}');
      print('//////////////////////////////////////////////////////////////////////////////////////////////////////');
    });
    //Background state
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      localNotificationService.showNotificationOnForeground(message);

      print('//////////////////////////////////////////////////////////////////////////////////////////////////////');
      print('onBackgroundMessage: ${message.data['payload']}');
      print('//////////////////////////////////////////////////////////////////////////////////////////////////////');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.screens[widget.index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: colorWhite),
        ),
        child: CurvedNavigationBar(
          color: colorSecondary,
          index: widget.index,
          items: widget.items,
          height: MediaQuery.of(context).size.height * 0.07,
          buttonBackgroundColor: colorPrimary,
          backgroundColor: colorWhite,
          onTap: (newIndex) => setState(() {
            widget.index = newIndex;
          }),
        ),
      ),
    );
  }
}
