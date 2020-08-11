import 'package:erobot_app/data/events.dart';
import 'package:erobot_app/widgets/eventcard.dart';
import 'package:erobot_app/widgets/profilecard.dart';
import 'package:flutter/material.dart';
import 'package:erobot_app/models/models.dart';
import 'package:erobot_app/data/data.dart';

class AboutMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: erobotmembers.length,
          itemBuilder: (context, index) {
            Member member = erobotmembers[index];
            return ProfileCard(
              name: member.name,
              role: member.role,
              image: member.path,
              onFBpressed: () {},
              onTGpressed: () {},
            );
          }),
    );
  }
}

class TeamReputation extends StatelessWidget {
  const TeamReputation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: reputation.length,
          itemBuilder: (context, index) {
            Reputation card = reputation[index];
            return EventCard(
                name: card.name,
                role: card.date,
                pathIMG: card.path,
                index: card.index,
                context: context);
          }),
    );
  }
}
