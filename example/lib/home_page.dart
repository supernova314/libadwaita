import 'package:example/pages/avatar_page.dart';
import 'package:example/pages/counter_page.dart';
import 'package:example/pages/flap_page.dart';
import 'package:example/pages/lists_page.dart';
import 'package:example/pages/settings_page.dart';
import 'package:example/pages/style_classes_page.dart';
import 'package:example/pages/view_switcher_page.dart';
import 'package:example/pages/welcome.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:libadwaita/libadwaita.dart';
// import 'package:libadwaita/sr';
import 'package:yaru_window/yaru_window.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.themeNotifier}) : super(key: key);

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<int> counter = ValueNotifier(0);
  int? _currentIndex = 0;

  late ScrollController listController;
  late ScrollController settingsController;
  late FlapController _flapController;

  @override
  void initState() {
    super.initState();
    listController = ScrollController();
    settingsController = ScrollController();
    _flapController = FlapController();

    _flapController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    listController.dispose();
    settingsController.dispose();
    super.dispose();
  }

  void changeTheme() =>
      widget.themeNotifier.value = widget.themeNotifier.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    final window = YaruWindow.of(context);
    final developers = {
      'Prateek Sunal': 'prateekmedia',
      'Malcolm Mielle': 'MalcolmMielle',
      'sim': 'simrat39',
      'Jesús Rodríguez': 'jesusrp98',
      'Polo': 'pablojimpas',
    };

    return AdwScaffold(
      headerBarStyle: HeaderBarStyle(isTransparent: true),
      flapController: _flapController,
      actions: AdwActions().adwDefault,
      start: [
        AdwHeaderButton(
          icon: Center(
            child: SvgPicture.asset(
              'assets/dock-left-symbolic.svg',
              width: 16,
              height: 16,
              color: context.textColor,
            ),
          ),
          isActive: _flapController.isOpen,
          onPressed: () => _flapController.toggle(),
        ),
        AdwHeaderButton(
          icon: const Icon(Icons.nightlight_round, size: 15),
          onPressed: changeTheme,
        ),
      ],
      title: const Text('Libadwaita Demo'),
      end: [
        GtkPopupMenu(
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AdwButton.flat(
                onPressed: () {
                  counter.value = 0;
                  Navigator.of(context).pop();
                },
                padding: AdwButton.defaultButtonPadding.copyWith(
                  top: 10,
                  bottom: 10,
                ),
                child: const Text(
                  'Reset Counter',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Divider(),
              AdwButton.flat(
                padding: AdwButton.defaultButtonPadding.copyWith(
                  top: 10,
                  bottom: 10,
                ),
                child: const Text(
                  'Preferences',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              AdwButton.flat(
                padding: AdwButton.defaultButtonPadding.copyWith(
                  top: 10,
                  bottom: 10,
                ),
                onPressed: () => showDialog<Widget>(
                  context: context,
                  builder: (ctx) => AdwAboutWindow(
                    issueTrackerLink:
                        'https://github.com/gtk-flutter/libadwaita/issues',
                    appIcon: Image.asset('assets/logo.png'),
                    actions: AdwActions(
                      onClose: Navigator.of(context).pop,
                      onHeaderDrag: (context) {
                        window.drag();
                      },
                      onDoubleTap: window.maximize,
                    ),
                    credits: [
                      AdwPreferencesGroup.credits(
                        title: 'Developers',
                        children: developers.entries
                            .map(
                              (e) => AdwActionRow(
                                title: e.key,
                                onActivated: () => launchUrl(
                                  Uri.parse('https://github.com/${e.value}'),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                    copyright: 'Copyright 2021-2022 Gtk-Flutter Developers',
                    license: const Text(
                      'GNU LGPL-3.0, This program comes with no warranty.',
                    ),
                  ),
                ),
                child: const Text(
                  'About this Demo',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ],
      flap: (isDrawer) => AdwSidebar(
        currentIndex: _currentIndex,
        isDrawer: isDrawer,
        children: const [
          AdwSidebarItem(
            label: 'Welcome',
          ),
          AdwSidebarItem(
            label: 'Counter',
          ),
          AdwSidebarItem(
            label: 'Lists',
          ),
          AdwSidebarItem(
            label: 'Avatar',
          ),
          AdwSidebarItem(
            label: 'Flap',
          ),
          AdwSidebarItem(
            label: 'View Switcher',
          ),
          AdwSidebarItem(
            label: 'Settings',
          ),
          AdwSidebarItem(
            label: 'Style Classes',
          )
        ],
        onSelected: (index) => setState(() => _currentIndex = index),
      ),
      body: AdwViewStack(
        animationDuration: const Duration(milliseconds: 100),
        index: _currentIndex,
        children: [
          const WelcomePage(),
          CounterPage(counter: counter),
          const ListsPage(),
          const AvatarPage(),
          const FlapPage(),
          const ViewSwitcherPage(),
          const SettingsPage(),
          const StyleClassesPage(),
        ],
      ),
    );
  }
}
