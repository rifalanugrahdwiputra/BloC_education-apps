import 'package:education_bloc/bloc/logout_bloc.dart';
import 'package:education_bloc/modules/home/widgets/announcement_widgets.dart';
import 'package:education_bloc/modules/home/widgets/profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/announcement_bloc.dart';
import '../../bloc/home_bloc.dart';
import '../../state/announcement_state.dart';
import '../../state/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ini adalah code utama untuk memanggil BloC nya
    return MultiBlocProvider(
      // disini cast menggunakan MultiBlocProvider agar dapat menggunakan banyak BloC
      providers: [
        // disini pendaftaran BloC nya
        BlocProvider(
          create: (BuildContext context) {
            return UserBloc();
          },
        ),
        // sampai sini
        // disini pendaftaran BloC nya
        BlocProvider(
          create: (BuildContext context) {
            return LogoutBloc();
          },
        ),
        // sampai sini
        // disini pendaftaran BloC nya
        BlocProvider(
          create: (BuildContext context) {
            return AnnouncementBloc();
          },
        ),
        // sampai sini
        // jika ada tambahan lain tambahkan disini
      ],
      child: _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  @override
  void initState() {
    super.initState();
    // disini untuk kita memanggil function yang ada di BloC nya atau disebut(emit event call function)
    context.read<UserBloc>().add(FetchUserData());
    context.read<AnnouncementBloc>().add(FetchAnnouncementData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg_lg.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // disini adalah kondisi dimana untuk melihat state nya
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(
                          child: Text('Menunggu data pengguna'));
                    } else if (state is UserLoaded) {
                      return ProfileWidget()
                          .profileInfo(state.userData, context);
                    } else {
                      return const Center(
                          child: Text('Gagal mengambil data pengguna'));
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                BlocBuilder<AnnouncementBloc, AnnouncementState>(
                  builder: (context, state) {
                    if (state is AnnouncementLoading) {
                      return const Center(
                          child: Text('Menunggu data pengguna'));
                    } else if (state is AnnouncementLoaded) {
                      return AnnouncementWidget()
                          .announcementInfo(state.announcementData);
                    } else {
                      return const Center(
                          child: Text('Gagal mengambil data pengguna'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
