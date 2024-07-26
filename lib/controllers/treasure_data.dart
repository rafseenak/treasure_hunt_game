class TreasureData {
  final String defaultLanguage = 'മലയാളം';
  final String baseUrl =
      'https://treasure-hunt-backend-vyuu.onrender.com/treasurehunt/';
  final Map<String, Map<String, Map<String, String>>> dictionary = {
    'settings': {
      'English': {'sentence': 'SETTINGS'},
      'മലയാളം': {'sentence': 'സജ്ജീകരണങ്ങൾ'},
      'हिन्दी': {'sentence': 'सेटिंग्स'},
      'தமிழ்': {'sentence': 'அமைப்புகள்'},
    },
    'save': {
      'English': {'sentence': 'SAVE'},
      'മലയാളം': {'sentence': 'സംരക്ഷിക്കുക'},
      'हिन्दी': {'sentence': 'सहेजें'},
      'தமிழ்': {'sentence': 'சேமிக்க'},
    },
    'language': {
      'English': {'sentence': 'LANGUAGE'},
      'മലയാളം': {'sentence': 'ഭാഷ'},
      'हिन्दी': {'sentence': 'भाषा'},
      'தமிழ்': {'sentence': 'மொழி'},
    },
    'logout': {
      'English': {'sentence': 'LOGOUT'},
      'മലയാളം': {'sentence': 'ലോഗൗട്ട്'},
      'हिन्दी': {'sentence': 'लॉग आउट'},
      'தமிழ்': {'sentence': 'வெளியேறு'},
    },
    'start': {
      'English': {'sentence': 'START'},
      'മലയാളം': {'sentence': 'ആരംഭിക്കുക'},
      'हिन्दी': {'sentence': 'शुरू करें'},
      'தமிழ்': {'sentence': 'தொடங்கவும்'},
    },
  };

  List puzzleOneImages = [
    [
      {
        'original': 'assets/images/puzzle_images/road/c1.png',
        'shadow': 'assets/images/puzzle_images/road/cp1.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item1',
        'id': 1
      },
      {
        'original': 'assets/images/puzzle_images/road/c2.png',
        'shadow': 'assets/images/puzzle_images/road/cp2.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item2',
        'id': 2
      },
      {
        'original': 'assets/images/puzzle_images/road/c3.png',
        'shadow': 'assets/images/puzzle_images/road/cp3.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item3',
        'id': 3
      },
    ],
    [
      {
        'original': 'assets/images/puzzle_images/fruits/ip1.png',
        'shadow': 'assets/images/puzzle_images/fruits/i1.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item1',
        'id': 1
      },
      {
        'original': 'assets/images/puzzle_images/fruits/ip2.png',
        'shadow': 'assets/images/puzzle_images/fruits/i2.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item2',
        'id': 2
      },
      {
        'original': 'assets/images/puzzle_images/fruits/ip3.png',
        'shadow': 'assets/images/puzzle_images/fruits/i3.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item3',
        'id': 3
      },
    ],
    [
      {
        'original': 'assets/images/puzzle_images/birds/b1.png',
        'shadow': 'assets/images/puzzle_images/birds/bp1.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item1',
      },
      {
        'original': 'assets/images/puzzle_images/birds/b2.png',
        'shadow': 'assets/images/puzzle_images/birds/bp2.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item2',
      },
      {
        'original': 'assets/images/puzzle_images/birds/b3.png',
        'shadow': 'assets/images/puzzle_images/birds/bp3.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item3',
      },
    ],
    [
      {
        'original': 'assets/images/puzzle_images/animal/a1.png',
        'shadow': 'assets/images/puzzle_images/animal/ap1.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item1',
      },
      {
        'original': 'assets/images/puzzle_images/animal/a2.png',
        'shadow': 'assets/images/puzzle_images/animal/ap2.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item2',
      },
      {
        'original': 'assets/images/puzzle_images/animal/a3.png',
        'shadow': 'assets/images/puzzle_images/animal/ap3.png',
        'dragging': false,
        'isCorrect': false,
        'name': 'item3',
      },
    ],
  ];

  final List allToys = [
    [
      {
        'id': '1',
        'name': 'Toy1',
        'rssi': 'rssi1',
        'image': 'assets/images/c1.png',
        'qr_data': 'C8:2E:18:F7:6E:1E',
      },
      {
        'id': '2',
        'name': 'Toy2',
        'rssi': 'rssi2',
        'image': 'assets/images/c2.png',
        'qr_data': 'D8:BC:38:FB:58:4E',
      },
      {
        'id': '3',
        'name': 'Toy3',
        'rssi': 'rssi3',
        'image': 'assets/images/toy1.png',
        'qr_data': '44:17:93:7C:65:02',
      },
      {
        'id': '4',
        'name': 'Toy4',
        'rssi': 'rssi4',
        'image': 'assets/images/toy2.png',
        'qr_data': '44:17:93:7C:65:02',
      },
    ],
    [
      {
        'id': '1',
        'name': 'Toy1',
        'rssi': 'rssi1',
        'image': 'assets/images/toy1.png',
        'qr_data': 'C8:2E:18:F7:6E:1E',
      },
      {
        'id': '2',
        'name': 'Toy2',
        'rssi': 'rssi2',
        'image': 'assets/images/toy2.png',
        'qr_data': 'D8:BC:38:FB:58:4E',
      },
      {
        'id': '3',
        'name': 'Toy3',
        'rssi': 'rssi3',
        'image': 'assets/images/toy3.png',
        'qr_data': '44:17:93:7C:65:02',
      },
      {
        'id': '4',
        'name': 'Toy4',
        'rssi': 'rssi4',
        'image': 'assets/images/toy4.png',
        'qr_data': '44:17:93:7C:65:02',
      },
    ],
    [
      {
        'id': '1',
        'name': 'Toy1',
        'rssi': 'rssi1',
        'image': 'assets/images/toy1.png',
        'qr_data': 'C8:2E:18:F7:6E:1E',
      },
      {
        'id': '2',
        'name': 'Toy2',
        'rssi': 'rssi2',
        'image': 'assets/images/toy2.png',
        'qr_data': 'D8:BC:38:FB:58:4E',
      },
      {
        'id': '3',
        'name': 'Toy3',
        'rssi': 'rssi3',
        'image': 'assets/images/toy3.png',
        'qr_data': '44:17:93:7C:65:02',
      },
      {
        'id': '4',
        'name': 'Toy4',
        'rssi': 'rssi4',
        'image': 'assets/images/toy4.png',
        'qr_data': '44:17:93:7C:65:02',
      },
    ],
    [
      {
        'id': '1',
        'name': 'Toy1',
        'rssi': 'rssi1',
        'image': 'assets/images/toy1.png',
        'qr_data': 'C8:2E:18:F7:6E:1E',
      },
      {
        'id': '2',
        'name': 'Toy2',
        'rssi': 'rssi2',
        'image': 'assets/images/toy2.png',
        'qr_data': 'D8:BC:38:FB:58:4E',
      },
      {
        'id': '3',
        'name': 'Toy3',
        'rssi': 'rssi3',
        'image': 'assets/images/toy3.png',
        'qr_data': '44:17:93:7C:65:02',
      },
      {
        'id': '4',
        'name': 'Toy4',
        'rssi': 'rssi4',
        'image': 'assets/images/toy4.png',
        'qr_data': '44:17:93:7C:65:02',
      },
    ],
    [
      {
        'id': '1',
        'name': 'Toy1',
        'rssi': 'rssi1',
        'image': 'assets/images/toy1.png',
        'qr_data': 'C8:2E:18:F7:6E:1E',
      },
      {
        'id': '2',
        'name': 'Toy2',
        'rssi': 'rssi2',
        'image': 'assets/images/toy2.png',
        'qr_data': 'D8:BC:38:FB:58:4E',
      },
      {
        'id': '3',
        'name': 'Toy3',
        'rssi': 'rssi3',
        'image': 'assets/images/toy3.png',
        'qr_data': '44:17:93:7C:65:02',
      },
      {
        'id': '4',
        'name': 'Toy4',
        'rssi': 'rssi4',
        'image': 'assets/images/toy4.png',
        'qr_data': '44:17:93:7C:65:02',
      },
    ],
  ];

  TreasureData();
}
