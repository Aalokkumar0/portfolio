import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 100 : 20,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 30, height: 2, color: theme.colorScheme.primary),
                const SizedBox(width: 15),
                Text(
                  'GET IN TOUCH',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'CONTACT',
              style: TextStyle(
                fontFamily: 'ChelseaMarket',
                fontSize: 80,
                color: Colors.white,
                letterSpacing: 0.5,
                height: 1,
              ),
            ),
            const SizedBox(height: 80),
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildContactInfo(context)),
                  const SizedBox(width: 100),
                  Expanded(child: _buildContactForm(context)),
                ],
              )
            else
              Column(
                children: [
                  _buildContactInfo(context),
                  const SizedBox(height: 60),
                  _buildContactForm(context),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LET\'S TALK ABOUT\nYOUR NEXT PROJECT.',
          style: TextStyle(
            fontFamily: 'ChelseaMarket',
            fontSize: 48,
            color: Colors.white,
            height: 1.1,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 40),
        _buildContactItem(context, 'EMAIL', 'aalok0601@gmail.com', Icons.email_outlined),
        const SizedBox(height: 30),
        _buildContactItem(context, 'LOCATION', 'Bangalore, India', Icons.location_on_outlined),
        const SizedBox(height: 30),
        _buildContactItem(context, 'SOCIALS', 'LinkedIn • GitHub • Twitter', Icons.share_outlined),
      ],
    );
  }

  Widget _buildContactItem(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 24),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('YOUR NAME'),
          const SizedBox(height: 30),
          _buildTextField('EMAIL ADDRESS'),
          const SizedBox(height: 30),
          _buildTextField('MESSAGE', maxLines: 5),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 25),
                shape: const RoundedRectangleBorder(),
              ),
              child: const Text('SEND MESSAGE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ],
    );
  }
}
