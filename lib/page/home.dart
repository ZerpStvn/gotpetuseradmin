import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipetuseradmin/page/login.dart';
import 'package:ipetuseradmin/page/users.dart';
import 'package:ipetuseradmin/page/veterinary.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  int currentpage = 0;

  Widget currentpageselect() {
    if (currentpage == 0) {
      return const VeterinaryPage();
    } else if (currentpage == 1) {
      return const UsersPage();
    } else {
      return const VeterinaryPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
            flex: 1,
            child: Drawer(
              shape: const RoundedRectangleBorder(),
              backgroundColor: Colors.lightBlueAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const DrawerHeader(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 116, 199, 231)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "PETGO",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 43,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        currentpage = 0;
                      });
                    },
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.pets_outlined,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      "Manage Clinic",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        currentpage = 01;
                      });
                    },
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.perm_identity,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      "Manage Users",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: _logout,
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ],
              ),
            )),
        Expanded(flex: 5, child: currentpageselect())
      ],
    ));
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out the user
      // After signing out, navigate to the login page or any other screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const LoginPage()), // Replace LoginPage with your login page widget
        (route) => false,
      );
    } catch (e) {
      // Handle any errors during logout, if necessary
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }
}
