import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gather/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOutTap;
  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onSignOutTap,
  });

  @override
  Widget build(BuildContext context) {
    //device sizes with media query
    var screenWidth=MediaQuery.of(context).size.width;

    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        children: [
          // drawer header
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: screenWidth * 0.2,
              ),
            ),
          ),
          // home list tile
          MyListTile(
            text: "HOME",
            icon: Icons.home,
            onTap: ()=>Navigator.pop(context),
          ),
          // profile list tile
          MyListTile(
            text: "PROFILE",
            icon: Icons.person,
            onTap: onProfileTap,
          ),
          Spacer(),
          // logout list tile
          MyListTile(
            text: "LOGOUT",
            icon: Icons.exit_to_app,
            onTap: onSignOutTap,
          ),
        ],
      ),
    );
  }
}
