import 'package:flutter/material.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({
    required this.image,
    required this.title,
    required this.discription,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Lorem ipsum',
    image: 'assets/1.png',
    discription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
  ),
  UnbordingContent(
    title: 'Lorem ipsum',
    image: 'assets/2.png',
    discription: "but also the leap into electronic typesetting, remaining essentially unchanged",
  ),
  UnbordingContent(
    title: 'Lorem ipsum',
    image: 'assets/3.png',
    discription: "desktop publishing software like Aldus PageMaker including versions of Lorem",
  ),
];

// -- imagem de perfil
const String tProfileImage = "assets/profile.jpeg";

// profile screen
const String tProfile = "Profile";
const String tEditProfile = "Editar perfil";
const String tLogoutDialogHeading = "Sair do sistema";
const String tProfileHeading = "Matheus Melo";
const String tProfileSubHeading = "matheusidmelo@gmail.com";

// -- menu

// -- Update profile screen
const String tDelete = 'Delete';
const String tJoined = 'Joined';
const String tJoinedAt = '31 October 2022';

const Color dourado = Color.fromARGB(255, 234, 206, 150);
Color douradoEscuro = const Color.fromARGB(255, 168, 138, 78);
