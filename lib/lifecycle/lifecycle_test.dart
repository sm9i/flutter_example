import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LifecyclePage extends StatefulWidget {
  const LifecyclePage({Key? key}) : super(key: key);

  @override
  _LifecyclePageState createState() => _LifecyclePageState();
}

class _LifecyclePageState extends State<LifecyclePage> with AppLifecycle {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('data'),
            onTap: () {
              showAboutDialog(context: context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void resume(bool resume) {
    print('onResume :$resume');
  }
}

class _State extends ChangeNotifier {
  //page resume
  bool _resume = true;

  //app resume
  bool _appResume = true;

  bool get appResume => _appResume;

  set appResume(bool value) {
    if (_appResume == value) {
      return;
    }
    _appResume = value;
    notifyListeners();
  }

  bool get resume => _resume;

  set resume(bool value) {
    if (_resume == value) {
      return;
    }
    _resume = value;
    notifyListeners();
  }
}

mixin AppLifecycle<T extends StatefulWidget> on State<T> implements WidgetsBindingObserver, RouteAware {
  final _State _stat = _State();

  ///
  ///  navigatorObservers: [RouteObserver<ModalRoute<void>>()]
  ///
  RouteObserver<ModalRoute<void>>? routeObserver;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _stat.addListener(() => resume(_stat.resume && _stat.appResume));
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      if (Navigator.of(context).widget.observers.isNotEmpty) {
        routeObserver = Navigator.of(context).widget.observers.first as RouteObserver<ModalRoute<void>>;
        routeObserver!.subscribe(this, ModalRoute.of(context)!);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _stat.appResume = true;
    } else {
      _stat.appResume = false;
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    routeObserver?.unsubscribe(this);
    _stat.dispose();
    super.dispose();
  }

  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeLocales(List<Locale>? locales) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() {
    return Future<bool>.value(false);
  }

  @override
  Future<bool> didPushRoute(String route) {
    return Future<bool>.value(false);
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    return Future<bool>.value(true);
  }

  @override
  void didPop() {
    _stat.resume = false;
  }

  @override
  void didPopNext() {
    _stat.resume = true;
  }

  @override
  void didPush() {
    _stat.resume = true;
  }

  @override
  void didPushNext() {
    _stat.resume = false;
  }

  void resume(bool resume);
}
