import 'package:intl/intl.dart';
import 'package:movie_app/core/models/genre_model.dart';

String getDuration(String runtime) {
  List<String> parts = runtime.split(" ");
  if (parts.length != 2 || parts[1] != "min") {
    // throw const FormatException("Invalid input format.");
    return '0h';
  }
  int time = int.parse(parts[0]);

  int hours = time ~/ 60;
  int minutes = time % 60;

  return "${hours}h ${minutes}min";
}

String getGenre(int id) {
  for (int i = 0; i < genreList.length; i++) {
    if (genreList[i]['id'] == id) {
      return (genreList[i]['name'].toString());
    }
  }
  return '';
}

String shortBio(String bio) {
  if (bio.isEmpty) {
    return 'This cast doesn\'t have any bio.';
  }
  List<String> words = bio.split(' ');
  if (words.length <= 25) {
    return bio;
  }
  return '${words.sublist(0, 25).join(' ')}.';
}

var imageCheck =
    'https://media.istockphoto.com/id/517998264/vector/male-user-icon.jpg?s=612x612&w=0&k=20&c=4RMhqIXcJMcFkRJPq6K8h7ozuUoZhPwKniEke6KYa_k=';

String getYear(String date) {
  DateFormat inputFormat = DateFormat("MMMM d, yyyy");
  DateTime dateTime = inputFormat.parse(date);

  String year = DateFormat('yyyy').format(dateTime);
  return year;
}
