import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _distance = TextEditingController();
  final _price = TextEditingController();
  final _efficiency = TextEditingController();
  double totalFuel = 0;
  double totalMoney = 0;

  bool get calculado {
    if (totalFuel == 0 && totalMoney == 0) return false;
    return true;
  }

  void calcular() {
    final distanceCalc = double.parse(_distance.text);
    final priceCalc = double.parse(_price.text);
    final efficiencyCalc = double.parse(_efficiency.text);

    setState(() {
      totalFuel = distanceCalc / efficiencyCalc;
      totalMoney = totalFuel * priceCalc;
    });

    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
      ),
      body: ListView(
        addAutomaticKeepAlives: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  height: 200,
                ),
              ),
              Padding(
                child: Column(
                  children: <Widget>[
                    Card(
                      color: Theme.of(context).secondaryHeaderColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _distance,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Trip Distance (Km)'),
                        ),
                      ),
                    ),
                    Card(
                      color: Theme.of(context).secondaryHeaderColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _price,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Gas/Fuel Price'),
                        ),
                      ),
                    ),
                    Card(
                      color: Theme.of(context).secondaryHeaderColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _efficiency,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Fuel Efficiency (km/L)'),
                        ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        elevation: 8,
                        color: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text('Calc'),
                        onPressed: calcular,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 50, bottom: 50),
                      child: calculado
                          ? Text(
                              'This trip will require ${totalFuel.toStringAsFixed(2)} liters of fuel, which amounts to a fuel cost of \$${totalMoney.toStringAsFixed(2)}.',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          : null,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
              )
            ],
          ),
        ],
      ),
    );
  }
}
