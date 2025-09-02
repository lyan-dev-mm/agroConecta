import 'package:flutter/material.dart';
import 'package:agroconecta/modules/home/widgets/create_post_sheet.dart';

class MenuFAB extends StatelessWidget {
  final bool isVisible;

  const MenuFAB({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: isVisible ? Offset.zero : const Offset(0, 2),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: SizedBox.expand(child: ExpandableFab()),
      ),
    );
  }
}

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({super.key});

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  void _toggle() {
    setState(() => _isOpen = !_isOpen);
    _isOpen ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'icon': Icons.post_add,
        'label': 'Publicar',
        'onTap': () {
          _toggle();
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) => const CreatePostSheet(),
          );
        },
      },
      {
        'icon': Icons.connect_without_contact_outlined,
        'label': 'Red de apoyo',
        'onTap': () {
          _toggle();
          Navigator.pushNamed(context, '/red');
        },
      },
      {
        'icon': Icons.content_paste_search_outlined,
        'label': 'Capacitación',
        'onTap': () {
          _toggle();
          Navigator.pushNamed(context, '/capacitacion');
        },
      },
    ];

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        if (_isOpen)
          ...List.generate(actions.length, (i) {
            final action = actions[i];
            return Positioned(
              right: 0,
              bottom: 70.0 * (i + 1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      action['label'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontFamily: 'Iner',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    mini: true,
                    onPressed: action['onTap'],
                    tooltip: action['label'],
                    backgroundColor: Colors.white,
                    elevation: 4,
                    child: Icon(action['icon'], color: Colors.green),
                  ),
                ],
              ),
            );
          }),

        FloatingActionButton(
          onPressed: _toggle,
          backgroundColor: Colors.green,
          elevation: 4,
          child: Icon(
            _isOpen ? Icons.close : Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }
}
