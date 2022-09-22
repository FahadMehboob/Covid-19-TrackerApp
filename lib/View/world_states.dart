import 'package:covid_19_tracker_app/Model/worldstatesmodel.dart';
import 'package:covid_19_tracker_app/Services/states_services.dart';
import 'package:covid_19_tracker_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesscreen extends StatefulWidget {
  const WorldStatesscreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesscreen> createState() => _WorldStatesscreenState();
}

class _WorldStatesscreenState extends State<WorldStatesscreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    Statesservices statesservices = Statesservices();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                FutureBuilder(
                  future: statesservices.worldstates(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ));
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              'Total': double.parse(
                                  snapshot.data!.cases!.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered!.toString()),
                              'Deaths': double.parse(
                                  snapshot.data!.deaths!.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    ReusuableRow(
                                        title: 'Total Cases',
                                        value:
                                            snapshot.data!.cases!.toString()),
                                    ReusuableRow(
                                        title: 'Population',
                                        value: snapshot.data!.population!
                                            .toString()),
                                    ReusuableRow(
                                        title: 'Active',
                                        value:
                                            snapshot.data!.active!.toString()),
                                    ReusuableRow(
                                        title: 'Critical',
                                        value: snapshot.data!.critical!
                                            .toString()),
                                    ReusuableRow(
                                        title: 'Test',
                                        value:
                                            snapshot.data!.tests!.toString()),
                                    ReusuableRow(
                                        title: 'Deaths',
                                        value:
                                            snapshot.data!.deaths!.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Countrieslist(),
                                    ));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff1aa260),
                                ),
                                child: const Center(
                                    child: Text("Track Countries")),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusuableRow extends StatelessWidget {
  final String title, value;
  const ReusuableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), Text(value)]),
          const SizedBox(height: 5),
          const Divider()
        ],
      ),
    );
  }
}
