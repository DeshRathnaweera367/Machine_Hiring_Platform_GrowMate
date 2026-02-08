import '../models/machine_model.dart';

final List<Machine> machines = [
  Machine(
    id: '1',
    name: 'Mini Excavator',
    category: 'Excavator',
    description: 'A compact excavator suitable for small scale digging projects.',
    image: 'https://i.imgur.com/1JYt4mX.jpg',
    availability: 'Available',
    pricePerDay: 12000,
    pricePerHour: 1500,
    owner: Owner(
      name: 'Sunil Perera',
      location: 'Anuradhapura',
      phone: '0771234567',
      rating: 4.5,
      totalRentals: 12,
    ),
    specifications: Specifications(
      brand: 'Hitachi',
      model: 'ZX20',
      year: 2020,          // use int here
      horsepower: '20 HP',
      fuelType: 'Diesel',
      capacity: null,      // optional, can be null
    ),
    features: ['GPS Tracking', 'Low Fuel Consumption', 'Compact Size'],
  ),
  Machine(
    id: '2',
    name: 'Tractor 4WD',
    category: 'Tractor',
    description: 'Powerful 4WD tractor for farming and hauling.',
    image: 'https://i.imgur.com/ZbJmP0E.jpg',
    availability: 'Available',
    pricePerDay: 20000,
    pricePerHour: 2500,
    owner: Owner(
      name: 'Nimal Silva',
      location: 'Kurunegala',
      phone: '0719876543',
      rating: 4.8,
      totalRentals: 25,
    ),
    specifications: Specifications(
      brand: 'John Deere',
      model: '5055E',
      year: 2021,          // int
      horsepower: '55 HP',
      fuelType: 'Diesel',
      capacity: null,
    ),
    features: ['4WD', 'Air-conditioned cabin', 'Hydraulic Lift'],
  ),
];