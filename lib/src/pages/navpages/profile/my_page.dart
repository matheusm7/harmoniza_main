import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/data/data.dart';

import '../../../../app/pages/profile/edit/edit_profile.dart';
import '../../../../app/pages/profile/support/support_page_profile.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool login = false;

  @override
  Widget build(BuildContext context) {
    Color dourado = const Color.fromARGB(255, 182, 154, 94);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Perfil',
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Stack(
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage('https://images.are.na/eyJidWNrZXQiOiJhcmVuYV9pbWFnZXMiLCJrZXkiOiI4MDQwOTc0L29yaWdpbmFsX2ZmNGYxZjQzZDdiNzJjYzMxZDJlYjViMDgyN2ZmMWFjLnBuZyIsImVkaXRzIjp7InJlc2l6ZSI6eyJ3aWR0aCI6MTIwMCwiaGVpZ2h0IjoxMjAwLCJmaXQiOiJpbnNpZGUiLCJ3aXRob3V0RW5sYXJnZW1lbnQiOnRydWV9LCJ3ZWJwIjp7InF1YWxpdHkiOjkwfSwianBlZyI6eyJxdWFsaXR5Ijo5MH0sInJvdGF0ZSI6bnVsbH19?bc=0'),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(FirebaseAuth.instance.currentUser!.displayName!, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 5),
                Text(FirebaseAuth.instance.currentUser!.email!, style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: dourado, side: BorderSide.none, shape: const StadiumBorder()),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
                    },
                    child: const Text(tEditProfile),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                  dourado: dourado,
                  title: "Configurações",
                  icon: Icons.settings,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  dourado: dourado,
                  title: "Historico de consultas",
                  icon: Icons.format_list_bulleted,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  dourado: dourado,
                  title: "Suporte",
                  icon: Icons.contact_support,
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportPageProfile()));
                  },
                ),
                const Divider(),
                ProfileMenuWidget(
                  dourado: dourado,
                  title: tLogoutDialogHeading,
                  icon: Icons.logout,
                  onPress: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  endIcon: false,
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.dourado,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final Color dourado;

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: dourado,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey,
                ),
              )
            : null);
  }
}
