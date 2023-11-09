import 'package:fan_technical_test/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:fan_technical_test/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:fan_technical_test/presentation/bloc/login_form/login_form_bloc.dart';
import 'package:fan_technical_test/presentation/bloc/profile/profile_bloc.dart';
import 'package:fan_technical_test/presentation/bloc/register_form/register_form_bloc.dart';
import 'package:fan_technical_test/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fan_technical_test/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => di.locator<LoginFormBloc>(),
    ),
    BlocProvider(
      create: (_) => di.locator<RegisterFormBloc>(),
    ),
    BlocProvider(
      create: (_) => di.locator<ForgotPasswordBloc>(),
    ),
    BlocProvider(
      create: (_) => di.locator<DashboardBloc>(),
    ),
    BlocProvider(
      create: (_) => di.locator<ProfileBloc>(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}



//kode dibawah ini adalah kode hasil aku research di awal awal

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   bool _isLoading = false;
//   final _auth = FirebaseAuth.instance;
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextFormField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             MaterialButton(
//               onPressed: () async {
//                 setState(() {
//                   _isLoading = true;
//                 });
//                 try {
//                   final email = emailController.text;
//                   final password = passwordController.text;

//                   // Buat pengguna dengan email dan password
//                   final userCredential =
//                       await _auth.createUserWithEmailAndPassword(
//                     email: email,
//                     password: password,
//                   );

//                   // Kirim email verifikasi
//                   final user = userCredential.user;
//                   await user?.sendEmailVerification();

//                   // Tambahkan data pengguna ke Firestore
//                   final cekLogin = FirebaseAuth.instance.currentUser;
//                   if (cekLogin != null) {
//                     await FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(cekLogin.uid)
//                         .set({
//                       'email': email,
//                       'isVerification': false,
//                     });
//                   }

//                   // Tampilkan pesan sukses dan logika navigasi
//                   const snackbar = SnackBar(
//                     content: Text(
//                         'Registrasi berhasil. Silakan cek email Anda untuk verifikasi.'),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackbar);
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                       builder: (context) => const LoginPage(),
//                     ),
//                   );
//                 } catch (e) {
//                   final snackbar = SnackBar(content: Text(e.toString()));
//                   ScaffoldMessenger.of(context).showSnackBar(snackbar);
//                 } finally {
//                   setState(() {
//                     _isLoading = false;
//                   });
//                 }
//               },
//               color: Colors.blue,
//               textColor: Colors.white,
//               child: const Text('Daftar'),
//             ),
//             if (_isLoading)
//               const CircularProgressIndicator(), // Tampilkan indicator saat isLoading = true
//           ],
//         ),
//       ),
//     );
//   }

//   // @override
//   // void dispose() {
//   //   emailController.dispose();
//   //   passwordController.dispose();
//   //   super.dispose();
//   // }
// }

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _isLoading = false;
//   final _auth = FirebaseAuth.instance;
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   Future<void> updateIsVerificationToTrue(String userId) async {
//     try {
//       final userFirestore =
//           FirebaseFirestore.instance.collection('users').doc(userId);
//       await userFirestore.update({
//         'isVerification': true,
//       });
//     } catch (e) {
//       throw Exception('Gagal memperbarui status verifikasi: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextFormField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 setState(() {
//                   _isLoading = true;
//                 });
//                 try {
//                   final email = emailController.text;
//                   final password = passwordController.text;

//                   // Masukkan kode ini untuk memeriksa apakah email sudah terverifikasi
//                   final userCredential = await _auth.signInWithEmailAndPassword(
//                     email: email,
//                     password: password,
//                   );
//                   final user = userCredential.user;
//                   if (user != null && user.emailVerified) {
//                     final token = await user.getIdToken();
//                     // Email sudah terverifikasi, navigasi ke halaman berikutnya
//                     debugPrint("token : $token");
//                     final userFirestore = FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(user.uid);
//                     final userData = await userFirestore.get();
//                     final isVerification = userData.data()?['isVerification'];
//                     if (isVerification != true) {
//                       await updateIsVerificationToTrue(user.uid);
//                     }
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                         builder: (context) => HomeScreen(),
//                       ),
//                     );
//                   } else {
//                     const snackbar = SnackBar(
//                       content: Text(
//                           'Email belum terverifikasi. Cek kotak masuk Anda untuk verifikasi.'),
//                     );
//                     ScaffoldMessenger.of(context).showSnackBar(snackbar);
//                   }
//                 } catch (e) {
//                   final snackbar = SnackBar(content: Text(e.toString()));
//                   ScaffoldMessenger.of(context).showSnackBar(snackbar);
//                 } finally {
//                   setState(() {
//                     _isLoading = false;
//                   });
//                 }
//               },
//               child: const Text('Login'),
//             ),
//             if (_isLoading)
//               const CircularProgressIndicator(), // Tampilkan indicator saat isLoading = true
//             TextButton(
//               onPressed: () {
//                 // Navigasi ke halaman pendaftaran (Daftar)
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const RegisterPage(),
//                   ),
//                 );
//               },
//               child: const Text('Daftar'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({Key? key}) : super(key: key);

//   @override
//   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   bool _isLoading = false;
//   final _auth = FirebaseAuth.instance;
//   final emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lupa Password'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 setState(() {
//                   _isLoading = true;
//                 });
//                 try {
//                   final email = emailController.text;
//                   await _auth.sendPasswordResetEmail(email: email);
//                   // Email verifikasi reset password telah dikirim
//                   const snackbar = SnackBar(
//                     content: Text(
//                         'Email verifikasi reset password telah dikirim. Silakan cek kotak masuk Anda.'),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackbar);
//                 } catch (e) {
//                   final snackbar = SnackBar(content: Text(e.toString()));
//                   ScaffoldMessenger.of(context).showSnackBar(snackbar);
//                 } finally {
//                   setState(() {
//                     _isLoading = false;
//                   });
//                 }
//               },
//               child: const Text('Reset Password'),
//             ),
//             if (_isLoading)
//               const CircularProgressIndicator(), // Tampilkan indicator saat isLoading = true
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Data Pengguna'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'Verifikasi Email'),
//               Tab(text: 'Belum Verifikasi Email'),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             // VerifiedUsersTab(fetchVerifiedUsers),
//             VerifiedUsersTab(),
//             // UnverifiedUsersTab(),
//             AuthenticatedUsersTab()
//           ],
//         ),
//       ),
//     );
//   }
// }

// class VerifiedUsersTab extends StatelessWidget {
//   const VerifiedUsersTab({Key? key});

//   Future<void> fetchDataUsingToken() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final usersCollection = FirebaseFirestore.instance.collection('users');
//       final querySnapshot = await usersCollection
//           .where('isVerification',
//               isEqualTo: true) // Hanya data yang sudah terverifikasi
//           .get();

//       // Loop melalui dokumen-dokumen yang ditemukan
//       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//         print('Data pengguna: ${doc.data()}');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     fetchDataUsingToken(); // Panggil fungsi untuk mengambil data

//     return const Center(
//       child: Text('Menunggu hasil pengambilan data...'),
//     );
//   }
// }

// class UnverifiedUsersTab extends StatelessWidget {
//   const UnverifiedUsersTab({Key? key});

//   Future<void> fetchDataUsingToken() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final usersCollection = FirebaseFirestore.instance.collection('users');
//       final querySnapshot = await usersCollection
//           .where('isVerification',
//               isEqualTo: false) // Hanya data yang sudah terverifikasi
//           .get();

//       // Loop melalui dokumen-dokumen yang ditemukan
//       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//         print('Data pengguna: ${doc.data()}');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     fetchDataUsingToken(); // Panggil fungsi untuk mengambil data

//     return const Center(
//       child: Text('Menunggu hasil pengambilan data...'),
//     );
//   }
// }

// class AuthenticatedUsersTab extends StatelessWidget {
//   const AuthenticatedUsersTab({Key? key});

//   Future<void> fetchAuthenticatedUserData() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final email = user.email;
//       final usersCollection = FirebaseFirestore.instance.collection('users');
//       final querySnapshot = await usersCollection
//           .where('email',
//               isEqualTo: email) // Sesuaikan dengan nama field email Anda
//           .get();

//       // Loop melalui dokumen-dokumen yang ditemukan
//       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//         print('Data pengguna: ${doc.data()}');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     fetchAuthenticatedUserData(); // Panggil fungsi untuk mengambil data

//     return const Center(
//       child: Text('Menunggu hasil pengambilan data...'),
//     );
//   }
// }
