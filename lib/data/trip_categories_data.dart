// import '../models/category_trip.dart';
// import '../models/trip.dart';

// List<CategoryTrip> tripCategoriesData = [
//   CategoryTrip(
//     id: 'T1',
//     title: 'Muscat',
//     images: 'photos/pgMus.jpg',
//     trips: [
//       Trip(
//         id: 'M1',
//         // categories: [
//         //   'T1',
//         // ],
//         title: 'Sultan Qaboos Grand Mosque, Muscat',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/muscat/m1.jpg',
//         duration: 1,
//         activities: [
//           'Walking around the Sultan Qaboos Mosque and its green courtyards, and taking memorial photos next to its fountains and picturesque flowers.',
//           'Enjoy watching the dome of the Sultan Qaboos Grand Mosque from the inside and its unique decorations.',
//           'A tour of the prayer halls in the mosque, in which the beauty of the ancient Islamic architecture and interior decorations emerge.',
//         ],
//         program: ['sdhajkasj', 'shdhsd,hasj'],
//       ),
//       Trip(
//         id: 'M2',
//         // categories: [
//         //   'T1',
//         // ],
//         title: 'Suq Mutrah',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/muscat/m2.jpg',
//         duration: 1,
//         activities: [
//           'Sopping',
//           'See the Muttrah Corniche',
//         ],
//         program: [],
//       ),
//       Trip(
//         id: 'M3',
//         // categories: [
//         //   'T1',
//         // ],
//         title: 'Jalali Castle',
//         tripType: tripTypesMap[TripType.Exploration]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/muscat/m3.jpg',
//         duration: 1,
//         activities: [],
//         program: [],
//       ),
//       Trip(
//         id: 'M4',
//         // categories: [
//         //   'T1',
//         // ],
//         title: 'Royal Opera House',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/muscat/m4.jpg',
//         duration: 1,
//         activities: [
//           'Visiting the Grand Theater, in which a group of distinguished concerts and many wonderful artistic performances',
//           'Enjoying music and seeing opera shows',
//           'fancy restaurant',
//         ],
//         program: [],
//       ),
//     ],
//   ),
//   CategoryTrip(
//     id: 'T2',
//     title: 'Musandam',
//     images: 'photos/pgMusa.jpg',
//     trips: [
//       Trip(
//         id: 'M5',
//         // categories: [
//         //   'T2',
//         // ],
//         title: 'Khasab Castle',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/musandam/m1.jpg',
//         duration: 1,
//         activities: [],
//         program: [],
//       ),
//       Trip(
//         id: 'M6',
//         // categories: [
//         //   'T2',
//         // ],
//         title: 'Telegraph Island',
//         tripType: tripTypesMap[TripType.Exploration]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/musandam/m2.jpg',
//         duration: 1,
//         activities: [
//           'Boat tour',
//           'Watching dolphins and huge mountain slopes',
//           'Swimming with dolphins',
//           'Watching the ancient villages scattered on the Omani coast',
//         ],
//         program: [],
//       ),
//       Trip(
//         id: 'M7',
//         // categories: [
//         //   'T2',
//         // ],
//         title: 'Harem Mountain',
//         tripType: tripTypesMap[TripType.Exploration]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/musandam/m3.jpg',
//         duration: 1,
//         activities: [
//           'The highest peak in Musandam',
//           'Watching its rocks are studded with well-preserved fossils',
//         ],
//         program: [],
//       ),
//     ],
//   ),
//   CategoryTrip(
//     id: 'T3',
//     title: 'Salalah',
//     images: 'photos/pgSAL.jpg',
//     trips: [
//       Trip(
//         id: 'M8',
//         // categories: [
//         //   'T3',
//         // ],
//         title: 'Wadi Darbat',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/salalah/s1.jpg',
//         duration: 2,
//         activities: [
//           'A picnic in the natural park',
//           'A picnic in the lake by boat',
//           'Barbecue parties in the middle of nature and fresh air',
//         ],
//         program: [],
//       ),
//       Trip(
//         id: 'M9',
//         // categories: [
//         //   'T3',
//         // ],
//         title: 'Ain Razat',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/salalah/s2.jpg',
//         duration: 1,
//         activities: [
//           'Rent a small boat and take a stroll inside Al Ain',
//           'Hiking and walking on Ain Al-Razzat',
//           'Entrance to Al-Razzat Cave and the caves surrounding Al-Ain',
//         ],
//         program: [],
//       ),
//       Trip(
//         id: 'M10',
//         // categories: [
//         //   'T3',
//         // ],
//         title: 'The ancient city of Sumhuram',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/salalah/s3.jpg',
//         duration: 2,
//         activities: [
//           'Watch the stone reliefs, ancient buildings, castle and temple',
//           'Khor Rori sea view',
//         ],
//         program: [],
//       ),
//       Trip(
//         id: 'M11',
//         // categories: [
//         //   'T3',
//         // ],
//         title: 'Al Marneef Cave',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/salalah/s4.jpg',
//         duration: 1,
//         activities: [
//           'Hiking at the cave and enjoying the beauty of the landscape',
//           'Visit the natural fountains that pump the waters of the Arabian Sea through the rocky cavity',
//         ],
//         program: [],
//       ),
//     ],
//   ),
//   CategoryTrip(
//     id: 'T4',
//     title: 'Nizwa',
//     images: 'photos/pgNiz.jpg',
//     trips: [
//       Trip(
//         id: 'M12',
//         // categories: [
//         //   'T4',
//         // ],
//         title: 'jabal al akhdar',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Winter]!,
//         images: 'photos/nizwa/n1.jpg',
//         duration: 2,
//         activities: [
//           'Exploration tour',
//         ],
//         program: [],
//       ),
//       Trip(
//         id: 'M13',
//         // categories: [
//         //   'T4',
//         // ],
//         title: 'Jabal Shams',
//         tripType: tripTypesMap[TripType.Exploration]!,
//         season: seasonMap[Season.Winter]!,
//         images: 'photos/nizwa/n2.jpg',
//         duration: 2,
//         activities: [
//           'Exploration tour',
//         ],
//         program: [],
//       ),
//       Trip(
//         id: 'M14',
//         // categories: [
//         //   'T4',
//         // ],
//         title: 'Wadi Tanuf',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Winter]!,
//         images: 'photos/nizwa/n3.jpg',
//         duration: 1,
//         activities: [],
//         program: [],
//       ),
//     ],
//   ),
//   CategoryTrip(
//     id: 'T5',
//     title: 'Masirah\n  Island',
//     images: 'photos/pgMase.jpg',
//     trips: [
//       Trip(
//         id: 'M16',
//         // categories: [
//         //   'T5',
//         // ],
//         title: 'Masirah',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Winter]!,
//         images: 'photos/masirah/m1.jpg',
//         duration: 3,
//         activities: [],
//         program: [],
//       ),
//     ],
//   ),
//   CategoryTrip(
//     id: 'T6',
//     title: 'Al Sharqia',
//     images: 'photos/pgAlsha.jpg',
//     trips: [
//       Trip(
//         id: 'M19',
//         // categories: [
//         //   'T6',
//         // ],
//         title: 'alhadu',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/sharqia/s3.jpg',
//         duration: 1,
//         activities: [
//           'Green turtle nesting reserve',
//         ],
//         program: [],
//       ),
//       Trip(
//         id: 'M17',
//         // categories: [
//         //   'T6',
//         // ],
//         title: 'Bidiyah',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/sharqia/s1.jpg',
//         duration: 2,
//         activities: [
//           'Stay on desert camps',
//           'catching the sun rise',
//           'Motorcycle driving',
//         ],
//         program: [],
//       ),
//       Trip(
//         id: 'M18',
//         // categories: [
//         //   'T6',
//         // ],
//         title: 'Wadi Stars',
//         tripType: tripTypesMap[TripType.Activities]!,
//         season: seasonMap[Season.Autumn]!,
//         images: 'photos/sharqia/s2.jpg',
//         duration: 1,
//         activities: [
//           'Swimming',
//         ],
//         program: [],
//       ),
//     ],
//   ),
// ];
