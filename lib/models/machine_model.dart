class Owner {
  final String name;
  final String location;
  final String phone;
  final double rating;
  final int totalRentals;

  Owner({
    required this.name,
    required this.location,
    required this.phone,
    required this.rating,
    required this.totalRentals,
  });
}

class Specifications {
  final String brand;
  final String model;
  final int year;
  final String fuelType;
  final String? horsepower;
  final String? capacity;

  Specifications({
    required this.brand,
    required this.model,
    required this.year,
    required this.fuelType,
    this.horsepower,
    this.capacity,
  });
}

class Machine {
  final String id;
  final String name;
  final String category;
  final String description;
  final String image;
  final String availability;
  final double pricePerDay;
  final double pricePerHour;
  final Owner owner;
  final Specifications specifications;
  final List<String> features;

  Machine({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.image,
    required this.availability,
    required this.pricePerDay,
    required this.pricePerHour,
    required this.owner,
    required this.specifications,
    required this.features,
  });
}

// =========================
// Sample Data (can be replaced with full 20-machine list)
// =========================
List<Machine> machines = [
  Machine(
    id: '1',
    name: 'Rice Harvester 1000',
    category: 'Rice',
    description: 'Efficient rice harvester for small and medium fields.',
    image: 'rice1.jpg',
    availability: 'Available',
    pricePerDay: 15000,
    pricePerHour: 2000,
    owner: Owner(
      name: 'Kamal Perera',
      location: 'Anuradhapura',
      phone: '0771234567',
      rating: 4.5,
      totalRentals: 12,
    ),
    specifications: Specifications(
      brand: 'John Deere',
      model: 'RH1000',
      year: 2022,
      fuelType: 'Diesel',
      horsepower: '100HP',
      capacity: '1.5 Acres/hr',
    ),
    features: ['GPS Enabled', 'Auto Steering'],
  ),
  Machine(
    id: '2',
    name: 'Rice Harvester 2000',
    category: 'Rice',
    description: 'High capacity rice harvester for large farms.',
    image: 'rice2.jpg',
    availability: 'Available',
    pricePerDay: 20000,
    pricePerHour: 2500,
    owner: Owner(
      name: 'Sunil Fernando',
      location: 'Matara',
      phone: '0712345678',
      rating: 4.8,
      totalRentals: 20,
    ),
    specifications: Specifications(
      brand: 'Kubota',
      model: 'RH2000',
      year: 2023,
      fuelType: 'Diesel',
      horsepower: '120HP',
      capacity: '2 Acres/hr',
    ),
    features: ['Auto Steering', 'Easy Maintenance'],
  ),
];