// This is our data template - like a form that every harvester must fill
class Harvester {
  // Properties (what every harvester MUST have)
  final String id;              // Unique identifier
  final String name;            // Name of the harvester (e.g., "John Deere S780")
  final String ownerName;       // Who owns it
  final String ownerId;         // Owner's unique ID
  final String location;        // Where it's located (Sri Lankan area)
  final String district;        // District in Sri Lanka
  final double pricePerDay;     // Rent per day in LKR (Sri Lankan Rupees)
  final double pricePerHour;    // Rent per hour in LKR
  final double rating;          // Average rating (1-5 stars)
  final String imageUrl;        // Link to photo (just filename for assets/images/)
  final List<String> features;  // List of features (like GPS, AC, etc.)
  final bool isAvailable;       // Is it available for booking?
  final String description;     // Detailed description in English
  final int reviewsCount;       // Number of reviews
  final String machineType;     // Type: 'Corn' or 'Rice'
  final int year;               // Manufacturing year
  final int hoursUsed;          // Total hours used
  final String fuelType;        // Diesel, Petrol, Electric

  // Constructor (how to create a new harvester)
  Harvester({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.ownerId,
    required this.location,
    required this.district,
    required this.pricePerDay,
    required this.pricePerHour,
    required this.rating,
    required this.imageUrl,
    required this.features,
    required this.isAvailable,
    required this.description,
    required this.machineType,
    required this.year,
    required this.hoursUsed,
    required this.fuelType,
    this.reviewsCount = 0,      // Default value if not provided
  });
}

// ============================================
// EXPANDED MOCK DATA - 20 HARVESTERS
// ============================================

