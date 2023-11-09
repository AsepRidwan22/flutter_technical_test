import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_technical_test/data/model/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({super.key});

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            title: const Text('Data Pengguna'),
            bottom: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              dividerColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Verifikasi Email'),
                Tab(text: 'Belum Verifikasi Email'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              // VerifiedUsersTab(fetchVerifiedUsers),
              VerifiedUsersTab(
                isEqualTo: true,
              ),
              VerifiedUsersTab(
                isEqualTo: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifiedUsersTab extends StatefulWidget {
  final bool isEqualTo;
  const VerifiedUsersTab({super.key, required this.isEqualTo});

  @override
  _VerifiedUsersTabState createState() => _VerifiedUsersTabState();
}

class _VerifiedUsersTabState extends State<VerifiedUsersTab> {
  Future<List<UserData>> fetchDataUsingToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final usersCollection = FirebaseFirestore.instance.collection('users');
      final querySnapshot = await usersCollection
          .where('isVerification', isEqualTo: widget.isEqualTo)
          .get();

      List<UserData> userDataList = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final userData = UserData(
          name: doc['name'],
          email: doc['email'],
        );
        userDataList.add(userData);
      }

      return userDataList;
    }

    return [];
  }

  List<UserData> usersData = [];

  @override
  void initState() {
    super.initState();
    fetchDataUsingToken().then((data) {
      setState(() {
        usersData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: usersData.length,
      itemBuilder: (context, index) {
        final userData = usersData[index];
        return Card(
          elevation: 4, // Efek bayangan di card
          margin: const EdgeInsets.all(8), // Jarak antar card
          child: ListTile(
            leading: const Icon(Icons.person,
                color: Colors.blue), // Ikon di sisi kiri
            title: Text(
              'Nama: ${userData.name}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              'Email: ${userData.email}',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}

// class VerifiedUsersTab extends StatelessWidget {
//   const VerifiedUsersTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Menunggu hasil pengambilan data...'),
//     );
//   }
// }

// class UnverifiedUsersTab extends StatefulWidget {
//   const UnverifiedUsersTab({Key? key});

//   @override
//   _UnverifiedUsersTabState createState() => _UnverifiedUsersTabState();
// }

// class _UnverifiedUsersTabState extends State<UnverifiedUsersTab> {
//   Future<List<UserData>> fetchDataUsingToken() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final usersCollection = FirebaseFirestore.instance.collection('users');
//       final querySnapshot =
//           await usersCollection.where('isVerification', isEqualTo: false).get();

//       List<UserData> userDataList = [];

//       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//         final userData = UserData(
//           name: doc['name'],
//           email: doc['email'],
//         );
//         userDataList.add(userData);
//       }

//       return userDataList;
//     }

//     return [];
//   }

//   List<UserData> usersData = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchDataUsingToken().then((data) {
//       setState(() {
//         usersData = data;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: usersData.length,
//       itemBuilder: (context, index) {
//         final userData = usersData[index];
//         return Card(
//           elevation: 4, // Efek bayangan di card
//           margin: const EdgeInsets.all(8), // Jarak antar card
//           child: ListTile(
//             leading: const Icon(Icons.person,
//                 color: Colors.blue), // Ikon di sisi kiri
//             title: Text(
//               'Nama: ${userData.name}',
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             subtitle: Text(
//               'Email: ${userData.email}',
//               style: const TextStyle(color: Colors.grey),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class UnverifiedUsersTab extends StatelessWidget {
//   const UnverifiedUsersTab({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Menunggu hasil pengambilan data...'),
//     );
//   }
// }
