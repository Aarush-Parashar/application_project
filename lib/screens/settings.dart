import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _nameController = TextEditingController(
    text: "John Doe",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "john.doe@example.com",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "1234567890",
  );
  final TextEditingController _bioController = TextEditingController(
    text: "Flutter developer passionate about UI/UX design.",
  );

  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _locationEnabled = true;
  ThemeMode _themeMode = ThemeMode.light;
  String _selectedLanguage = 'English';
  double _textSize = 1.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile & Settings"),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Profile", icon: Icon(Icons.person)),
            Tab(text: "Settings", icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildProfileTab(), _buildSettingsTab()],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: const NetworkImage(
                        'https://via.placeholder.com/120',
                      ),
                      backgroundColor: Colors.grey[200],
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // TODO: Implement image picker
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Image picker functionality will be implemented here',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _nameController.text,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _emailController.text,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildProfileSection("Personal Information", [
            _buildTextField("Full Name", _nameController, Icons.person),
            const SizedBox(height: 16),
            _buildTextField("Email", _emailController, Icons.email),
            const SizedBox(height: 16),
            _buildTextField("Phone", _phoneController, Icons.phone),
            const SizedBox(height: 16),
            _buildTextField(
              "Bio",
              _bioController,
              Icons.info_outline,
              maxLines: 3,
            ),
          ]),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save profile information
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Save Changes", style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingsSection("Appearance", [
            _buildSwitchTile(
              "Dark Mode",
              "Enable dark theme",
              _darkModeEnabled,
              (value) {
                setState(() {
                  _darkModeEnabled = value;
                  _themeMode = value ? ThemeMode.dark : ThemeMode.light;
                });
              },
              Icons.dark_mode,
            ),
            _buildSliderTile("Text Size", "Adjust text scaling", _textSize, (
              value,
            ) {
              setState(() {
                _textSize = value;
              });
            }, Icons.text_fields),
          ]),
          const SizedBox(height: 20),
          _buildSettingsSection("Notifications", [
            _buildSwitchTile(
              "Push Notifications",
              "Enable push notifications",
              _notificationsEnabled,
              (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              Icons.notifications,
            ),
            _buildListTile(
              "Notification Preferences",
              "Customize notification types",
              () {
                // Open notification preferences screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Notification preferences screen will open here',
                    ),
                  ),
                );
              },
              Icons.tune,
            ),
          ]),
          const SizedBox(height: 20),
          _buildSettingsSection("Privacy & Security", [
            _buildSwitchTile(
              "Location Services",
              "Allow app to access your location",
              _locationEnabled,
              (value) {
                setState(() {
                  _locationEnabled = value;
                });
              },
              Icons.location_on,
            ),
            _buildListTile(
              "Change Password",
              "Update your account password",
              () {
                // Open change password screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Change password screen will open here'),
                  ),
                );
              },
              Icons.lock,
            ),
            _buildListTile("Privacy Policy", "Read our privacy policy", () {
              // Open privacy policy
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy policy will open here')),
              );
            }, Icons.policy),
          ]),
          const SizedBox(height: 20),
          _buildSettingsSection("Language & Region", [
            _buildDropdownTile(
              "Language",
              "Change application language",
              _selectedLanguage,
              ["English", "Spanish", "French", "German", "Chinese"],
              (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                }
              },
              Icons.language,
            ),
          ]),
          const SizedBox(height: 20),
          _buildSettingsSection("Help & Support", [
            _buildListTile("Help Center", "Get help with app features", () {
              // Open help center
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help center will open here')),
              );
            }, Icons.help),
            _buildListTile(
              "Contact Support",
              "Reach out to our support team",
              () {
                // Open contact support
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Contact support will open here'),
                  ),
                );
              },
              Icons.support_agent,
            ),
          ]),
          const SizedBox(height: 20),
          _buildSettingsSection("Account", [
            _buildListTile(
              "Delete Account",
              "Permanently remove your account",
              () {
                _showDeleteAccountDialog();
              },
              Icons.delete_forever,
              Colors.red,
            ),
            _buildListTile(
              "Log Out",
              "Sign out of your account",
              () {
                _showLogoutDialog();
              },
              Icons.logout,
              Colors.red,
            ),
          ]),
          const SizedBox(height: 20),
          Center(
            child: Text(
              "App Version 1.0.0",
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing:
          Platform.isIOS
              ? CupertinoSwitch(
                value: value,
                onChanged: onChanged,
                activeColor: Theme.of(context).primaryColor,
              )
              : Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Theme.of(context).primaryColor,
              ),
    );
  }

  Widget _buildListTile(
    String title,
    String subtitle,
    VoidCallback onTap,
    IconData icon, [
    Color? iconColor,
  ]) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    String value,
    List<String> items,
    Function(String?) onChanged,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        underline: Container(),
        items:
            items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
      ),
    );
  }

  Widget _buildSliderTile(
    String title,
    String subtitle,
    double value,
    Function(double) onChanged,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: SizedBox(
        width: 150,
        child: Slider(
          value: value,
          min: 0.8,
          max: 1.2,
          divisions: 8,
          label: value.toStringAsFixed(1) + "x",
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log Out"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform logout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
              },
              child: const Text("Log Out", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text(
            "Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform account deletion
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Account deletion initiated')),
                );
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
