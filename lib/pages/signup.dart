import 'dart:ui'; // Required for ImageFilter.blur and shader-related classes
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  // Helper method for "WELCOME" text
  Widget _buildWelcomeText() {
    const String text = "WELCOME";
    const double fontSize = 48.0; // Big font
    const double strokeWidth = 1; // Outline thickness

    // "WELCOME" - fade starts after 'C' (4th letter), over 'O', 'M', 'E'.
    // Solid portion is roughly 4/7 of the text width.
    const double solidPortionEnd = 5.0 / 7.0;

    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: const [Colors.white, Colors.white, Colors.transparent],
          stops: const [0.0, solidPortionEnd, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold, // Bold makes outlines stand out
          // Consider adding a custom fontFamily: 'YourCoolFont', after adding it to pubspec.yaml
          letterSpacing: 2.0, // A little spacing can look good with outlines
          foreground:
              Paint()
                ..style =
                    PaintingStyle
                        .stroke // Draw only the outline
                ..strokeWidth = strokeWidth
                ..color =
                    Colors
                        .white, // Base color for the outline (though ShaderMask controls visibility)
        ),
      ),
    );
  }

  // Helper method for "to Aether" text
  Widget _buildToAetherText() {
    const double toFontSize = 24.0;
    const double aetherFontSize = 60.0; // Bigger than WELCOME
    const double toStrokeWidth = 1.0;
    final Color aetherColor =
        Colors.deepPurple.shade900; // Theme color from your gradient

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Aligns "to" and "Aether" to the left
      children: [
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                Colors.white,
                Colors.transparent,
              ], // Simple fade for "to"
              stops: const [0.3, 1.0], // Start fade a bit into the text
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
          },
          child: Text(
            "to",
            style: TextStyle(
              fontSize: toFontSize,
              fontWeight: FontWeight.w500, // Medium weight
              // fontFamily: 'YourCoolFont',
              foreground:
                  Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = toStrokeWidth
                    ..color = Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4), // Small space between "to" and "Aether"
        Text(
          "Aether",
          style: TextStyle(
            fontSize: aetherFontSize,
            fontWeight: FontWeight.bold,
            color: aetherColor, // Solid theme color
            // fontFamily: 'YourCoolBoldFont',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.deepPurple.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(), // Pushes content down from the top
              // Logo - Centered
              Center(
                child: Image.asset(
                  'lib/asset/clock.png',
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(height: 32), // Space after logo
              // Aesthetic Text Block - Left Aligned within Padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Left-aligns text elements
                  children: [
                    _buildWelcomeText(),
                    const SizedBox(
                      height: 12,
                    ), // Space between WELCOME and "to Aether"
                    _buildToAetherText(),
                  ],
                ),
              ),
              const Spacer(), // Flexible space
              // Form fields and button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildGlassField(
                      label: 'Email',
                      icon: Icons.email,
                      isPassword: false,
                    ),
                    const SizedBox(height: 16),
                    _buildGlassField(
                      label: 'Password',
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 24),
                    _buildGlassButton(
                      label: 'Sign Up',
                      onPressed: () {
                        // Sign-up logic
                        print('Sign Up button pressed');
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(), // Pushes content up from the bottom
            ],
          ),
        ),
      ),
    );
  }

  // --- Existing Glass Field and Button Methods (unchanged) ---
  Widget _buildGlassField({
    required String label,
    required IconData icon,
    required bool isPassword,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withAlpha(76)),
          ),
          child: TextFormField(
            obscureText: isPassword,
            decoration: InputDecoration(
              icon: Icon(icon, color: Colors.white),
              labelText: label,
              labelStyle: const TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withAlpha(76)),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
