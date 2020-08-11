import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/data.dart';
import 'package:erobot_app/import/widgets.dart';

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
