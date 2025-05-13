import 'package:flutter/material.dart';

/// Configuration file for portfolio content
/// Based on the developerFolio template structure
class PortfolioConfig {
  // Greeting section
  static final greeting = {
    'title': 'George Amir',
    'subtitle': 'Flutter Developer',
    'resumeLink': 'https://drive.google.com/file/your-resume-link',
  };

  // Social media links
  static final socialMediaLinks = {
    'github': 'https://github.com/Georgeamir1',
    'linkedin': 'https://linkedin.com/in/george-amir-570586216',
    'email': 'amirgeorge841@gmail.com',
    'phone': '01068780012',
  };

  // Skills section
  static final skillsSection = {
    'title': 'What I do',
    'subTitle': 'CRAZY FLUTTER DEVELOPER WHO WANTS TO EXPLORE EVERY TECH STACK',
    'skills': [
      {
        'icon': Icons.flutter_dash,
        'name': 'Flutter Framework',
        'level': 0.9,
      },
      {
        'icon': Icons.code,
        'name': 'Dart Object-Oriented Programming',
        'level': 0.85,
      },
      {
        'icon': Icons.layers,
        'name': 'BLoC State Management',
        'level': 0.8,
      },
      {
        'icon': Icons.phone_android,
        'name': 'Responsive UI',
        'level': 0.9,
      },
      {
        'icon': Icons.api,
        'name': 'Networking & API Integration With Dio',
        'level': 0.75,
      },
      {
        'icon': Icons.bug_report,
        'name': 'Debugging & Error Handling',
        'level': 0.8,
      },
      {
        'icon': Icons.design_services,
        'name': 'UI/UX Design: Figma | Photoshop',
        'level': 0.7,
      },
    ],
    'softwareSkills': [
      {'skillName': 'Flutter', 'fontAwesomeClassName': 'flutter_dash'},
      {'skillName': 'Dart', 'fontAwesomeClassName': 'code'},
      {'skillName': 'Firebase', 'fontAwesomeClassName': 'fire'},
      {'skillName': 'Git', 'fontAwesomeClassName': 'git-alt'},
      {'skillName': 'Figma', 'fontAwesomeClassName': 'figma'},
      {'skillName': 'Photoshop', 'fontAwesomeClassName': 'photoshop'},
    ],
  };

  // Work experience
  static final workExperience = [
    {
      'company': 'ISC',
      'role': 'Flutter Developer',
      'date': '2024-06 – present',
      'location': 'Zagazig, Egypt',
      'description': 'Working on Flutter applications with focus on clean architecture and performance optimization.',
    },
    {
      'company': 'EgCoco',
      'role': 'Flutter Developer and UI/UX',
      'date': '2023-06 – 2023-12',
      'location': 'Helwan, Egypt',
      'description': 'Developed mobile applications using Flutter and designed user interfaces with Figma.',
    },
  ];

  // Projects
  static final projects = [
    {
      'title': 'Ettamin UI',
      'description': 'This application provides an easy user interface for patients to record medical conditions and all their history to show them to doctors any time.',
      'image': 'assets/images/ettamin.png',
      'link': '',
    },
    {
      'title': 'Casty',
      'description': 'The platform provides a valuable resource for media production companies, granting them convenient access to a comprehensive pool of talented individuals eager to showcase their abilities.',
      'image': 'assets/images/casty.png',
      'link': '',
    },
    {
      'title': 'Orchida Clinic',
      'description': 'This app simplifies scheduling and patient care. Doctors can easily create new reservations and update patient medical histories.',
      'image': 'assets/images/orchida.png',
      'link': '',
    },
    {
      'title': 'Pinion CRM',
      'description': 'Pinion CRM is a user-friendly customer relationship management application designed to streamline business operations.',
      'image': 'assets/images/pinion.png',
      'link': '',
    },
    {
      'title': 'Perfect Solution',
      'description': 'A powerful Flutter-based mobile integrated with Odoo ERP via Odoo RPC, featuring secure authentication, real-time data sync, CRUD operations.',
      'image': 'assets/images/perfect.png',
      'link': '',
    },
  ];

  // Education
  static final education = {
    'university': 'Zagazig University',
    'degree': 'Bachelor in Computer Science',
    'date': '2019 – 2023',
    'location': 'Zagazig, Egypt',
  };

  // Achievements
  static final achievements = [
    {
      'title': 'Flutter Development Certification',
      'description': 'Completed advanced Flutter development certification program',
      'date': '2023',
    },
    {
      'title': 'UI/UX Design Award',
      'description': 'Recognized for exceptional UI/UX design in mobile applications',
      'date': '2022',
    },
  ];

  // Contact
  static final contact = {
    'title': 'Contact Me',
    'subtitle': 'DISCUSS A PROJECT OR JUST WANT TO SAY HI? MY INBOX IS OPEN FOR ALL',
    'email': 'amirgeorge841@gmail.com',
    'phone': '01068780012',
    'location': 'Zagazig, Egypt',
  };
}
