import 'package:covid_19_tracker_app/View/world_states.dart';
import 'package:flutter/material.dart';

class CountryDetailscreen extends StatefulWidget {
  final String name, image;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      tests;
  const CountryDetailscreen({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.tests,
  }) : super(key: key);

  @override
  State<CountryDetailscreen> createState() => _CountryDetailscreenState();
}

class _CountryDetailscreenState extends State<CountryDetailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .050),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .03),
                        ReusuableRow(
                            title: 'Cases',
                            value: widget.totalCases.toString()),
                        ReusuableRow(
                            title: 'Deaths',
                            value: widget.totalDeaths.toString()),
                        ReusuableRow(
                            title: 'Recovered',
                            value: widget.totalRecovered.toString()),
                        ReusuableRow(
                            title: 'Active', value: widget.active.toString()),
                        ReusuableRow(
                            title: 'Critical',
                            value: widget.critical.toString()),
                        ReusuableRow(
                            title: 'Today Recovered',
                            value: widget.todayRecovered.toString()),
                        ReusuableRow(
                            title: 'Tests', value: widget.tests.toString()),
                      ],
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
