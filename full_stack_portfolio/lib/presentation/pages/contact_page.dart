import 'dart:ui';
import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/section_header.dart';
import '../widgets/animated_section.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 120,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'GET IN TOUCH', title: 'CONTACT'),
          const SizedBox(height: 100),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AnimatedSection(child: _buildContactInfo(context)),
                ),
                const SizedBox(width: 100),
                Expanded(
                  child: AnimatedSection(
                    delay: const Duration(milliseconds: 300),
                    child: _buildContactForm(context),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                AnimatedSection(child: _buildContactInfo(context)),
                const SizedBox(height: 60),
                AnimatedSection(
                  delay: const Duration(milliseconds: 300),
                  child: _buildContactForm(context),
                ),
              ],
            ),
          const SizedBox(height: 120),
          // Footer
          AnimatedSection(
            child: _buildFooter(context),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withValues(alpha: 0.7),
            ],
          ).createShader(bounds),
          child: const Text(
            'LET\'S TALK ABOUT\nYOUR NEXT PROJECT.',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.15,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 50),
        _buildContactItem(context, 'EMAIL', 'aalokdev001@gmail.com', Icons.email_rounded),
        const SizedBox(height: 35),
        _buildContactItem(context, 'PHONE', '+91 8969146258', Icons.phone_rounded),
        const SizedBox(height: 35),
        _buildContactItem(context, 'LOCATION', 'Bengaluru, India', Icons.location_on_rounded),
        const SizedBox(height: 35),
        _buildContactItem(context, 'SOCIALS', 'GitHub • LinkedIn', Icons.share_rounded),
      ],
    );
  }

  Widget _buildContactItem(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.1),
                theme.colorScheme.secondary.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Icon(icon, color: theme.colorScheme.primary, size: 22),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.04),
            Colors.white.withValues(alpha: 0.01),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(context, 'YOUR NAME', Icons.person_rounded),
              const SizedBox(height: 28),
              _buildTextField(context, 'EMAIL ADDRESS', Icons.email_rounded),
              const SizedBox(height: 28),
              _buildTextField(context, 'MESSAGE', Icons.message_rounded, maxLines: 4),
              const SizedBox(height: 40),
              // Gradient send button
              SizedBox(
                width: double.infinity,
                child: _GradientSendButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, IconData icon, {int maxLines = 1}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.3),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            prefixIcon: maxLines == 1
                ? Icon(icon, color: Colors.white.withValues(alpha: 0.2), size: 20)
                : null,
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.03),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                theme.colorScheme.primary.withValues(alpha: 0.2),
                theme.colorScheme.secondary.withValues(alpha: 0.15),
                Colors.transparent,
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 20,
          runSpacing: 10,
          children: [
            Text(
              '© 2026 Aalok Kumar.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Built with Flutter 💙',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Gradient send button with hover effect
class _GradientSendButton extends StatefulWidget {
  @override
  State<_GradientSendButton> createState() => _GradientSendButtonState();
}

class _GradientSendButtonState extends State<_GradientSendButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              colors: _isHovered
                  ? [
                      theme.colorScheme.secondary,
                      theme.colorScheme.primary,
                    ]
                  : [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary
                    .withValues(alpha: _isHovered ? 0.4 : 0.2),
                blurRadius: _isHovered ? 30 : 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'SEND MESSAGE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
