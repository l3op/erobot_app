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
  Event(
    this.eventName,
    this.eventPath,
    this.eventDate,
    this.imagePath,
    this.member,
    this.memberPath,
    this.robot,
    this.robotPath,
    this.index,
  );
}
