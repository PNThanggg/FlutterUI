import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;
  final double? height;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? bottom;
  final double? opacity;
  final Widget? flexibleSpace;

  const AnimatedAppBar(
      {Key? key, this.title, this.height, this.actions, this.leading, this.opacity, this.flexibleSpace, this.bottom})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  State<AnimatedAppBar> createState() => _AnimatedAppBarState();
}

class _AnimatedAppBarState extends State<AnimatedAppBar> with SingleTickerProviderStateMixin {
  static const Duration duration = Duration(milliseconds: 300);
  bool selected = false;

  double get size => selected ? 160 : 110;

  double get opacity => selected ? 1.0 : 0.0;

  void toggleExpanded() {
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      curve: Curves.ease,
      alignment: Alignment.bottomCenter,
      height: size,
      child: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
        centerTitle: true,
        title: widget.title,
        leading: widget.leading,
        actions: [
          IconButton(
              onPressed: () => toggleExpanded(),
              icon: const Icon(
                Icons.tune_rounded,
              ))
        ],
        flexibleSpace: AnimatedOpacity(
          opacity: opacity,
          duration: duration,
          curve: Curves.ease,
          child: Container(
            padding: const EdgeInsets.only(bottom: 6),
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                      onPressed: () {},
                      child: const Text('ALL', style: TextStyle(color: Colors.white))),
                  IconButton(
                    iconSize: 20,
                    color: Colors.white,
                    icon: const FaIcon(FontAwesomeIcons.video),
                    onPressed: () {},
                  ),
                  IconButton(
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.headphonesSimple)),
                  IconButton(
                      iconSize: 20, color: Colors.white, onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.bookOpen)),
                  IconButton(
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.magnifyingGlass))
                ]),
          ),
        ),
      ),
    );
  }
}
