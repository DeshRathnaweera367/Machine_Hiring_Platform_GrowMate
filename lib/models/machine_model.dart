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

// Sample data
List<Machine> sampleMachines = [
  Machine(
    id: '1',
    name: 'Tractor 5000',
    category: 'tractor',
    description: 'Powerful tractor for farming and transportation.',
    image: 'https://via.placeholder.com/400x300',
    availability: 'Available',
    pricePerDay: 15000,
    pricePerHour: 1000,
    owner: Owner(
      name: 'Kamal Perera',
      location: 'Anuradhapura',
      phone: '0771234567',
      rating: 4.5,
      totalRentals: 12,
    ),
    specifications: Specifications(
      brand: 'John Deere',
      model: 'JD5000',
      year: 2021,
      fuelType: 'Diesel',
      horsepower: '120HP',
      capacity: '5 Tons',
    ),
    features: ['GPS Enabled', 'Air Conditioning', 'Auto Transmission'],
  ),
  Machine(
    id: '2',
    name: 'Harvester X',
    category: 'harvester',
    description: 'Efficient harvester for all crops.',
    image: 'https://via.placeholder.com/400x300',
    availability: 'Available',
    pricePerDay: 20000,
    pricePerHour: 1500,
    owner: Owner(
      name: 'Sunil Fernando',
      location: 'Matara',
      phone: '0712345678',
      rating: 4.8,
      totalRentals: 20,
    ),
    specifications: Specifications(
      brand: 'Kubota',
      model: 'HBX200',
      year: 2022,
      fuelType: 'Diesel',
      horsepower: '150HP',
    ),
    features: ['Auto Steering', 'Crop Sensor', 'Easy Maintenance'],
  ),
];