import 'package:human_stress_test/providers/drawing_provider.dart';
import 'package:human_stress_test/models/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Palette extends StatelessWidget {
  const Palette(BuildContext context, {super.key});

  // This method builds the Palette widget.
  // It displays a list of tools and colors that the user can select from.
  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, drawingProvider, unchangingChild) => ListView(
        scrollDirection: Axis.vertical,
        children: [
          const DrawerHeader(
            child: Text('Tools and Colors'),
          ),
          // Add missing tools here
          _buildToolButton(
              name: 'Oval',
              icon: Icons.circle,
              tool: Tools.oval,
              provider: drawingProvider),
          _buildToolButton(
              name: 'Rectangle',
              icon: Icons.crop_square,
              tool: Tools.rectangle,
              provider: drawingProvider),
          //_buildToolButton(name: 'Triangle', icon: Icons.change_history, tool: Tools.triangle, provider: drawingProvider),
          const Divider(),
          _buildColorButton('Red', Colors.red, drawingProvider),
          _buildColorButton('Green', Colors.green, drawingProvider),
          // Add more colors here
          _buildColorButton('Blue', Colors.blue, drawingProvider),
          _buildColorButton('Yellow', const Color.fromARGB(255, 251, 205, 68),
              drawingProvider),
        ],
      ),
    );
  }

  // This method builds a button for selecting a tool.
  // parameters:
  // name - the name of the tool
  // icon - the icon to display for the tool
  // tool - the tool to select
  // provider - the DrawingProvider that contains the current tool selected by the user
  Widget _buildToolButton(
      {required String name,
      required IconData icon,
      required Tools tool,
      required DrawingProvider provider}) {
    return Semantics(
      label: name,
      selected: provider.toolSelected == tool,
      child: InkWell(
        onTap: () {
          // if the tool is already selected, set the toolSelected property to Tools.none
          if (provider.toolSelected == tool) {
            provider.toolSelected = Tools.none;
          } else {
            // otherwise, set the toolSelected property to the given tool
            provider.toolSelected = tool;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon),
              if (provider.toolSelected == tool) const Text('Selected'),
            ],
          ),
        ),
      ),
    );
  }

  // This method builds a button for selecting a color.
  // parameters:
  // name - the name of the color
  // color - the color to select
  // provider - the DrawingProvider that contains the current color selected by the user
  Widget _buildColorButton(String name, Color color, DrawingProvider provider) {
    return Semantics(
      label: name,
      selected: provider.colorSelected == color,
      child: InkWell(
        onTap: () {
          // set the colorSelected property of the provider to the given color
          provider.colorSelected = color;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Container(
              width: 50,
              height: 50,
              color: color,
            ),
            if (provider.colorSelected == color) const Text('Selected')
          ]),
        ),
      ),
    );
  }
}
