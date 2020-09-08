import 'package:erobot_app/config/offset_notifier.dart';
import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/data.dart';
import 'package:erobot_app/import/screens.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class AboutMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: erobotmembers.length,
        itemBuilder: (context, index) {
          Member member = erobotmembers[index];
          return Consumer<PageOffsetNotifier>(
            builder: (context, notifier, child) {
              double offset =
                  MediaQuery.of(context).size.width * 2 - notifier.offset;
              return Transform.translate(
                offset: Offset(offset * index * 0.4, 0),
                child: Opacity(
                    opacity: notifier.page > 2
                        ? math.max(0, -notifier.page % 1)
                        : notifier.page != 2
                            ? math.max(0, notifier.page % 1)
                            : 1,
                    child: child),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                bottom: index == erobotmembers.length - 1 ? 16.0 : 0,
              ),
              child: ProfileCard(
                name: member.name,
                role: member.role,
                image: member.path,
                onFBpressed: () {},
                onTGpressed: () {},
              ),
            ),
          );
        },
      ),
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
          return Consumer<PageOffsetNotifier>(
            builder: (context, notifier, child) {
              double offset =
                  MediaQuery.of(context).size.width * 2 - notifier.offset;
              return Transform.translate(
                offset: Offset(offset * index * 0.4, 0),
                child: Opacity(
                  opacity: notifier.page > 2
                      ? math.max(0, -notifier.page % 1)
                      : notifier.page != 2 ? math.max(0, notifier.page % 1) : 1,
                  child: child,
                ),
              );
            },
            child: EventCard(
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
                    builder: (context) => AboutTeamTemplate(index),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
