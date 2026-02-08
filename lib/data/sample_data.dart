import '../models/machine_model.dart';

final sampleMachines = [
  Machine(
    id: '1',
    name: 'John Deere Tractor',
    image: 'https://i.imgur.com/0XKzn9K.jpg',
    category: 'tractor',
    description: 'Powerful tractor suitable for corn farming.',
    availability: 'Available',
    pricePerDay: 15000,
    pricePerHour: 2500,
    features: ['GPS', 'Fuel Efficient', 'AC Cabin'],
    owner: Owner(
      name: 'Sunil Perera',
      location: 'Anuradhapura',
      phone: '0771234567',
      rating: 4.6,
      totalRentals: 24,
    ),
    specifications: Specifications(
      brand: 'John Deere',
      model: '5050D',
      year: 2022,
      fuelType: 'Diesel',
      horsepower: '50HP',
      capacity: '2 Acres/hr',
    ),
  ),
];