List<Harvester> mockHarvesters = [
  // ========== CORN HARVESTERS (10 machines) ==========
  
  // 1. Premium Corn Harvester - Ampara
  Harvester(
    id: 'corn_001',
    name: 'John Deere S790 Corn Special',
    ownerName: 'Kamal Perera',
    ownerId: 'owner_001',
    location: 'Ampara Town',
    district: 'Ampara',
    pricePerDay: 85000,
    pricePerHour: 11000,
    rating: 4.9,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'corn_harvester_1.jpg',
    features: ['8-row corn head', 'GPS Navigation', 'Auto-steer', 'Yield Monitor', 'Climate-controlled cab', 'Corn loss sensors'],
    isAvailable: true,
    description: 'Top quality John Deere S790 corn harvester specially configured for corn harvesting. Features an 8-row corn head, real-time yield monitoring, and automatic calibration for different corn varieties. Perfect for large-scale corn operations in Ampara district.',
    reviewsCount: 42,
    machineType: 'Corn',
    year: 2023,
    hoursUsed: 450,
    fuelType: 'Diesel',
  ),
  
  // 2. Mid-Range Corn Harvester - Monaragala
  Harvester(
    id: 'corn_002',
    name: 'Case IH 9250 Corn Master',
    ownerName: 'Sunil Weerasinghe',
    ownerId: 'owner_002',
    location: 'Monaragala',
    district: 'Monaragala',
    pricePerDay: 72000,
    pricePerHour: 9500,
    rating: 4.7,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'corn_harvester_2.jpg',
    features: ['6-row corn head', 'AFS Connect', '4WD', 'Air Conditioning', 'Auto header height'],
    isAvailable: true,
    description: 'Case IH 9250 corn harvester with 6-row corn head. Excellent fuel efficiency and high capacity. Features AFS Connect telemetry and automatic header height control for clean corn harvesting. Well-maintained machine located in Monaragala.',
    reviewsCount: 28,
    machineType: 'Corn',
    year: 2022,
    hoursUsed: 680,
    fuelType: 'Diesel',
  ),
  
  // 3. New Holland Corn Harvester - Anuradhapura
  Harvester(
    id: 'corn_003',
    name: 'New Holland CR11.90 Corn',
    ownerName: 'Chandana Rathnayake',
    ownerId: 'owner_003',
    location: 'Anuradhapura',
    district: 'Anuradhapura',
    pricePerDay: 78000,
    pricePerHour: 10200,
    rating: 4.8,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'corn_harvester_3.jpg',
    features: ['Twin rotor', 'IntelliSense', '8-row corn head', 'Premium cab', 'Auto header'],
    isAvailable: false,
    description: 'New Holland CR11.90 corn harvester with twin rotor design and IntelliSense automation. Specifically configured for corn with 8-row head. Optimizes settings automatically for different corn moisture levels. Currently booked until next week.',
    reviewsCount: 19,
    machineType: 'Corn',
    year: 2023,
    hoursUsed: 320,
    fuelType: 'Diesel',
  ),
  
  // 4. Budget Corn Harvester - Mahiyanganaya
  Harvester(
    id: 'corn_004',
    name: 'Massey Ferguson 9800 Corn',
    ownerName: 'Hemasiri Bandara',
    ownerId: 'owner_004',
    location: 'Mahiyanganaya',
    district: 'Badulla',
    pricePerDay: 52000,
    pricePerHour: 6800,
    rating: 4.5,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'corn_harvester_4.jpg',
    features: ['4-row corn head', 'Basic GPS', 'Air Conditioning', 'Grain tank 300 bu'],
    isAvailable: true,
    description: 'Reliable and economical Massey Ferguson 9800 corn harvester. Perfect for medium-sized farms in Badulla district. Well-maintained with regular service. 4-row corn head included. Good value for money.',
    reviewsCount: 15,
    machineType: 'Corn',
    year: 2021,
    hoursUsed: 890,
    fuelType: 'Diesel',
  ),
  
  // 5. Claas Corn Harvester - Polonnaruwa
  Harvester(
    id: 'corn_005',
    name: 'Claas Lexion 780 Corn',
    ownerName: 'Siripala Gunasekara',
    ownerId: 'owner_005',
    location: 'Polonnaruwa',
    district: 'Polonnaruwa',
    pricePerDay: 92000,
    pricePerHour: 12000,
    rating: 4.9,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'corn_harvester_5.jpg',
    features: ['12-row corn head', 'CEMOS Auto', '3D cleaning', 'GPS Pilot', 'Camera system'],
    isAvailable: true,
    description: 'Premium Claas Lexion 780 with 12-row corn head. CEMOS automatic optimization system. Camera system for monitoring corn flow. Top efficiency for large corn operations in Polonnaruwa district.',
    reviewsCount: 31,
    machineType: 'Corn',
    year: 2023,
    hoursUsed: 280,
    fuelType: 'Diesel',
  ),
  
  // 6. Small Farm Corn Harvester - Kantale
  Harvester(
    id: 'corn_006',
    name: 'Kubota DC105 Corn',
    ownerName: 'Lalith Kumara',
    ownerId: 'owner_006',
    location: 'Kantale',
    district: 'Trincomalee',
    pricePerDay: 39000,
    pricePerHour: 5200,
    rating: 4.4,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'corn_harvester_6.jpg',
    features: ['2-row corn head', 'Compact size', 'Easy operation', 'Low fuel consumption'],
    isAvailable: true,
    description: 'Compact Kubota DC105 harvester perfect for small corn fields in Trincomalee district. Easy to operate and maintain. Great for beginners or small-scale corn farming. Very fuel efficient.',
    reviewsCount: 12,
    machineType: 'Corn',
    year: 2022,
    hoursUsed: 420,
    fuelType: 'Diesel',
  ),
  
  // 7. High-Tech Corn Harvester - Maha Oya
  Harvester(
    id: 'corn_007',
    name: 'Fendt IDEAL 10T Corn',
    ownerName: 'Dayan Jayawardena',
    ownerId: 'owner_007',
    location: 'Maha Oya',
    district: 'Ampara',
    pricePerDay: 98000,
    pricePerHour: 12800,
    rating: 5.0,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'corn_harvester_7.jpg',
    features: ['10-row corn head', 'IDEALharvest', 'Auto machine setup', 'Smart cab', '4K cameras'],
    isAvailable: true,
    description: 'State-of-the-art Fendt IDEAL with revolutionary IDEALharvest system. Fully automated corn harvesting with machine learning optimization. The future of corn harvesting available in Ampara district.',
    reviewsCount: 8,
    machineType: 'Corn',
    year: 2024,
    hoursUsed: 120,
    fuelType: 'Diesel',
  ),
  
  // 8. Deutz-Fahr Corn Harvester - Welikanda
  Harvester(
    id: 'corn_008',
    name: 'Deutz-Fahr 6090 Corn',
    ownerName: 'Nihal Fernando',
    ownerId: 'owner_008',
    location: 'Welikanda',
    district: 'Polonnaruwa',
    pricePerDay: 63000,
    pricePerHour: 8200,
    rating: 4.6,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'corn_harvester_8.jpg',
    features: ['5-row corn head', 'TopLiner', 'Air conditioning', 'Efficient cleaning'],
    isAvailable: false,
    description: 'Deutz-Fahr 6090 with 5-row corn head. Good balance of power and efficiency. Well-maintained with full service history. Located in Welikanda, Polonnaruwa district. Currently on rent, available next week.',
    reviewsCount: 16,
    machineType: 'Corn',
    year: 2021,
    hoursUsed: 750,
    fuelType: 'Diesel',
  ),
  
  // 9. Challenger Corn Harvester - Dehiattakandiya
  Harvester(
    id: 'corn_009',
    name: 'Challenger 680B Corn',
    ownerName: 'Palitha Samaraweera',
    ownerId: 'owner_009',
    location: 'Dehiattakandiya',
    district: 'Ampara',
    pricePerDay: 68000,
    pricePerHour: 8900,
    rating: 4.7,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'corn_harvester_9.jpg',
    features: ['6-row corn head', 'MagnaTrac', 'Cab comfort', 'Yield tracking'],
    isAvailable: true,
    description: 'Challenger 680B with tracked design for excellent flotation in wet corn fields. 6-row corn head with yield mapping capability. Perfect for Ampara district farms.',
    reviewsCount: 14,
    machineType: 'Corn',
    year: 2022,
    hoursUsed: 560,
    fuelType: 'Diesel',
  ),
  
  // 10. Versatile Corn Harvester - Hingurakgoda
  Harvester(
    id: 'corn_010',
    name: 'Versatile 500 Corn Special',
    ownerName: 'Anura Dissanayake',
    ownerId: 'owner_010',
    location: 'Hingurakgoda',
    district: 'Polonnaruwa',
    pricePerDay: 55000,
    pricePerHour: 7200,
    rating: 4.5,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'corn_harvester_10.jpg',
    features: ['4-row corn head', 'Rotary separator', 'Air conditioned cab', 'Easy controls'],
    isAvailable: true,
    description: 'Versatile 500 corn harvester. Simple, reliable, and effective. Perfect for farms in Polonnaruwa district transitioning to mechanized corn harvesting.',
    reviewsCount: 11,
    machineType: 'Corn',
    year: 2020,
    hoursUsed: 1100,
    fuelType: 'Diesel',
  ),
  
  // ========== RICE HARVESTERS (10 machines) ==========
  
  // 11. Premium Rice Harvester - Anuradhapura
  Harvester(
    id: 'rice_001',
    name: 'John Deere X9 1100 Rice',
    ownerName: 'Somapala Gunawardena',
    ownerId: 'owner_011',
    location: 'Anuradhapura',
    district: 'Anuradhapura',
    pricePerDay: 89000,
    pricePerHour: 11500,
    rating: 4.9,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'rice_harvester_1.jpg',
    features: ['Rice track system', 'Low ground pressure', 'Yield mapping', 'Grain quality sensors', 'Auto-float header'],
    isAvailable: true,
    description: 'Specialized John Deere X9 for rice harvesting with track system for wet paddy fields in Anuradhapura district. Features grain quality sensors to optimize harvest timing and minimize damage.',
    reviewsCount: 36,
    machineType: 'Rice',
    year: 2023,
    hoursUsed: 380,
    fuelType: 'Diesel',
  ),
  
  // 12. Kubota Rice Harvester - Polonnaruwa
  Harvester(
    id: 'rice_002',
    name: 'Kubota DC-120 Rice Pro',
    ownerName: 'H.M. Dharmasena',
    ownerId: 'owner_012',
    location: 'Polonnaruwa',
    district: 'Polonnaruwa',
    pricePerDay: 68000,
    pricePerHour: 8900,
    rating: 4.8,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'rice_harvester_2.jpg',
    features: ['Rice tracks', 'Low damage threshing', 'Auto header', 'Compact design', 'Easy maintenance'],
    isAvailable: true,
    description: 'Kubota DC-120 specifically designed for rice. Low-damage threshing system preserves grain quality. Compact and maneuverable in smaller rice paddies of Polonnaruwa district.',
    reviewsCount: 29,
    machineType: 'Rice',
    year: 2023,
    hoursUsed: 290,
    fuelType: 'Diesel',
  ),
  
  // 13. Iseki Rice Harvester - Ampara
  Harvester(
    id: 'rice_003',
    name: 'Iseki HJ 600 Rice',
    ownerName: 'M.M. Nizam',
    ownerId: 'owner_013',
    location: 'Ampara',
    district: 'Ampara',
    pricePerDay: 59000,
    pricePerHour: 7600,
    rating: 4.7,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'rice_harvester_3.jpg',
    features: ['4-row rice header', 'Rubber tracks', 'Smart threshing', 'Grain tank 1500L'],
    isAvailable: true,
    description: 'Japanese-engineered Iseki HJ 600 for premium rice harvesting. Rubber tracks protect soil structure in wet paddies. Efficient threshing mechanism. Located in Ampara district.',
    reviewsCount: 22,
    machineType: 'Rice',
    year: 2022,
    hoursUsed: 520,
    fuelType: 'Diesel',
  ),
  
  // 14. Yanmar Rice Harvester - Kurunegala
  Harvester(
    id: 'rice_004',
    name: 'Yanmar AW82 Rice Master',
    ownerName: 'Piyasena Karunaratne',
    ownerId: 'owner_014',
    location: 'Kurunegala',
    district: 'Kurunegala',
    pricePerDay: 76000,
    pricePerHour: 9800,
    rating: 4.9,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'rice_harvester_4.jpg',
    features: ['5-row rice header', 'e-CDIS', 'Rice quality sensor', 'Auto leveling', 'Premium cab'],
    isAvailable: false,
    description: 'Yanmar AW82 with e-CDIS intelligent control system. Auto-leveling feature keeps machine stable on uneven terrain. Top choice for premium rice growers in Kurunegala district. Currently booked.',
    reviewsCount: 18,
    machineType: 'Rice',
    year: 2023,
    hoursUsed: 210,
    fuelType: 'Diesel',
  ),
  
  // 15. Case IH Rice Harvester - Mahawilachchiya
  Harvester(
    id: 'rice_005',
    name: 'Case IH 8250 Rice Special',
    ownerName: 'Sarath Kumara',
    ownerId: 'owner_015',
    location: 'Mahawilachchiya',
    district: 'Anuradhapura',
    pricePerDay: 81000,
    pricePerHour: 10500,
    rating: 4.8,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'rice_harvester_5.jpg',
    features: ['Rice tracks', '6-row rice header', 'AFS Harvest Command', 'Grain saving system'],
    isAvailable: true,
    description: 'Case IH 8250 configured for rice with specialized tracks. AFS Harvest Command optimizes settings for rice. Excellent grain saving technology. Available in Mahawilachchiya, Anuradhapura district.',
    reviewsCount: 25,
    machineType: 'Rice',
    year: 2022,
    hoursUsed: 430,
    fuelType: 'Diesel',
  ),
  
  // 16. Small Rice Harvester - Padaviya
  Harvester(
    id: 'rice_006',
    name: 'Mitsubishi Rice King',
    ownerName: 'W.M. Jayatilake',
    ownerId: 'owner_016',
    location: 'Padaviya',
    district: 'Anuradhapura',
    pricePerDay: 46000,
    pricePerHour: 5900,
    rating: 4.5,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'rice_harvester_6.jpg',
    features: ['3-row rice header', 'Compact size', 'Low fuel use', 'Easy operation'],
    isAvailable: true,
    description: 'Small but efficient Mitsubishi rice harvester. Perfect for small to medium rice paddies in Padaviya area. Easy to transport between fields. Good for beginners.',
    reviewsCount: 14,
    machineType: 'Rice',
    year: 2021,
    hoursUsed: 670,
    fuelType: 'Diesel',
  ),
  
  // 17. Claas Rice Harvester - Medawachchiya
  Harvester(
    id: 'rice_007',
    name: 'Claas Tucano 580 Rice',
    ownerName: 'D.M. Pushpakumara',
    ownerId: 'owner_017',
    location: 'Medawachchiya',
    district: 'Anuradhapura',
    pricePerDay: 77000,
    pricePerHour: 10000,
    rating: 4.8,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'rice_harvester_7.jpg',
    features: ['5-row rice header', '3D cleaning system', 'Rice-specific concave', 'Auto pilot'],
    isAvailable: true,
    description: 'Claas Tucano 580 with rice-specific configuration. 3D cleaning system ensures clean rice samples. Low damage rate for premium rice varieties. Located in Medawachchiya.',
    reviewsCount: 20,
    machineType: 'Rice',
    year: 2022,
    hoursUsed: 390,
    fuelType: 'Diesel',
  ),
  
  // 18. New Holland Rice Harvester - Galenbindunuwewa
  Harvester(
    id: 'rice_008',
    name: 'New Holland CR 8.90 Rice',
    ownerName: 'S.M. Herath',
    ownerId: 'owner_018',
    location: 'Galenbindunuwewa',
    district: 'Anuradhapura',
    pricePerDay: 73000,
    pricePerHour: 9400,
    rating: 4.7,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'rice_harvester_8.jpg',
    features: ['Twin rotor rice design', 'Rice tracks', 'Opti-Fan', 'IntelliSense rice'],
    isAvailable: true,
    description: 'New Holland CR 8.90 with twin rotor technology for gentle rice processing. Opti-Fan system automatically adjusts for rice cleaning. Available in Galenbindunuwewa.',
    reviewsCount: 17,
    machineType: 'Rice',
    year: 2022,
    hoursUsed: 480,
    fuelType: 'Diesel',
  ),
  
  // 19. Laverda Rice Harvester - Thambuttegama
  Harvester(
    id: 'rice_009',
    name: 'Laverda M300 Rice',
    ownerName: 'K.D. Ekanayake',
    ownerId: 'owner_019',
    location: 'Thambuttegama',
    district: 'Anuradhapura',
    pricePerDay: 69000,
    pricePerHour: 9000,
    rating: 4.6,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'rice_harvester_9.jpg',
    features: ['4-row rice header', 'Rice-specific rotors', 'Automation system', 'Comfort cab'],
    isAvailable: false,
    description: 'Italian-engineered Laverda M300 for rice. Known for reliability and grain quality. Good choice for medium-sized rice operations in Thambuttegama. Currently on rent.',
    reviewsCount: 13,
    machineType: 'Rice',
    year: 2021,
    hoursUsed: 820,
    fuelType: 'Diesel',
  ),
  
  // 20. Sampo Rice Harvester - Kebithigollewa
  Harvester(
    id: 'rice_010',
    name: 'Sampo Rosenlew Rice',
    ownerName: 'T.B. Tennakoon',
    ownerId: 'owner_020',
    location: 'Kebithigollewa',
    district: 'Anuradhapura',
    pricePerDay: 52000,
    pricePerHour: 6800,
    rating: 4.4,
    // ✅ Using .jpg extension to match actual files
    imageUrl: 'rice_harvester_10.jpg',
    features: ['4-row rice header', 'Reliable design', 'Easy service', 'Good fuel economy'],
    isAvailable: true,
    description: 'Sampo Rosenlew rice harvester. Simple, robust design that just works. Excellent value for money. Well-suited for established rice farmers in Kebithigollewa area.',
    reviewsCount: 11,
    machineType: 'Rice',
    year: 2020,
    hoursUsed: 950,
    fuelType: 'Diesel',
  ),
];

