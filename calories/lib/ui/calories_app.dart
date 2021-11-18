import 'package:calories/ui/foods_view.dart';
import 'package:calories/ui/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'diary_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            // ignore: deprecated_member_use
            brightness: Brightness.light,
            color: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          textTheme: const TextTheme(
              headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "OpenSans",
          ))),
      home: MyHomePage(title: 'Hôm nay'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  int _counter = 0;
  int _selectedView = 0;

  late List<Widget> _views;
  late List<Widget> _floatingButtons;

  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.grey[50],
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.black54,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _reset();
    _selectedView = 0;
  }

  void _reset() {
    setState(() {
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    });
  }

  void _changeView(int index) {
    setState(() {
      _selectedView = index;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _reset();
        break;
      case AppLifecycleState.inactive:
        // ignore: todo
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        // ignore: todo
        // TODO: Handle this case.
        break;
      case AppLifecycleState.detached:
        // ignore: todo
        // TODO: Handle this case.
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _views = [
      Diary(),
      Foods(),
      const Text("Hello World 3"),
      Profile(),
    ];
    _floatingButtons = [
      FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: 'Thêm vào nhật ký',
        icon: const Icon(Icons.add),
        label: const Text("THÊM"),
      ),
      FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: 'Tạo đồ ăn thức uống mới',
        icon: const Icon(Icons.add),
        label: const Text("TẠO MỚI"),
      ),
      FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        icon: const Icon(Icons.add),
        label: const Text("THÊM"),
      ),
      FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: 'Chỉnh sửa hồ sơ',
        icon: const Icon(Icons.edit),
        label: const Text("SỬA HỒ SƠ"),
      ),
    ];

    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return _views.elementAt(_selectedView);
        },
      ),
      floatingActionButton: _floatingButtons.elementAt(_selectedView),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            // ignore: deprecated_member_use
            title: Text("Nhật ký"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            // ignore: deprecated_member_use
            title: Text("Đồ ăn"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            // ignore: deprecated_member_use
            title: Text("Biểu đồ"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            // ignore: deprecated_member_use
            title: Text("Hồ sơ"),
          ),
        ],
        onTap: _changeView,
        currentIndex: _selectedView,
      ),
    );
  }
}
