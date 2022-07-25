// ///  استفاده کنیم باید اطلاعات اهنگ رو به جیسون تبدیل کنیم که با این متد میشود این کار را انجام داد AndriodHandlerd  برای اینکه بتونیم از

// abstract class PlayListRepository {
//   Future<List<Map<String, String>>> fetchMyPlayList();
// }

// class MyPlayList extends PlayListRepository {
//   @override
//   Future<List<Map<String, String>>> fetchMyPlayList() async {
//     const String song1 =
//         'https://ts9.tarafdari.com/contents/user627598/content-sound/aud-20210403-wa0001.mp3';
//     const String song2 =
//         'https://dl.baarzesh.net/music/2019/201911/Tones_And_I_Dance_Monkey_320.mp3';
//     const String song3 =
//         'https://dls.music-fa.com/tagdl/downloads/Iman%20Fallah%20-%20Jane%20Mar%20(128).mp3';
//     const String song4 =
//         'https://dls.music-fa.com/tagdl/ali/Behnam%20Bani%20-%202ta%20Dele%20Ashegh%20(320).mp3';
//     const String song5 =
//         'https://dlmain.gandommusic.ir/mp3/1/Scriptonite%20-%20Dioronabeat%20%D0%BF%D0%BE%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5%20%28%20Remix%20%29%20%28%20GandomMusic.ir%20%29.mp3';
//     return [
//       {
//         'id': '0',
//         //برای اینکه بتونیم از این اطلاعات موزیک رای پخش استفاده کنیم باید  ایدی دااشته باشد
//         'title': 'Diamonds',
//         'artist': 'Rihanna',
//         'artUri': 'assest/images/reyhanna.png',
//         'url': song1
//       },
//       {
//         'id': '1',
//         'title': 'DanceMonkey',
//         'artist': 'Tones and',
//         'artUri': 'assest/images/monkey.jpg',
//         'url': song2
//       },
//       {
//         'id': '2',
//         'title': 'jane mar',
//         'artist': 'iman fallah',
//         'artUri':
//             'https://nex1music.ir/upload/2022-03-08/behnam-bani-baroon-2022-03-08-18-57-43.jpg',
//         'url': song3
//       },
//       {
//         'id': '3',
//         'title': 'DotaDelAshegh',
//         'artist': 'Behnam Bani',
//         'artUri':
//             'https://resanejavan.com/wp-content/uploads/2021/07/Behnam-Bani-Rafti.jpg',
//         'url': song4
//       },
//       {
//         'id': '4',
//         'title': 'положение',
//         'artist': 'dior',
//         'artUri':
//             'https://www.ganja2music.com/Image/Post/10.2020/Behnam%20Bani%20-%20Khoshhalam.jpg',
//         'url': song5
//       },
//     ];
//   }
// }

abstract class PlayListRepository {
  Future<List<Map<String, String>>> fethchPlayList();
}

