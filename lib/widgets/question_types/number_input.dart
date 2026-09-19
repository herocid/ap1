import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';

/// Eigenes Ziffernfeld statt der Systemtastatur.
///
/// Grund: Auf dem Handy verdeckt die Systemtastatur bei Netzplan-Aufgaben
/// genau die Tabelle, in die man gerade eintraegt - und sie liefert je nach
/// Hersteller mal ein Komma, mal einen Punkt. Das eigene Pad ist flacher,
/// zeigt nur, was gebraucht wird, und laesst die Aufgabe sichtbar.
/// Auf Desktop/Web wird stattdessen direkt getippt.
class NumericKeypad extends StatelessWidget {
  const NumericKeypad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    required this.onClear,
    required this.onDone,
    this.allowDecimal = false,
    this.allowNegative = false,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final VoidCallback onClear;
  final VoidCallback onDone;
  final bool allowDecimal;
  final bool allowNegative;

  @override
  Widget build(BuildContext context) {
    final keys = <String>[
      '1', '2', '3',
      '4', '5', '6',
      '7', '8', '9',
      allowDecimal ? ',' : (allowNegative ? '-' : 'C'),
      '0',
      'DEL',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: Gap.s,
            crossAxisSpacing: Gap.s,
            childAspectRatio: 1.9,
            children: [
              for (final k in keys)
                _Key(
                  label: k,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    switch (k) {
                      case 'DEL':
                        onBackspace();
                      case 'C':
                        onClear();
                      default:
                        onDigit(k);
                    }
                  },
                ),
            ],
          ),
          const SizedBox(height: Gap.m),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: onDone, child: const Text('Fertig')),
          ),
        ],
      ),
    );
  }
}

class _Key extends StatelessWidget {
  const _Key({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isAction = label == 'DEL' || label == 'C';
    return Material(
      color: isAction ? context.c.surfaceAlt : context.scheme.surface,
      borderRadius: BorderRadius.circular(Radii.m),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.m),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.m),
            border: Border.all(color: context.c.border),
          ),
          child: label == 'DEL'
              ? Icon(Icons.backspace_outlined,
                  size: 20, color: context.c.textMuted)
              : Text(label, style: AppType.numeric(size: 20)),
        ),
      ),
    );
  }
}

/// Oeffnet das Ziffernfeld als Bottom Sheet und liefert den eingegebenen Wert.
/// Gibt `null` zurueck, wenn abgebrochen wurde.
Future<String?> showNumericKeypad(
  BuildContext context, {
  required String title,
  String initial = '',
  String? hint,
  bool allowDecimal = false,
  bool allowNegative = false,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      var value = initial;
      return StatefulBuilder(
        builder: (ctx, setSheet) {
          void digit(String d) {
            if (d == '-') {
              setSheet(() => value =
                  value.startsWith('-') ? value.substring(1) : '-$value');
              return;
            }
            if (d == ',' && value.contains(',')) return;
            setSheet(() => value = value + d);
          }

          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(Gap.xl, 0, Gap.xl, Gap.m),
                  child: Column(
                    children: [
                      Text(title, style: ctx.text.titleMedium),
                      if (hint != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          hint,
                          style: ctx.text.labelSmall
                              ?.copyWith(color: ctx.c.textMuted),
                        ),
                      ],
                      const SizedBox(height: Gap.l),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: Gap.l),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ctx.c.surfaceAlt,
                          borderRadius: BorderRadius.circular(Radii.m),
                        ),
                        child: Text(
                          value.isEmpty ? '–' : value,
                          style: AppType.numeric(
                            size: 30,
                            color: value.isEmpty
                                ? ctx.c.textMuted
                                : ctx.scheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                NumericKeypad(
                  allowDecimal: allowDecimal,
                  allowNegative: allowNegative,
                  onDigit: digit,
                  onBackspace: () => setSheet(() {
                    if (value.isNotEmpty) {
                      value = value.substring(0, value.length - 1);
                    }
                  }),
                  onClear: () => setSheet(() => value = ''),
                  onDone: () => Navigator.of(ctx).pop(value),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

/// True, wenn das eigene Ziffernfeld sinnvoller ist als die Systemtastatur.
bool useKeypadLayout(BuildContext context) =>
    MediaQuery.sizeOf(context).width < Breakpoints.compact;

double? parseGermanNumber(String raw) {
  final cleaned = raw.trim().replaceAll('.', '').replaceAll(',', '.');
  if (cleaned.isEmpty || cleaned == '-') return null;
  return double.tryParse(cleaned);
}
