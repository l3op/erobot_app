import 'package:flutter/material.dart';

class RequestMember {
  static String firstName;
  static String lastName;
  static String email;
  static String memberInfo;
  static String whyJoin;
  static String password;
}

class Button {
  final String top, left, right, bottom, power;
  Button(this.top, this.left, this.bottom, this.right, this.power);
}

class Member {
  final String path;
  final String name;
  final String role;
  final String fb;
  final String tele;
  Member(this.path, this.name, this.role, this.fb, this.tele);
}

class Reputation {
  final String path;
  final String name;
  final String date;
  final int index;
  Reputation(this.path, this.name, this.date, this.index);
}

class Event {
  final String eventName;
  final String eventPath;
  final String eventDate;
  final List<String> imagePath;
  final List<String> member;
  final List<String> memberPath;
  final List<String> robot;
  final List<String> robotPath;
  final int index;
  Event(this.eventName, this.eventPath, this.eventDate, this.imagePath,
      this.member, this.memberPath, this.robot, this.robotPath, this.index);
}

class Doc {
  final String title;
  final String describe;
  final int index;
  final String imagePath;
  Doc(this.title, this.describe, this.index, this.imagePath);
}

class RecentSender {
  final String recent;
  final Color color;
  RecentSender(this.recent, this.color);
}