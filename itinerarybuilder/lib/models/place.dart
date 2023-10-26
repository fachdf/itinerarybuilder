import 'photo.dart';

class Place {
  int Id;
  String Name;
  String? Address;
  String? Description;
  String? GoogleMapUrl;
  List<Photo>? Photos;

  Place({
    required this.Id,
    required this.Name,
     this.Address,
     this.Description,
     this.GoogleMapUrl,
     this.Photos,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    List<Photo> photos = List<Photo>.from(json['photos'].map((photo) => Photo.fromJson(photo)));
    return Place(
      Id: json['id'],
      Name: json['name'],
      Address: json['address'],
      Description: json['description'],
      GoogleMapUrl: json['googleMapUrl'],
      Photos: photos,
    );
  }
}



// List<City> cityList = [
//   City(
//     name: 'Shibuya',
//     details: 'A district in Tokyo known for its busy pedestrian crossing.',
//     imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/ec/07/79/shibuya-center-town.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/27/e8/a0/meiji-jingu-shrine.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/28/f6/a7/irises.jpg?w=1000&h=-1&s=1'],
//     places: [
//       Place(
//         name: 'Shibuya Crossing',
//         details: 'A famous pedestrian crossing.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/b4/50/7e/shibuya-pedestrian.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/b4/50/7d/shibuya-pedestrian.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/b4/50/7c/shibuya-pedestrian.jpg?w=1000&h=-1&s=1'],
//         price: 0,
//         openDays: 'Every day',
//         openTime: '24 hours',
//       ),
//       Place(
//         name: 'Shibuya Sky',
//         details: 'Where the city lights meet the stars. Observation Deck.',
//         imgUrls: ['https://lh3.googleusercontent.com/p/AF1QipORKnV_HcC6nECamCmZgC-l5Jy_4RXDjqJw4yAr=s680-w680-h510',
//                   'https://lh3.googleusercontent.com/p/AF1QipPXLJMz69A2I_sbd_-gr60E4ys3hkV0m5MQrFe-=s680-w680-h510',
//                   'https://lh3.googleusercontent.com/p/AF1QipPCZmOq6UumUJckbeK_sKHM7glXk0jvUfDDRGo=s680-w680-h510'],
//         price: 2200,
//         openDays: 'Every day',
//         openTime: '9:00 AM - 11:00 PM',
//       ),
//       Place(
//         name: 'Shibuya 109',
//         details: 'The epicenter of Japanese youth fashion.',
//         imgUrls: ['https://lh3.googleusercontent.com/p/AF1QipO2Llj97yOAqJHkamZUXtC3jlGAAESJc1UZYZr1=s680-w680-h510',
//                   'https://lh3.googleusercontent.com/p/AF1QipMT8WWV3M-8CvDCYnTu1lINMwPgP2Plf8x83zbj=s680-w680-h510',
//                   'https://lh3.googleusercontent.com/p/AF1QipPwnLIqkxFdyEloheah3x0CiQzFjOrQVvvDEi-d=s680-w680-h510'],
//         price: 0,
//         openDays: 'Every day',
//         openTime: '9:00 AM - 11:00 PM',
//       ),
//     ],
//   ),
//   City(
//     name: 'Shinjuku',
//     details: 'A ward in Tokyo known for its entertainment and shopping districts.',
//     imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/21/fc/51/photo2jpg.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/16/de/32/ae/caption.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/3e/90/cd/photo1jpg.jpg?w=1000&h=-1&s=1'],
//     places: [
//       Place(
//         name: 'Shinjuku Gyoen National Garden',
//         details: 'A beautiful park in Shinjuku.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/16/de/34/06/caption.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/7c/13/c3/caption.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/62/69/d0/caption.jpg?w=1000&h=-1&s=1'],
//         price: 500,
//         openDays: 'Every day',
//         openTime: '9:00 AM - 4:00 PM',
//       ),
//       Place(
//         name: 'Suga Shrine',
//         details: 'A Shinto shrine famous for its stairs featured in the anime movie "Your Name".',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/40/39/82/caption.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/40/39/81/caption.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/40/39/7f/caption.jpg?w=1000&h=-1&s=1'],
//         price: 0,
//         openDays: 'Every day',
//         openTime: '9:00 AM - 4:00 PM',
//       ),
//       Place(
//         name: 'Tokyo Metropolitan Government Building',
//         details: 'Free Observation Decks in Shinjuku.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/3c/eb/cf/photo1jpg.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/3c/eb/ce/photo0jpg.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/3c/eb/d5/photo7jpg.jpg?w=1000&h=-1&s=1'],
//         price: 0,
//         openDays: 'Monday - Friday',
//         openTime: 'Tokyo Metropolitan Government Building',
//       ),

//     ],
//   ),
//   City(
//     name: 'Saitama',
//     details: 'A prefecture just north of Tokyo.',
//     imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/09/78/f2/caption.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/14/c1/64/caption.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/4b/23/4b/caption.jpg?w=1000&h=-1&s=1'],
//     places: [
//       Place(
//         name: 'Omiya Bonsai Village',
//         details: 'A village dedicated to bonsai trees.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/ab/1f/f6/omiya-bonsai-village.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/ab/20/2e/omiya-bonsai-village.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/ab/20/0d/omiya-bonsai-village.jpg?w=1000&h=-1&s=1'],
//         price: 310,
//         openDays: 'Every Day Except Thursday',
//         openTime: '9:00 AM - 4:00 PM',
//       ),
//       Place(
//         name: 'Omiya Bonsai Village',
//         details: 'Saitama\'s most important Shinto shrine, with a history of over 2,000 years.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/2c/ee/21/photo9jpg.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/2c/ee/20/photo8jpg.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/2c/ee/1d/photo5jpg.jpg?w=1000&h=-1&s=1'],
//         price: 310,
//         openDays: 'Every Day',
//         openTime: '5:00 AM - 6:00 PM',
//       ),
//       Place(
//         name: 'The Railway Museum',
//         details: 'Explore the history and future of Japanese railways.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/da/d6/36/f-400-e5.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/10/55/da/2d/caption.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/da/de/aa/caption.jpg?w=1000&h=-1&s=1'],
//         price: 310,
//         openDays: 'Tuesday - Sunday',
//         openTime: '10:00 AM - 5:00 PM',
//       ),

//     ],

//   ),
//   City(
//     name: 'Harajuku',
//     details: 'A district known for its fashion and youth culture.',
//     imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/3b/79/6d/caption.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1a/6d/1f/ad/laforet-harajuku.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/66/aa/88/caption.jpg?w=1000&h=-1&s=1'],
//     places: [
//       Place(
//         name: 'Takeshita Street',
//         details: 'A popular shopping street in Harajuku.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/b2/63/ac/harajuku-takeshita-dori.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/d9/cb/78/caption.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/98/2c/65/caption.jpg?w=1000&h=-1&s=1'],
//         price: 0,
//         openDays: 'Every day',
//         openTime: '10:00 AM - 8:00 PM',
//       ),
//       Place(
//         name: 'Meiji Shrine',
//         details: 'A Shinto shrine located in a forested area.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/66/aa/3f/caption.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/66/aa/2f/caption.jpg?w=800&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/66/aa/24/caption.jpg?w=1000&h=-1&s=1'],
//         price: 0,
//         openDays: 'Every day',
//         openTime: '5:00 AM - 6:00 PM',
//       ),
//       Place(
//         name: 'Laforet Harajuku',
//         details: 'A shopping complex with trendy fashion.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/20/8d/6f/5.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/03/62/51/11-20.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/44/2a/ee/photo0jpg.jpg?w=1000&h=-1&s=1'],
//         price: 0,
//         openDays: 'Every day',
//         openTime: '11:00 AM - 9:00 PM',
//       ),
//     ],
//   ),
//   City(
//     name: 'Akihabara',
//     details: 'A district known for electronics and anime shops.',
//     imgUrls: ['https://previews.123rf.com/images/oleandra/oleandra1607/oleandra160700328/62960400-akihabara-district-in-tokyo-japan-the-district-is-a-major-shopping-area-for-electronic-computer.jpg',
//               'https://media.artsper.com/artwork/997482_1_l.jpg',
//               'https://tokyo-in-pics.com/wp-content/uploads/2023/08/Akihabara-buildings-at-night.webp'],
//     places: [
//       Place(
//         name: 'Akihabara Electric Town',
//         details: 'A hub for electronics and otaku culture.',
//         imgUrls: ['https://c8.alamy.com/comp/PHN4D4/akihabara-tokyo-electric-town-japan-billboards-PHN4D4.jpg',
//                   'https://c8.alamy.com/comp/PHN4D4/akihabara-tokyo-electric-town-japan-billboards-PHN4D4.jpg',
//                   'https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/03/a0003233/img/basic/a0003233_main.jpg?20220128152200'],
//         price: 0,
//         openDays: 'Every day',
//         openTime: '10:00 AM - 8:00 PM',
//       ),
//       Place(
//         name: 'Maid Cafe',
//         details: 'A cafe where servers dress as maids or anime characters.',
//         imgUrls: ['https://visit-chiyoda.com/wp-content/uploads/2019/08/top.png',
//                   'https://japandeluxetours.com/uploads/2018/06/20180614164239_5b22fd6f434de.jpg', 
//                   'https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/00/a0000048/img/basic/a0000048_main.jpg?20200129100108'],
//         price: 1000,
//         openDays: 'Every day',
//         openTime: '4:00 PM - 11:00 PM',
//       ),
//       Place(
//         name: 'Super Potato',
//         details: 'A retro video game store with a wide selection.',
//         imgUrls: ['https://a3.cdn.japantravel.com/photo/2410-187558/800!/tokyo-super-potato-in-akihabara-187558.jpg',
//                   'https://a3.cdn.japantravel.com/photo/2410-187557/800!/tokyo-super-potato-in-akihabara-187557.jpg',
//                   'https://a3.cdn.japantravel.com/photo/2410-14273/800!/tokyo-super-potato-in-akihabara-14273.jpg'],
//         price: 0,
//         openDays: 'Every day',
//         openTime: '11:00 AM - 8:00 PM',
//       ),
//     ],
//   ),
//   City(
//     name: 'Ueno',
//     details: 'A district known for its cultural attractions.',
//     imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/ea/c5/05/photo1jpg.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/dc/f4/ff/photo4jpg.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/c4/7e/e0/here-below-is-the-entrance.jpg?w=1000&h=-1&s=1'],
//     places: [
//       Place(
//         name: 'Ueno Park',
//         details: 'A large park with museums and a zoo.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/16/d5/e1/ca/20190316-075916-2-largejpg.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/16/d5/e1/c9/20190316-075803-2-largejpg.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/25/04/b4/caption.jpg?w=1000&h=-1&s=1'],
//         price: 500,
//         openDays: 'Every day',
//         openTime: '5:00 AM - 11:00 PM',
//       ),
//       Place(
//         name: 'Tokyo National Museum',
//         details: 'Japan\'s oldest and largest museum.',
//         imgUrls: ['https://lh3.googleusercontent.com/p/AF1QipOdcI0YOhFPXbWougamUKE2GRGPHiXCbqhuzs_D=s680-w680-h510',
//                   'https://lh3.googleusercontent.com/p/AF1QipPAz-VpxkYHzQJ_Ke-nwWocsN1DzAGnXatZF2Ig=s680-w680-h510',
//                   'https://lh3.googleusercontent.com/p/AF1QipNv8ZeqWjnlDITw8Yk6UoTP5uKimEfPaoW4tWRz=s680-w680-h510'],
//         price: 620,
//         openDays: 'Tuesday - Sunday',
//         openTime: '9:30 AM - 5:00 PM',
//       ),
//       Place(
//         name: 'Ameya-Yokocho Market',
//         details: 'A bustling market street with various goods.',
//         imgUrls: ['https://lh3.googleusercontent.com/p/AF1QipPVpi-uePa6fQE9R_Rvn_zFIDzf3qDFQznupCPP=s680-w680-h510',
//                   'https://lh3.googleusercontent.com/p/AF1QipNG-4ffTaxm-15j0_yBtHR64LRz_SgY3atbAHA_=s680-w680-h510',
//                   'https://lh3.googleusercontent.com/p/AF1QipNnvg1_M_ryi9cJR9deiABMGkftixaLY7a3cA9q=s680-w680-h510'],
//         price: 0,
//         openDays: 'Every day',
//         openTime: '10:00 AM - 7:00 PM',
//       ),
//     ],
//   ),
//   City(
//     name: 'Roppongi',
//     details: 'A district known for its nightlife and international atmosphere.',
//     imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/2f/dc/f7/sky-deck.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/0f/28/8c/roppongi-hills.jpg?w=1000&h=-1&s=1',
//               'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/29/21/06/sonidos-bar-roppongi.jpg?w=1000&h=-1&s=1'],
//     places: [
//       Place(
//         name: 'Roppongi Hills',
//         details: 'A modern shopping and entertainment complex.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/da/cc/e9/caption.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/da/cc/80/4-5.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/da/c8/a1/caption.jpg?w=1000&h=-1&s=1'],
//         price: 0,
//         openDays: 'Every day',
//         openTime: '11:00 AM - 9:00 PM',
//       ),
//       Place(
//         name: 'Mori Art Museum',
//         details: 'An art museum with contemporary exhibits.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/93/12/c9/until-october-27th-at.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/df/0d/1d/photo2jpg.jpg?w=1000&h=-1&s=1',
//                   'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/90/e3/02/mori-art-museum.jpg?w=1000&h=-1&s=1'],
//         price: 1800,
//         openDays: 'Every day',
//         openTime: '10:00 AM - 10:00 PM',
//       ),
//       Place(
//         name: 'The National Art Center',
//         details: 'Various nightclubs and bars for nightlife.',
//         imgUrls: ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/ec/ed/55/caption.jpg?w=1000&h=-1&s=1',
//                   'https://lh3.googleusercontent.com/p/AF1QipNepb9EW8XUWXhynsRlB2PyFCLUGP5k4jE5L8pG=s680-w680-h510',
//                   'https://lh3.googleusercontent.com/p/AF1QipMPJ7RYAt-eiJm4Me10pdkYOM1U9PQ2m8AyUEdN=s680-w680-h510'],
//         price: 1000,
//         openDays: 'Every Day',
//         openTime: '9:30 AM - 5:00 PM',
//       ),
//     ],
//     ),

// ];
