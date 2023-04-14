part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Names of properties that can be set on a [MPLocation]
enum MPLocationPropertyNames {
  name("name"),
  aliases("aliases"),
  categories("categories"),
  floor("floor"),
  floorName("floorName"),
  building("building"),
  venue("venue"),
  //DISPLAY_RULE,
  type("type"),
  description("description"),
  roomId("roomId"),
  externalId("externalId"),
  activeFrom("activeFrom"),
  activeTo("activeTo"),
  contact("contact"),
  fields("fields"),
  imageURL("imageURL"),
  locationType("locationType"),
  anchor("anchor"),
  status("status"),
  bookable("bookable");

  final String propertyName;
  const MPLocationPropertyNames(this.propertyName);

  dynamic toJson() => name;
}