class MyPlayList extends PlayListRepository {
  @override
  Future<List<Map<String, String>>> fethchPlayList() async {
    const song1 =
        'https://dl.nicmusic.net/nicmusic/020/093/Behnam%20Bani%20-%20Toyi%20Entekhabam.MP3';
    // const song2 =
    //     'https://dl.nicmusic.net/nicmusic/019/086/Behnam%20Bani%20-%20Del%20Nakan.mp3';
    const song3 =
        'https://sv.jenabmusic.com/98/Khordad/23/Behnam%20Bani%20-%20Faghat%20Boro%20-%20128.mp3';
    const song4 =
        'https://dlmoviez.ir/musicisho?path=src/singles/9901/Behnam%20Bani%20-%20Tavagho%20Nadaram.mp3';
    const song5 =
        'https://dl.nicmusic.net/nicmusic/022/011/Behnam%20Bani%20-%20In%20Eshgheh.mp3';
    const song6 =
        'https://dl.nicmusic.net/nicmusic/022/041/Behnam%20Bani%20-%20Khabeto%20Didam.mp3';

    const song7 =
        'https://dl.nicmusic.net/nicmusic/024/064/Behnam%20Bani%20-%20%20Khoshhalam.mp3';
    const song8 =
        'https://dl.nicmusic.net/nicmusic/026/063/Behnam%20Bani%20-%20Rafti.mp3';
    const song9 =
        'https://dl.nicmusic.net/nicmusic/028/085/Behnam%20Bani%20-%20Baroon.mp3';
    const song10 =
        'https://dl.nicmusic.net/nicmusic/018/071/Behnam%20Bani%20-%20Hanooz%20Dooset%20Daram.mp3';
    const song11 =
        'https://dlmain.gandommusic.ir/mp3/1/Scriptonite%20-%20Dioronabeat%20%D0%BF%D0%BE%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5%20%28%20Remix%20%29%20%28%20GandomMusic.ir%20%29.mp3';
    return [
      {
        'id': '0',
        'title': 'Toei Entekhabam',
        'artist': 'Behnam Bani',
        'artUri':
            'https://images.sibche.com/Gb2tiTy3cGmITNOY_ShAKgEjDTR2zPerj1tdBdS6BVQ/rs:fit:256:256:1/g:no/czM6Ly9zaWJjaGUvQXBwbGljYXRpb24vMDAwLzMzOS8wODQvMzM5MDg0L2xvZ28vb3JpZ2luYWwvNjE4MzVhYjExNzJiN2FlZTQ1MWQwMjczN2QxY2YwNzEyY2MwNWI5NGY1YmY3MTkyYTI4MDdjYWJhMDcyZTllYy5wbmc.png',
        'url': song1,
      },
      // {
      //   'id': '1',
      //   'title': 'del Nakan',
      //   'artist': 'Behnam Bani',
      //   'artUri':
      //       'https://sisishoe.com/wp-content/uploads/2019/07/Behnam-Bani-%D8%A8%D9%87%D9%86%D8%A7%D9%85-%D8%A8%D8%A7%D9%86%DB%8C.png',
      //   'url': song2,
      // },
      {
        'id': '2',
        'title': 'Faghat Boro',
        'artist': 'Behnam Bani',
        'artUri': 'https://m.media-amazon.com/images/I/71KrveAo5bL._SS500_.jpg',
        'url': song3,
      },
      {
        'id': '3',
        'title': 'Tavagho Nadaram',
        'artist': 'Behnam Bani',
        'artUri':
            'https://www.shirazsong.in/wp-content/uploads/photo_2019-02-02_20-06-56-450x450.jpg',
        'url': song4,
      },
      {
        'id': '4',
        'title': 'In Eshghe',
        'artist': 'Behnam Bani',
        'artUri':
            'http://rozup.ir/thumbnail/2982056/behnam-bani-in-eshgheh-2019-10-31-20-47-37.png',
        'url': song5,
      },
      {
        'id': '5',
        'title': 'Khabeto Didam',
        'artist': 'Behnam Bani',
        'artUri':
            'https://nex1music.ir/upload/2022-04-27/behnam-bani-khastam-2022-04-27-21-03-08.jpg',
        'url': song6,
      },
      {
        'id': '6',
        'title': 'KhoshHalam',
        'artist': 'Behnam Bani',
        'artUri':
            'https://www.ganja2music.com/Image/Post/10.2020/Behnam%20Bani%20-%20Khoshhalam.jpg',
        'url': song7,
      },
      {
        'id': '7',
        'title': 'Rafti',
        'artist': 'Behnam Bani',
        'artUri':
            'https://resanejavan.com/wp-content/uploads/2021/07/Behnam-Bani-Rafti.jpg',
        'url': song8,
      },
      {
        'id': '8',
        'title': 'Baroon',
        'artist': 'Behnam Bani',
        'artUri':
            'https://nex1music.ir/upload/2022-03-08/behnam-bani-baroon-2022-03-08-18-57-43.jpg',
        'url': song9,
      },
      {
        'id': '9',
        'title': 'Hanooz Doostet Daram',
        'artist': 'Behnam Bani',
        'artUri':
            'https://nex1music.ir/upload/2020-08-20/behnam-bani-bassame-2020-08-20-16-39-42.jpg',
        'url': song10,
      },
      {
        'id': '10',
        'title': 'положение',
        'artist': 'dior',
        'artUri':
            'https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/87/ed/90/87ed905e-24f6-27be-f518-b26d5eebc571/5057827397634.jpg/600x600bf-60.jpg',
        'url': song11
      },
    ];
  }
}
