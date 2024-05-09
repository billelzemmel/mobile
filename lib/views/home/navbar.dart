import 'package:auto_ecole_app/models/user.dart';
import 'package:auto_ecole_app/views/account/screens/account_screen.dart';
import 'package:auto_ecole_app/views/calender/calender.dart';
import 'package:auto_ecole_app/views/calender/controller/SessionController.dart';
import 'package:auto_ecole_app/views/home/controller/stats.dart';
import 'package:auto_ecole_app/views/home/homev2.dart';
import 'package:auto_ecole_app/views/home/models/category.dart';
import 'package:auto_ecole_app/views/home/stats.dart';
import 'package:auto_ecole_app/views/home/statsv2.dart';
import 'package:auto_ecole_app/views/students/controllers/studentControler.dart';
import 'package:auto_ecole_app/views/students/displayStudents.dart';
import 'package:auto_ecole_app/views/vehicule/car_block.dart';
import 'package:auto_ecole_app/views/vehicule/controller/vehiculeController.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Run(),
    );
  }
}

class Run extends StatefulWidget {
  const Run({Key? key}) : super(key: key);

  @override
  _RunState createState() => _RunState();
}

class _RunState extends State<Run> {
  int _currentIndex = 0;
  bool _isLoading = true;
  GetStorage boxs = GetStorage();
  User? conuser;
  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;

  @override
  void initState() {
    super.initState();
    conuser = boxs.read('connectedUser');
    if (conuser != null) {
      _fetchCategories(conuser!);
      _fetchCars(conuser!);
      _fetchStudents(conuser!);
      _fetchStats(conuser!);
      _fetchSeances(conuser!);
    }
  }

  Future<void> _fetchCategories(User user) async {
    try {
      await Category.fetchCategories(user);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching categories: $error');
      // Handle error
    }
  }

  Future<void> _fetchCars(User user) async {
    try {
      await VehiculeController.fetchVehicule(user);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching categories: $error');
      // Handle error
    }
  }

  Future<void> _fetchSeances(User user) async {
    try {
      await SessionController.fetchSessions(user);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching categories: $error');
      // Handle error
    }
  }

  Future<void> _fetchStudents(User user) async {
    try {
      await StudentsController.fetchStudents(user);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  Future<void> _fetchStats(User user) async {
    double NbexamCode = 0;
    double NbexamsConduit = 0;
    double NbCondidats = 0;
    try {
      await GetStats.GetStatsCount(user);
      NbexamCode = (boxs.read('NbexamsCode') ?? 0).toDouble();
      NbexamsConduit = (boxs.read('NbexamsConduit') ?? 0).toDouble();
      NbCondidats = (boxs.read('Nbcandidat') ?? 0).toDouble();

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  List<BottomNavigationBarItem> _getBottomNavBarItems() {
    if (conuser != null && conuser!.type == "moniteur") {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Calender',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outlined),
          activeIcon: Icon(Icons.people),
          label: 'Students',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car_outlined),
          activeIcon: Icon(Icons.directions_car),
          label: 'Vehicle',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ];
    } else {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Calender',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ];
    }
  }

  List<Widget> _getScreens() {
    if (conuser != null && conuser!.type == "moniteur") {
      return [
        DesignCourseHomeScreen(),
        calender(),
        StudentBlock(),
        CarBlock(),
        AccountScreen(),
      ];
    } else {
      return [
        DesignCourseHomeScreen(),
        calender(),
        AccountScreen(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: _getScreens()[_currentIndex],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 72, 198, 144),
        unselectedItemColor: const Color(0xFF707070),
        type: _bottomNavType,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _getBottomNavBarItems(),
      ),
    );
  }
}
