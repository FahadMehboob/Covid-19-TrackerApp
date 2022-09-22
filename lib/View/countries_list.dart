import 'package:covid_19_tracker_app/Services/states_services.dart';
import 'package:covid_19_tracker_app/View/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countrieslist extends StatefulWidget {
  const Countrieslist({Key? key}) : super(key: key);

  @override
  State<Countrieslist> createState() => _CountrieslistState();
}

class _CountrieslistState extends State<Countrieslist> {
  Statesservices statesservices = Statesservices();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              cursorColor: Colors.white,
              cursorHeight: 20,
              controller: searchController,
              decoration: InputDecoration(
                focusColor: Colors.white,
                contentPadding: const EdgeInsets.all(15),
                hintText: "Search with Country Name",
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesservices.countriesList(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                    height: 50, width: 50, color: Colors.white),
                                title: Container(
                                    height: 10, width: 80, color: Colors.white),
                                subtitle: Container(
                                    height: 10, width: 80, color: Colors.white),
                              ),
                            ],
                          ));
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountryDetailscreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]
                                            ['cases'],
                                        totalDeaths: snapshot.data![index]
                                            ['deaths'],
                                        totalRecovered: snapshot.data![index]
                                            ['recovered'],
                                        active: snapshot.data![index]['active'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        tests: snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                      ),
                                    ));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            ),
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountryDetailscreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]
                                            ['cases'],
                                        totalDeaths: snapshot.data![index]
                                            ['deaths'],
                                        totalRecovered: snapshot.data![index]
                                            ['recovered'],
                                        active: snapshot.data![index]['active'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        tests: snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                      ),
                                    ));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
