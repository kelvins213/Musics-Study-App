import 'package:music/data/db/DBHelper.dart';
import 'package:music/domain/genre.dart';
import 'package:music/domain/music.dart';
import 'package:sqflite/sqflite.dart';

class DataRequest{

  Future<List<Music>> buildDatabase() async {
    DBHelper dbHelper = DBHelper();
    Database db = await dbHelper.initDB();

    String sql = "SELECT * FROM StudyMusics;";
    final queryResult = await db.rawQuery(sql);

    List<Music> musicList = <Music>[];

    for (var json in queryResult) {
      Music music = Music.fromJson(json);
      musicList.add(music);
    }
    return musicList;
  }

  Future<List> retrieveGenreDatas() async {
    DBHelper dbHelper = DBHelper();
    Database db = await dbHelper.initDB();

    List<MusicGenre> lofiList = <MusicGenre> [];
    List<MusicGenre> hipHopList = <MusicGenre> [];
    List<MusicGenre> popList = <MusicGenre> [];
    List<MusicGenre> electronicList = <MusicGenre> [];

    List musicGenreList = [
      lofiList,
      hipHopList,
      popList,
      electronicList,
    ];

    String sql = "select * from DrawerGenres";
    final jsonList = await db.rawQuery(sql);

    for (var json in jsonList) {
      MusicGenre object = MusicGenre.fromJson(json);
      switch (object.genreName) {
        case 'Lofi': lofiList.add(object); break;
        case 'Hip Hop': hipHopList.add(object); break;
        case 'Pop': popList.add(object);  break;
        case 'Electronic': electronicList.add(object); break;
      }
    }
    return musicGenreList;
  }


}