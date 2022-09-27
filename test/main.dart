// void main() {
//   String multilineText = r"WIFI:T:WEP;S:test;P:hi;H:true;";
//   const pattern =
//       r'(?<=S:)((?:[^\\;\\?\\"\\$\\[\\\\\\]\\+])|(?:\\[\\;,:]))+(?<!\\;)(?=;)';
//   RegExp regExp = RegExp(
//     pattern,
//     multiLine: false,
//   );
//   if (regExp.hasMatch(multilineText)) {
//     List<List> matchesPositions = [];
//     for (var match in regExp.allMatches(multilineText)) {
//       matchesPositions.add([match.start, match.end]);
//     }
//     print(multilineText.contains(regExp));
//     print(matchesPositions);
//     multilineText.

//   }
// }
// const pattern =
//     r'^\[(?<Time>\s*((?<hour>\d+)):((?<minute>\d+))\.((?<second>\d+)))\]'
//     r'\s(?<Message>\s*(.*)$)';
// const pattern2 =
//    r"\s(?<S:>\s*)";


// final regExp = RegExp(
//   pattern,
//   multiLine: true,
// );

// const multilineText = '[00:13.37] This is a first message.\n'
//     '[01:15.57] This is a second message.\n';

// RegExpMatch regExpMatch = regExp.firstMatch(multilineText)!;
// print(regExpMatch.groupNames.join('-')); // hour-minute-second-Time-Message.
// final time = regExpMatch.namedGroup('Time'); // 00:13.37
// final hour = regExpMatch.namedGroup('hour'); // 00
// final minute = regExpMatch.namedGroup('minute'); // 13
// final second = regExpMatch.namedGroup('second'); // 37
// final message =
//     regExpMatch.namedGroup('Message'); // This is a first message.
// final date = regExpMatch.namedGroup('Date'); // Undefined `Date`, throws.

// Iterable<RegExpMatch> matches = regExp.allMatches(multilineText);
// for (final m in matches) {
//   print(m.namedGroup('Time'));
//   print(m.namedGroup('Message'));
//   // 00:13.37
//   // This is a first message.
//   // 01:15.57
//   // This is a second message.
// }