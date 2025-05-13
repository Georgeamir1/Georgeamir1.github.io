import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import '../config/portfolio_config.dart';
import '../utils/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      // Simulate sending
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isSending = false;
            _nameController.clear();
            _emailController.clear();
            _messageController.clear();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Message sent successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;
    final contactInfo = PortfolioConfig.contact;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, loc, isDark, contactInfo),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;

              return isWide
                  ? _buildWideLayout(
                    context,
                    loc,
                    isDark,
                    primaryColor,
                    contactInfo,
                  )
                  : _buildNarrowLayout(
                    context,
                    loc,
                    isDark,
                    primaryColor,
                    contactInfo,
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
    Map<String, String> contactInfo,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactInfo['title']!,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color:
                isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          contactInfo['subtitle']!,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildWideLayout(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
    Color primaryColor,
    Map<String, String> contactInfo,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _buildContactForm(context, loc, isDark, primaryColor),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: _buildContactInfo(context, isDark, primaryColor, contactInfo),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
    Color primaryColor,
    Map<String, String> contactInfo,
  ) {
    return Column(
      children: [
        _buildContactInfo(context, isDark, primaryColor, contactInfo),
        const SizedBox(height: 40),
        _buildContactForm(context, loc, isDark, primaryColor),
      ],
    );
  }

  Widget _buildContactInfo(
    BuildContext context,
    bool isDark,
    Color primaryColor,
    Map<String, String> contactInfo,
  ) {
    final socialLinks = PortfolioConfig.socialMediaLinks;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get In Touch',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildInfoRow(Icons.email, socialLinks['email']!, primaryColor),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.phone, socialLinks['phone']!, primaryColor),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.location_on,
            contactInfo['location']!,
            primaryColor,
          ),
          const SizedBox(height: 32),
          Text(
            'Social Links',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSocialButton(
                Icons.link,
                'LinkedIn',
                primaryColor,
                () => UrlLauncher.launchUrl(socialLinks['linkedin']!),
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                Icons.code,
                'GitHub',
                primaryColor,
                () => UrlLauncher.launchUrl(socialLinks['github']!),
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                Icons.email,
                'Email',
                primaryColor,
                () => UrlLauncher.launchEmail(socialLinks['email']!),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color primaryColor) {
    return InkWell(
      onTap: () {
        if (icon == Icons.email) {
          UrlLauncher.launchEmail(text);
        } else if (icon == Icons.phone) {
          UrlLauncher.launchPhone(text);
        } else if (icon == Icons.location_on) {
          // Open maps with location
        }
      },
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: SelectableText(text, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    IconData icon,
    String tooltip,
    Color primaryColor,
    VoidCallback onPressed,
  ) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: primaryColor, width: 2),
          ),
          child: Icon(icon, color: primaryColor, size: 24),
        ),
      ),
    );
  }

  Widget _buildContactForm(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
    Color primaryColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(context),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Me A Message',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Your Email',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Your Message',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSending ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child:
                    _isSending
                        ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color:
                                isDark
                                    ? AppTheme.buttonTextColor
                                    : AppTheme.lightButtonTextColor,
                          ),
                        )
                        : Text('Send Message'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
