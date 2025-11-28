import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/presentation/bloc/settings_cubit.dart';
import 'package:rolla_demo_app/features/scores/presentation/pages/home_page.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _goToHomePage() async {
    final String name = _controller.text.trim();

    final SettingsCubit settingsCubit = GetIt.instance<SettingsCubit>();
    await settingsCubit.save(settingsCubit.settings.copyWith(name: name));

    Navigator.of(context).push(_fadeRoute(const HomePage()));
  }

  /// Custom fade transition route
  PageRouteBuilder _fadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
          FadeTransition(opacity: animation, child: page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr.appTitle)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              tr.welcome,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 40),
            Text(
              tr.whatIsYourName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: tr.yourName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              tr.youCanLeaveThisEmptyAndChangeLater,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _goToHomePage,
              child: Text(tr.continueText),
            ),
          ],
        ),
      ),
    );
  }
}
