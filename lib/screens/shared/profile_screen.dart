import 'package:flutter/material.dart';
import 'package:near_fix/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.user, super.key});
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          user == null
              ? Center(child: Text("Log in please"))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: SafeArea(
                  child: Column(
                    children: [
                      const Text(
                        "My Profile",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Color(0xFF4A80F0),
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              user!.fullName,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user!.email,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildProfileOption(
                              context,
                              user!.fullName,
                              Icons.person_outline,
                            ),
                            const Divider(height: 1, indent: 20, endIndent: 20),
                            _buildProfileOption(
                              context,
                              "User Type ${user!.userType}",
                              Icons.verified_user_outlined,
                            ),
                            const Divider(height: 1, indent: 20, endIndent: 20),
                            _buildProfileOption(
                              context,
                              user!.phoneNumber,
                              Icons.phone_outlined,
                            ),
                            const Divider(height: 1, indent: 20, endIndent: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      const SizedBox(height: 24),

                      // Logout Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Handle logout
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.withOpacity(0.1),
                            foregroundColor: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          icon: const Icon(Icons.logout_outlined),
                          label: const Text(
                            "Log Out",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A80F0),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF4A80F0).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xFF4A80F0)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
