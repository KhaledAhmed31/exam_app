// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum Correct {
  @JsonValue("A1")
  A1,
  @JsonValue("A2")
  A2,
  @JsonValue("A3")
  A3,
  @JsonValue("A4")
  A4,
}

final correctValues = EnumValues({
  "A1": Correct.A1,
  "A2": Correct.A2,
  "A3": Correct.A3,
  "A4": Correct.A4,
});

enum Id {
  @JsonValue("670070a830a3c3c1944a9c63")
  THE_670070_A830_A3_C3_C1944_A9_C63,
}

final idValues = EnumValues({
  "670070a830a3c3c1944a9c63": Id.THE_670070_A830_A3_C3_C1944_A9_C63,
});

enum Subject {
  @JsonValue("670037f6728c92b7fdf434fc")
  THE_670037_F6728_C92_B7_FDF434_FC,
}

final subjectValues = EnumValues({
  "670037f6728c92b7fdf434fc": Subject.THE_670037_F6728_C92_B7_FDF434_FC,
});

enum Title {
  @JsonValue("HTML Quiz")
  HTML_QUIZ,
}

final titleValues = EnumValues({"HTML Quiz": Title.HTML_QUIZ});

enum Type {
  @JsonValue("single_choice")
  SINGLE_CHOICE,
}

final typeValues = EnumValues({"single_choice": Type.SINGLE_CHOICE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
