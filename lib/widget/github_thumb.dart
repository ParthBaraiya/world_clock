import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/constants.dart';
import '../service/extension.dart';
import '../values/world_clock_icons.dart';

class GithubThumb extends StatelessWidget {
  const GithubThumb({
    Key? key,
    required this.size,
  })  : assert(size >= 0, 'Size must be > 0.'),
        super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ClipPath(
      clipper: _TriangleClipper(),
      child: GestureDetector(
        onTap: _launch,
        child: SizedBox.square(
          dimension: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.accentBannerColor,
            ),
            child: const Align(
              alignment: Alignment(0.6, -0.5),
              child: Icon(
                WorldClockIcons.github_fill,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launch() async {
    try {
      final uri = Uri.parse(Constants.repositoryUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Can not launch url: $e');
    }
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant _TriangleClipper oldClipper) => false;
}
