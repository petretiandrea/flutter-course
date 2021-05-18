import 'package:flutter/material.dart';
import 'package:flutter_course_1/widget/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String, bool> filters;
  final void Function(Map<String, bool>) saveFilters;

  FilterScreen(this.filters, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree;
  bool _vegetarian;
  bool _vegan;
  bool _lactoseFree;

  Widget _buildSwitchFilter(
    String title,
    String description,
    bool currentValue,
    void Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: (value) {
        setState(() {
          updateValue(value);
        });
      },
    );
  }

  @override
  void initState() {
    _glutenFree = this.widget.filters['gluten'];
    _lactoseFree = this.widget.filters['lactose'];
    _vegan = this.widget.filters['vegan'];
    _vegetarian = this.widget.filters['vegetarian'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              this.widget.saveFilters({
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian
              });
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Filter your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchFilter(
                  'Gluten-free',
                  'Only include gluten free meals.',
                  _glutenFree,
                  (newValue) => _glutenFree = newValue,
                ),
                _buildSwitchFilter(
                  'Vegetarian',
                  'Only include Vegetarian meals.',
                  _vegetarian,
                  (newValue) => _vegetarian = newValue,
                ),
                _buildSwitchFilter(
                  'Vegan',
                  'Only include Vegan meals.',
                  _vegan,
                  (newValue) => _vegan = newValue,
                ),
                _buildSwitchFilter(
                  'Lactose',
                  'Only include Lactose meals.',
                  _lactoseFree,
                  (newValue) => _lactoseFree = newValue,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
