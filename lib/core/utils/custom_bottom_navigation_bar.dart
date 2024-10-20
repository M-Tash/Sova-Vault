import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sova_vault/config/theme/my_theme.dart';

Widget buildCustomBottomNavigationBar(
    {required int selectedIndex,
    required Function(int) onTapFunction,
    required BuildContext context}) {
  return Material(
    elevation: 8.0,
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      child: BottomNavigationBar(
        selectedLabelStyle: Theme.of(context).textTheme.labelMedium,
        unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
        selectedItemColor: MyTheme.whiteColor,
        unselectedItemColor: MyTheme.greyColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyTheme.secondaryColor,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onTapFunction,
        items: [
          BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.all(5),
                  child: selectedIndex == 0
                      ? Icon(
                          CupertinoIcons.home,
                          color: MyTheme.whiteColor,
                        )
                      : Icon(
                          CupertinoIcons.home,
                          color: MyTheme.greyColor,
                        )),
              label: "DashBoard"),
          BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.all(5),
                  child: selectedIndex == 1
                      ? Icon(
                          CupertinoIcons.home,
                          color: MyTheme.whiteColor,
                        )
                      : Icon(
                          CupertinoIcons.home,
                          color: MyTheme.greyColor,
                        )),
              label: "Countries"),
          BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.all(5),
                  child: selectedIndex == 2
                      ? Icon(
                          CupertinoIcons.home,
                          color: MyTheme.whiteColor,
                        )
                      : Icon(
                          CupertinoIcons.home,
                          color: MyTheme.greyColor,
                        )),
              label: "Services")
        ],
      ),
    ),
  );
}
