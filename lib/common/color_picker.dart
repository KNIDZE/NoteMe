import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
 const colors = [
      Color(0xfffdc734),
      Color(0xff34fdc7),
      Color(0xff346afd),
      Color(0xfffd6234),
      Color(0xffc734fd),
      Color(0xffcffd34),
    ];

class ColorPicker extends StatefulWidget {
  const ColorPicker ({super.key, required this.setActiveColor,this.initialColor="4294821684"});
  final Function setActiveColor;
  final String initialColor;
  @override
  State<ColorPicker> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorPicker> {

  
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _selected = colors.indexOf(Color(int.parse(widget.initialColor)));
  }

  void setSelected(int value) {
    setState(() {
      _selected = value;
      // colors[_selected].value - 32 bits color
      widget.setActiveColor(colors[_selected].value.toString());
      
    });
  }

  @override
  Widget build(BuildContext context) {
   

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: colors
            .mapIndexed((index, element) => 
            ColorRadioButton(
              color: element, 
              setThisColor: ()=> setSelected(index),
              showStroke: _selected == index,))
            .toList() as List<Widget>,
      ),
    );
  }
}

class ColorRadioButton extends StatelessWidget {
  const ColorRadioButton({super.key, required this.color,
   required this.setThisColor, required this.showStroke });
  final Color color;
  final Function setThisColor;
  final bool showStroke;
  final double size = 20;
  final double frameSize = 10;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setThisColor();
        },
        child: Container(
          width: size + frameSize,
          height: size + frameSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size + 10),
            color: Color.fromARGB(showStroke? 100: 0, 255, 255, 255),
          ),
          child: Padding(
            padding: EdgeInsets.all(frameSize / 2),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size),
                color: color,
              ),
            ),
          ),
        ));
  }
}
