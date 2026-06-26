import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
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
        vertical: 100,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'GET IN TOUCH', title: 'CONTACT'),
          const SizedBox(height: 80),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AnimatedSection(child: _buildContactInfo(context)),
                ),
                const SizedBox(width: 80),
                Expanded(
                  child: AnimatedSection(
                    delay: const Duration(milliseconds: 250),
                    child: _buildContactForm(context),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                AnimatedSection(child: _buildContactInfo(context)),
                const SizedBox(height: 50),
                AnimatedSection(
                  delay: const Duration(milliseconds: 250),
                  child: _buildContactForm(context),
                ),
              ],
            ),
          const SizedBox(height: 100),
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
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppTheme.textPrimary, AppTheme.lavender],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            'LET\'S TALK ABOUT\nYOUR NEXT PROJECT.',
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              color: AppTheme.textPrimary,
              height: 1.2,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 48),
        _buildContactItem('EMAIL', 'aalokdev001@gmail.com', Icons.email_rounded, AppTheme.lavender),
        const SizedBox(height: 28),
        _buildContactItem('PHONE', '+91 8969146258', Icons.phone_rounded, AppTheme.blushPink),
        const SizedBox(height: 28),
        _buildContactItem('LOCATION', 'Bengaluru, India', Icons.location_on_rounded, AppTheme.mintCyan),
        const SizedBox(height: 28),
        _buildContactItem('SOCIALS', 'GitHub • LinkedIn', Icons.share_rounded, AppTheme.softPink),
      ],
    );
  }

  Widget _buildContactItem(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color.withValues(alpha: 0.1),
            border: Border.all(
              color: color.withValues(alpha: 0.25),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
        border: Border.all(
          color: AppTheme.lavender.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lavender.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppTheme.blushPink.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(10, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(context, 'YOUR NAME', Icons.person_rounded),
              const SizedBox(height: 24),
              _buildTextField(context, 'EMAIL ADDRESS', Icons.email_rounded),
              const SizedBox(height: 24),
              _buildTextField(context, 'MESSAGE', Icons.message_rounded, maxLines: 4),
              const SizedBox(height: 32),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            prefixIcon: maxLines == 1
                ? Icon(icon, color: AppTheme.lavender.withValues(alpha: 0.5), size: 20)
                : null,
            filled: true,
            fillColor: AppTheme.scaffoldBg,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFFE8D8FF),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppTheme.lavender,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 2,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppTheme.lavender,
                AppTheme.blushPink,
                AppTheme.mintCyan,
                Colors.transparent,
              ],
            ),
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 20,
          runSpacing: 10,
          children: const [
            Text(
              '© 2026 Aalok Kumar.',
              style: TextStyle(
                color: AppTheme.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Built with Flutter 💜',
              style: TextStyle(
                color: AppTheme.textMuted,
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

/// Cotton candy send button
class _GradientSendButton extends StatefulWidget {
  @override
  State<_GradientSendButton> createState() => _GradientSendButtonState();
}

class _GradientSendButtonState extends State<_GradientSendButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              colors: _isHovered
                  ? [AppTheme.blushPink, AppTheme.lavender]
                  : [AppTheme.lavender, AppTheme.blushPink],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lavender
                    .withValues(alpha: _isHovered ? 0.45 : 0.25),
                blurRadius: _isHovered ? 28 : 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'SEND MESSAGE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
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
