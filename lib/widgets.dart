import 'package:flutter/material.dart';

const Color activeCardColor = Color(0xFF1E88E5);
const Color cardColor = Color(0xFF37474F);
const Color labelColor = Color(0xFFB0BEC5);

const TextStyle labelStyle = TextStyle(
  fontSize: 18,
  color: labelColor,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.2,
);

const TextStyle numberStyle = TextStyle(
  fontSize: 48,
  fontWeight: FontWeight.w900,
  color: Colors.white,
);

/// Rounded card used for every input section.
class InfoCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback? onTap;

  const InfoCard({
    Key? key,
    required this.child,
    this.color = cardColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Center(child: child),
        ),
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const GenderCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      color: selected ? activeCardColor : cardColor,
      onTap: onTap,
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 80, color: Colors.white),
            const SizedBox(height: 10),
            Text(label.toUpperCase(), style: labelStyle),
          ],
        ),
      ),
    );
  }
}

/// A card with a value that can be changed with + / - buttons,
/// kept within [min] and [max].
class CounterCard extends StatelessWidget {
  final String label;
  final int value;
  final String unit;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const CounterCard({
    Key? key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.unit = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label.toUpperCase(), style: labelStyle),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('$value', style: numberStyle),
                if (unit.isNotEmpty) Text(' $unit', style: labelStyle),
              ],
            ),
            Row(
              children: [
                _RoundButton(
                  icon: Icons.remove,
                  tooltip: 'Decrease $label',
                  onPressed: value > min ? () => onChanged(value - 1) : null,
                ),
                const SizedBox(width: 15),
                _RoundButton(
                  icon: Icons.add,
                  tooltip: 'Increase $label',
                  onPressed: value < max ? () => onChanged(value + 1) : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  const _RoundButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: onPressed == null ? Colors.black26 : Colors.black54,
      constraints: const BoxConstraints.tightFor(width: 48, height: 48),
      child: Tooltip(
        message: tooltip,
        child: Icon(
          icon,
          color: onPressed == null ? Colors.white24 : Colors.white,
        ),
      ),
    );
  }
}

/// Full-width button pinned to the bottom of a screen.
class BottomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const BottomButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: activeCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
