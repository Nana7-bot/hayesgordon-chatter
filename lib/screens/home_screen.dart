import 'package:chatter/helper.dart';
import 'package:chatter/pages/calls_page.dart';
import 'package:chatter/pages/contact_page.dart';
import 'package:chatter/pages/messages_page.dart';
import 'package:chatter/pages/notification_page.dart';
import 'package:chatter/theme.dart';
import 'package:chatter/widgets/glowing_action_button.dart';
import 'package:chatter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> appBarTitle = ValueNotifier('Messages');

  void _onNavigationItemSelected(index) {
    pageIndex.value = index;
    appBarTitle.value = pagesTitle[index];
  }

  final pages = const [
    MessagesPage(),
    NotificationPage(),
    CallsPage(),
    ContactPage()
  ];
  final pagesTitle = const ["Messages", "Notifications", "Calls", "Contacts"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0.0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: appBarTitle,
          builder: (BuildContext context, String value, _) {
            return Text(
              appBarTitle.value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(
              url: Helpers.randomPictureUrl(),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _ButtomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _ButtomNavigationBar extends StatefulWidget {
  _ButtomNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);

  ValueChanged<int> onItemSelected;

  @override
  State<_ButtomNavigationBar> createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<_ButtomNavigationBar> {
  int selectedState = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedState = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Card(
      color: brightness == Brightness.light ? Colors.transparent : null,
      elevation: 0.0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
                label: 'Messages',
                icon: Icons.message,
                onTap: handleItemSelected,
                isSelected: (selectedState == 0),
              ),
              _NavigationBarItem(
                index: 1,
                label: 'Notifications',
                icon: Icons.notifications,
                onTap: handleItemSelected,
                isSelected: (selectedState == 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GlowingActionButton(
                    color: AppColors.secondary,
                    icon: Icons.add,
                    onPressed: () {}),
              ),
              _NavigationBarItem(
                index: 2,
                label: 'Calls',
                icon: Icons.call,
                onTap: handleItemSelected,
                isSelected: (selectedState == 2),
              ),
              _NavigationBarItem(
                index: 3,
                label: 'Contacts',
                icon: Icons.person,
                onTap: handleItemSelected,
                isSelected: (selectedState == 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  _NavigationBarItem(
      {Key? key,
      required this.onTap,
      required this.label,
      this.isSelected = false,
      required this.icon,
      required this.index})
      : super(key: key);

  ValueChanged<int> onTap;
  final int index;
  var isSelected;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
    );
  }
}
