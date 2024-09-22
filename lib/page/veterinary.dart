import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VeterinaryPage extends StatefulWidget {
  const VeterinaryPage({super.key});

  @override
  State<VeterinaryPage> createState() => _VeterinaryPageState();
}

class _VeterinaryPageState extends State<VeterinaryPage> {
  Map<String, dynamic> veterinayuser = {};
  bool isloadvalidate = false;
  String message = "";
  Future<List<Map<String, dynamic>>> _getUsers() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 1)
        .get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  // Future _getVeterinaryInfo(userid) async {
  //   final DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userid)
  //       .collection('vertirenary')
  //       .doc('userid')
  //       .get();
  //   if(snapshot.exists){
  //     veterinayuser = snapshot.data()
  //   }
  // }

  List<Map<String, dynamic>> _filteredUsers = [];
  String _searchQuery = "";
  bool _ascending = true;
  int _sortColumnIndex = 0;

  @override
  void initState() {
    super.initState();
    _getUsers().then((users) {
      setState(() {
        _filteredUsers = users;
      });
    });
  }

  // Search function
  void _searchUsers(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  // Sort function
  void _sortUsers(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _ascending = ascending;

      _filteredUsers.sort((a, b) {
        final aValue = a[_getColumnField(columnIndex)];
        final bValue = b[_getColumnField(columnIndex)];
        if (ascending) {
          return aValue.compareTo(bValue);
        } else {
          return bValue.compareTo(aValue);
        }
      });
    });
  }

  // Get column field for sorting
  String _getColumnField(int index) {
    switch (index) {
      case 0:
        return 'imageprofile';
      case 1:
        return 'fname';
      case 2:
        return 'email';
      case 3:
        return 'nameclinic';
      case 4:
        return 'pnum';
      default:
        return '';
    }
  }

  // Filtered users based on search
  List<Map<String, dynamic>> get _displayedUsers {
    return _filteredUsers
        .where((user) =>
            user['fname'].toLowerCase().contains(_searchQuery) ||
            user['nameclinic'].toLowerCase().contains(_searchQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Veterinary Clinics"),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search by Name or Clinic",
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: _searchUsers,
            ),
          ),

          // Data Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _filteredUsers.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: DataTable(
                        border: TableBorder(),
                        headingRowColor: const WidgetStatePropertyAll(
                            Colors.lightBlueAccent),
                        headingTextStyle: const TextStyle(color: Colors.white),
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _ascending,
                        columns: [
                          const DataColumn(label: Text("Profile Image")),
                          DataColumn(
                            label: const Text("First Name"),
                            onSort: (columnIndex, ascending) =>
                                _sortUsers(columnIndex, ascending),
                          ),
                          DataColumn(
                            label: const Text("Email"),
                            onSort: (columnIndex, ascending) =>
                                _sortUsers(columnIndex, ascending),
                          ),
                          DataColumn(
                            label: const Text("Clinic Name"),
                            onSort: (columnIndex, ascending) =>
                                _sortUsers(columnIndex, ascending),
                          ),
                          DataColumn(
                            label: const Text("Phone Number"),
                            onSort: (columnIndex, ascending) =>
                                _sortUsers(columnIndex, ascending),
                          ),
                          const DataColumn(label: Text("Actions")),
                        ],
                        rows: _displayedUsers.map((user) {
                          return DataRow(
                            cells: [
                              DataCell(
                                user['imageprofile'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                            user['imageprofile'],
                                            width: 50,
                                            height: 50),
                                      )
                                    : const Icon(
                                        Icons.person), // Placeholder image
                              ),
                              DataCell(Text(user['fname'] ?? '')),
                              DataCell(Text(user['email'] ?? '')),
                              DataCell(Text(user['nameclinic'] ?? '')),
                              DataCell(Text(user['pnum'] ?? '')),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {
                                    _showUserDetails(user, user['vetid']);
                                  },
                                  child: const Text("View"),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> approvecertificate(userID) async {
    setState(() {
      isloadvalidate = true;
    });

    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('vertirenary')
          .doc(userID)
          .update({'valid': 1});

      FirebaseFirestore.instance
          .collection('announcement')
          .doc(userID)
          .collection('announce')
          .add({'title': 'Approved', 'valid': 1}).then((uid) {
        setState(() {
          isloadvalidate = false;
          message = "Clinic has been notified";
        });
      });
    } catch (eror) {
      debugPrint("$eror");
      setState(() {
        isloadvalidate = false;
        message = "Error, Please try again later";
      });
    }
  }

  Future<void> validatecertificate(userID) async {
    setState(() {
      isloadvalidate = true;
    });
    try {
      FirebaseFirestore.instance
          .collection('announcement')
          .doc(userID)
          .collection('announce')
          .add({'title': 'Denied', 'valid': 0}).then((uid) {
        setState(() {
          isloadvalidate = false;
          message = "Clinic has been notified";
        });
      });
    } catch (eror) {
      setState(() {
        isloadvalidate = false;
        message = "Error, Please try again later";
      });
      debugPrint("$eror");
    }
  }

  // Function to show user details in a dialog
  void _showUserDetails(Map<String, dynamic> user, String userID) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("User Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                user['imageprofile'] != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: 120,
                        child: Image.network(
                          fit: BoxFit.cover,
                          user['imageprofile'],
                        ))
                    : const Icon(Icons.person, size: 100),
                const SizedBox(height: 10),
                Text("Name: ${user['fname']}"),
                Text("Email: ${user['email']}"),
                Text("Clinic: ${user['nameclinic']}"),
                Text("Phone: ${user['pnum']}"),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(userID)
                        .collection('vertirenary')
                        .doc(userID)
                        .get(),
                    builder: (context, snapshopt) {
                      if (!snapshopt.hasData) {
                        return const CircularProgressIndicator();
                      } else {
                        Map<String, dynamic>? vetdata = snapshopt.data!.data();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 14,
                            ),
                            Text("TIN Number: ${vetdata!['tin'] ?? ''}"),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("BIR CERTIFICATE"),
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  vetdata['bir']))),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("DTI CERTIFICATE"),
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  vetdata['dti']))),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            isloadvalidate == true
                                ? const CircularProgressIndicator()
                                : Row(
                                    children: [
                                      vetdata['valid'] == 1
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.green,
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                approvecertificate(userID);
                                              },
                                              child: const Text("Approve")),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            validatecertificate(userID);
                                          },
                                          child: const Text("Validate"))
                                    ],
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              message,
                              style: const TextStyle(color: Colors.green),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
