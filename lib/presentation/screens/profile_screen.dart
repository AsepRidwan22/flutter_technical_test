import 'package:fan_technical_test/common/request_state_enum.dart';
import 'package:fan_technical_test/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const FetchCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Profile'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.requestStateEnum == RequestStateEnum.loading) {
            debugPrint('loading get user');
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircularProgressIndicator(), // Tambahkan circular progress indicator di sini
                  SizedBox(
                      height:
                          16), // Tambahkan jarak antara circular progress indicator dan teks
                  Text('Menunggu hasil pengambilan data...'),
                ],
              ),
            );
          } else if (state.requestStateEnum == RequestStateEnum.loaded) {
            debugPrint('loaded get user');
            return Container(
              alignment: Alignment.center,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Data pengguna: ${state.user}')
                ],
              ),
            );
          } else if (state.requestStateEnum == RequestStateEnum.error) {
            debugPrint('error get user');
            return Center(
              child: Text('Terjadi kesalahan: ${state.message}'),
            );
          }
          return const Center(
              child: Text('Menunggu hasil pengambilan data...'));
        },
      ),
    );
  }
}
