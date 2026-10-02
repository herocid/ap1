import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import 'card_back_format.dart';

/// Die Antwort einer Karteikarte, in Absätze gegliedert.
///
/// Der Text selbst bleibt unverändert ([formatCardBack] teilt ihn nur auf):
/// Stichwörter stehen halbfett am Zeilenanfang, Rechenwege abgesetzt in
/// Zahlenschrift, lange Antworten in zwei bis drei Absätzen. Kurze Antworten
/// erscheinen wie bisher als ein Text.
class CardBackText extends StatelessWidget {
  const CardBackText(this.back, {super.key});

  final String back;

  @override
  Widget build(BuildContext context) {
    final base = context.text.bodyLarge;
    final blocks = formatCardBack(back);
    if (blocks.length <= 1 &&
        (blocks.isEmpty ||
            (blocks.first.label == null && !blocks.first.formula))) {
      return Text(back, style: base);
    }
    final mono = AppType.mono(
      size: (base?.fontSize ?? 16) - 1,
      color: context.scheme.onSurface,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < blocks.length; i++) ...[
          if (i > 0) const SizedBox(height: Gap.m),
          _block(context, blocks[i], base, mono),
        ],
      ],
    );
  }

  Widget _block(
    BuildContext context,
    BackBlock block,
    TextStyle? base,
    TextStyle mono,
  ) {
    if (block.label != null) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: block.label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: ' ${block.text}',
              style: block.formula ? mono : null,
            ),
          ],
        ),
        style: base,
      );
    }
    if (block.formula) {
      // Rechenweg als eigener Kasten: so findet das Auge ihn sofort.
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: Gap.m, vertical: Gap.s),
        decoration: BoxDecoration(
          color: context.c.surfaceAlt,
          borderRadius: BorderRadius.circular(Radii.m),
        ),
        child: Text(block.text, style: mono),
      );
    }
    return Text(block.text, style: base);
  }
}
