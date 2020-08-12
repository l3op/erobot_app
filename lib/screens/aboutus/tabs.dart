import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/data.dart';
import 'package:erobot_app/import/screens.dart';
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
          itemCount: event.length,
          itemBuilder: (context, index) {
            Event card = event[index];
            return EventCard(
              name: card.eventName,
              role: card.eventDate,
              pathIMG: card.eventPath,
              index: card.index,
              context: context,
              onPressed: () {
                print('see more clicked $index');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutTeamTemplate(index)));
              },
            );
          }),
    );
  }
}
