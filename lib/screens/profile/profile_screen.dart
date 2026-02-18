import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This screen shows user profile and booking history
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Profile Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.green[100],
                  backgroundImage: const AssetImage('assets/images/profile_placeholder.jpg'),
                  child: const Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kamal Perera',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.email, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            'kamal.perera@gmail.com',
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            '+94 77 123 4567',
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on, size: 12, color: Colors.green[700]),
                            const SizedBox(width: 4),
                            Text(
                              'Farmer - Ampara District',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Stats Cards
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('3', 'Active Bookings', Icons.calendar_today),
                _buildStatCard('12', 'Completed', Icons.check_circle),
                _buildStatCard('4.8', 'Rating', Icons.star),
              ],
            ),
          ),
          
          // My Bookings Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Bookings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to all bookings
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('View all bookings')),
                        );
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildBookingItem(
                  'John Deere S790 - Ampara',
                  'Mar 15 - Mar 20, 2025',
                  'Confirmed',
                  Colors.green,
                  'LKR 425,000',
                ),
                _buildBookingItem(
                  'Kubota DC-120 - Polonnaruwa',
                  'Mar 25 - Mar 28, 2025',
                  'Pending',
                  Colors.orange,
                  'LKR 272,000',
                ),
                _buildBookingItem(
                  'Case IH 9250 - Monaragala',
                  'Feb 10 - Feb 15, 2025',
                  'Completed',
                  Colors.blue,
                  'LKR 360,000',
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          
          // Settings Menu
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildMenuItem(context, Icons.person_outline, 'Edit Profile'),
                _buildMenuItem(context, Icons.notifications_none, 'Notifications'),
                _buildMenuItem(context, Icons.payment, 'Payment Methods'),
                _buildMenuItem(context, Icons.help_outline, 'Help & Support'),
                _buildMenuItem(context, Icons.logout, 'Logout', color: Colors.red, isLast: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build stat cards with icons
  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.green[700],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build booking items
  Widget _buildBookingItem(String title, String dates, String status, Color statusColor, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 12, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          dates,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              Text(
                price,
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper to build menu items
  Widget _buildMenuItem(
    BuildContext context, 
    IconData icon, 
    String title, {
    Color color = Colors.black87, 
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: color),
          title: Text(
            title, 
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios, 
            size: 16, 
            color: Colors.grey[400],
          ),
          onTap: () {
            // Handle menu item tap
            if (title == 'Logout') {
              _showLogoutDialog(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$title tapped'),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
        if (!isLast) const Divider(height: 1, indent: 56),
      ],
    );
  }

  // Logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[700],
              ),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                // Navigate to login screen (you'll implement this later)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('LOGOUT'),
            ),
          ],
        );
      },
    );
  }
}