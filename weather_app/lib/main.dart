import 'dart:convert';
import 'dart:ui';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,

  ));
}



TextEditingController searchController = new TextEditingController();
var seachedByCity = false;
var apiKey = '4e690fe028875d0bdf8fccf547643e0d';
var description;
var maxTemp;
var minTemp;
var temp;
var pressure;
var humidity;
var cityName;
var country;
var windSpeed;
var cityNameCtrl;
var count = 1;
var icon_url;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    fetchData();
    fetchData();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          controller: searchController,
          style: TextStyle(fontSize: 18, fontFamily: 'Lato-Bold'),
          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: () {
                setState(() {
                  getWeatherByCity();
                });
              },
              icon: Icon(
                Icons.search,
                size: 26,
                color: Colors.black,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(60.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(
              color: Colors.grey[800],
              fontFamily: 'Lato-Bold',
              fontSize: 18,
            ),
            hintText: "Search by a city",
            fillColor: Colors.white70,
          ),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              size: 26.0,
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(children: [
          Image.asset(
            'assets/images/rainy.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
          ),
          Container(
            margin: EdgeInsets.only(top: 85),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
              child: Container(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: Text(
                                '$cityName , $country',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: 'Lato-Bold',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: IconButton(
                              onPressed: () {
                              },
                              icon: Icon(Icons.location_on),
                              iconSize: 40,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                '$temp' + '°',
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontFamily: 'Lato-Bold'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Icon(
                          Icons.wb_cloudy_outlined,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            '$minTemp ° | $maxTemp °  $description',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'Lato-Bold'),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'pressure',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Lato-Bold',
                                  ),
                                ),
                                Text(
                                  '$pressure',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Lato-Bold',
                                  ),
                                ),
                                Text(
                                  'mb',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Lato-Bold',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'wind',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Lato-Bold',
                                  ),
                                ),
                                Text(
                                  '$windSpeed',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Lato-Bold',
                                  ),
                                ),
                                Text(
                                  'km/h',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Lato-Bold',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'humidity',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Lato-Bold',
                                  ),
                                ),
                                Text(
                                  '$humidity ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Lato-Bold',
                                  ),
                                ),
                                Text(
                                  '%',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Lato-Bold',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: FlatButton(
                          child: Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 40,
                          ),
                          color: Colors.transparent,
                          onPressed: () {
                            setState(
                              () {
                                fetchData();
                                fetchData();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}


double longitude = 31.044965599999998;
double latitude = -29.8436578;

Future<void> fetchData() async {
  var searchTxt = searchController.text.toLowerCase();
  var apiUrl =
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
  if (seachedByCity) {
    apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$searchTxt&appid=$apiKey&units=metric';
    seachedByCity = false;
  } else {
    await getCurrentUserLocation();
  }
  http.Response response = await http.get(apiUrl);
  if (response.statusCode == 200) {
    String data = response.body;
    var decodedData = jsonDecode(data);

    description = decodedData['weather'][0]['description'];
    temp = decodedData['main']['temp'];
    maxTemp = decodedData['main']['temp_max'];
    minTemp = decodedData['main']['temp_min'];
    pressure = decodedData['main']['pressure'];
    humidity = decodedData['main']['humidity'];
    cityName = decodedData['name'];
    windSpeed = decodedData['wind']['speed'];
    country = decodedData['sys']['country'];

  } else {
    print(response.statusCode);
  }
}

void getCurrentUserLocation() async {
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);

  latitude = position.latitude;
  longitude = position.longitude;

  print("latitude : " +
      latitude.toString() +
      "\n longitude : " +
      longitude.toString());
}

getWeatherByCity() {
  seachedByCity = true;
  fetchData();
}


showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget okButton = FlatButton(
    child: Text("okay!"),
    onPressed:  () {
      fetchData();
    },
  );


  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Please refresh the page!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
