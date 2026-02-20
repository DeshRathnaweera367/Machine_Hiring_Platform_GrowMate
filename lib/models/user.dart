// Simple user model for the app
class User {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;

  const User({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
  });
}

// Temporary current user (you'll replace this with actual login later)
const User currentUser = User(
  name: 'Kamal Perera',
  email: 'kamal.perera@gmail.com',
  phone: '0771234567',
  address: 'Ampara',
  city: 'Ampara',
);