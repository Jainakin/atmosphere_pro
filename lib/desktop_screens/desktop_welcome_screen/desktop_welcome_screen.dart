import 'package:atsign_atmosphere_pro/desktop_routes/desktop_route_names.dart';
import 'package:atsign_atmosphere_pro/desktop_routes/desktop_routes.dart';
import 'package:atsign_atmosphere_pro/desktop_screens/desktop_common_widgets/desktop_selected_files.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/contact_initial.dart';
import 'package:atsign_atmosphere_pro/utils/colors.dart';
import 'package:atsign_atmosphere_pro/utils/images.dart';
import 'package:atsign_atmosphere_pro/utils/text_strings.dart';
import 'package:atsign_atmosphere_pro/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:atsign_atmosphere_pro/services/size_config.dart';
import 'package:atsign_atmosphere_pro/services/navigation_service.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/common_button.dart';
import 'package:atsign_atmosphere_pro/desktop_screens/desktop_common_widgets/desktop_side_bar.dart';
import 'package:atsign_atmosphere_pro/desktop_screens/desktop_common_widgets/desktop_selected_contacts.dart';
import 'package:atsign_atmosphere_pro/desktop_screens/desktop_history/desktop_history.dart';

class DesktopWelcomeScreenStart extends StatefulWidget {
  @override
  _DesktopWelcomeScreenStartState createState() =>
      _DesktopWelcomeScreenStartState();
}

class _DesktopWelcomeScreenStartState extends State<DesktopWelcomeScreenStart> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 0.1,
              ),
            ),
          ),
          child: AppBar(
            leading: Image.asset(
              ImageConstants.logoIcon,
              height: 50.toHeight,
              width: 50.toHeight,
            ),
            actions: [
              Icon(Icons.notifications, size: 30),
              SizedBox(width: 30),
              ContactInitial(
                initials: 'Levina',
                size: 30,
                maxSize: (80.0 - 30.0),
                minSize: 50,
              )
            ],
          ),
        ),
      ),
      body: DesktopWelcomeScreen(),
    );
  }
}

class DesktopWelcomeScreen extends StatefulWidget {
  @override
  _DesktopWelcomeScreenState createState() => _DesktopWelcomeScreenState();
}

class _DesktopWelcomeScreenState extends State<DesktopWelcomeScreen> {
  final List<String> menuItemsIcons = [
    ImageConstants.contactsIcon,
    ImageConstants.transferHistoryIcon,
    ImageConstants.blockedIcon,
    ImageConstants.myFiles,
    ImageConstants.groups,
    ImageConstants.trustedSender,
    ImageConstants.termsAndConditionsIcon,
    ImageConstants.faqsIcon,
    ImageConstants.trustedSendersIcon,
  ];

  bool showContent = false;

  @override
  Widget build(BuildContext context) {
    var routeBuilders = DesktopSetupRoutes.routeBuilders(context);
    return Scaffold(
        drawer: DesktopSideBarWidget(),
        body: Stack(children: [
          Row(
            children: [
              Container(
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 0.1,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: 100.toHeight),
                    SideBarIcon(menuItemsIcons[0]),
                    SizedBox(height: 40.toHeight),
                    SideBarIcon(menuItemsIcons[1]),
                    SizedBox(height: 40.toHeight),
                    SideBarIcon(menuItemsIcons[2]),
                    SizedBox(height: 40.toHeight),
                    SideBarIcon(menuItemsIcons[3]),
                    SizedBox(height: 40.toHeight),
                    SideBarIcon(menuItemsIcons[4]),
                    SizedBox(height: 40.toHeight),
                    SideBarIcon(menuItemsIcons[5]),
                    SizedBox(height: 40.toHeight),
                    SideBarIcon(menuItemsIcons[6]),
                    SizedBox(height: 40.toHeight),
                    SideBarIcon(menuItemsIcons[7]),
                    // SizedBox(height: 100.toHeight),
                  ],
                ),
              ),
              Expanded(
                child: Navigator(
                  key: NavService.nestedNavKey,
                  initialRoute: DesktopRoutes.DESKTOP_HOME_NESTED_INITIAL,
                  onGenerateRoute: (routeSettings) {
                    return MaterialPageRoute(builder: (context) {
                      return routeBuilders[routeSettings.name](context);
                    });
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 50,
            child: Builder(
              builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.toWidth),
                        color: Colors.black),
                    child: Icon(Icons.arrow_forward_ios_sharp,
                        size: 20, color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ]));
  }

  Widget sendFileTo({bool isSelectContacts = false}) {
    return InkWell(
        onTap: () {
          setState(() {
            showContent = !showContent;
          });
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListTile(
              title: showContent
                  ? Text(
                      (isSelectContacts
                          ? '18 contacts added'
                          : '2 files selected'),
                      style: CustomTextStyles.desktopSecondaryRegular18)
                  : SizedBox(),
              trailing: isSelectContacts
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Image.asset(
                        ImageConstants.contactsIcon,
                        color: Colors.black,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 15.toHeight),
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.black,
                      ),
                    ),
            )));
  }
}

class SideBarIcon extends StatefulWidget {
  final String image;
  SideBarIcon(this.image);
  @override
  _SideBarIconState createState() => _SideBarIconState();
}

class _SideBarIconState extends State<SideBarIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.image == ImageConstants.transferHistoryIcon) {
          DesktopSetupRoutes.nested_push(DesktopRoutes.DESKTOP_HISTORY);
        }
      },
      child: Image.asset(
        widget.image,
        height: 22.toHeight,
        color: ColorConstants.fadedText,
      ),
    );

    //  MouseRegion(
    //   cursor: isHovered ? SystemMouseCursors.click : SystemMouseCursors.text,
    //   onEnter: (event) {
    //     hoverActivation(true);
    //   },
    //   onExit: (event) {
    //     hoverActivation(false);
    //   },
    //   child: Image.asset(
    //     widget.image,
    //     height: 22.toHeight,
    //     color: ColorConstants.fadedText,
    //   ),
    // );

    // hoverActivation(bool _newValue) {
    //   setState(() {
    //     isHovered = _newValue;
    //   });
    // }
  }
}