// ============================================
// HELPER FUNCTIONS
// ============================================

List<Harvester> getCornHarvesters() {
  return mockHarvesters.where((h) => h.machineType == 'Corn').toList();
}

List<Harvester> getRiceHarvesters() {
  return mockHarvesters.where((h) => h.machineType == 'Rice').toList();
}

List<Harvester> getAvailableHarvesters() {
  return mockHarvesters.where((h) => h.isAvailable).toList();
}

List<Harvester> getHarvestersByType(String type, {bool onlyAvailable = false}) {
  var filtered = mockHarvesters.where((h) => h.machineType == type);
  if (onlyAvailable) {
    filtered = filtered.where((h) => h.isAvailable);
  }
  return filtered.toList();
}

List<Harvester> getHarvestersByDistrict(String district) {
  return mockHarvesters.where((h) => 
    h.district.toLowerCase() == district.toLowerCase()
  ).toList();
}

List<Harvester> getHarvestersByPriceRange(double minPrice, double maxPrice) {
  return mockHarvesters.where((h) => 
    h.pricePerDay >= minPrice && h.pricePerDay <= maxPrice
  ).toList();
}

List<Harvester> searchHarvesters(String query) {
  if (query.isEmpty) return mockHarvesters;
  return mockHarvesters.where((h) =>
    h.name.toLowerCase().contains(query.toLowerCase()) ||
    h.location.toLowerCase().contains(query.toLowerCase()) ||
    h.district.toLowerCase().contains(query.toLowerCase()) ||
    h.ownerName.toLowerCase().contains(query.toLowerCase())
  ).toList();
}

Map<String, int> getHarvesterCountByDistrict() {
  Map<String, int> countMap = {};
  for (var harvester in mockHarvesters) {
    countMap[harvester.district] = (countMap[harvester.district] ?? 0) + 1;
  }
  return countMap;
}