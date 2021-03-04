import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

void main() => runApp(
  MaterialApp(
    title:"Whether App ",
    home: Home(),
  )
);
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}


class _HomeState extends State<Home> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=Jos,930,234&units=imperial&appid=50b8c076bc863999b357935870e11f14');
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results["wind"]['speed'];
    });
  }

    @override
    void initState(){
      super.initState();
      this.getWeather();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: Center(
              child: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images (24).jpeg'),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 3,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text("currently in Jos, Plateau",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                Text(
                                  temp != null
                                      ? temp.toString() + "\u00B0"
                                      : "loading",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(currently != null
                                      ? currently > toString()
                                      : 'loading',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: ListView(
                                    children: <Widget>[
                                      ListTile(
                                        leading: FaIcon(FontAwesomeIcons
                                            .thermometerHalf),
                                        title: Text("Temperature"),
                                        trailing: Text(temp != null ? temp
                                            .toString() + '\u00B0' : 'loading'),
                                      ),
                                      ListTile(
                                        leading: FaIcon(FontAwesomeIcons.cloud),
                                        title: Text("Weather"),
                                        trailing: Text(description != null
                                            ? description.toString()
                                            : 'loading'),
                                      ),
                                      ListTile(
                                        leading: FaIcon(FontAwesomeIcons.sun),
                                        title: Text('Humidity'),
                                        trailing: Text(humidity != null
                                            ? humidity.toString()
                                            : 'loading'),
                                      ),
                                      ListTile(
                                        leading: FaIcon(FontAwesomeIcons
                                            .wind),
                                        title: Text("Wind Speed"),
                                        trailing: Text(windSpeed != null
                                            ? windSpeed.toString()
                                            : 'loading'),
                                      ),
                                    ]
                                )
                            )
                        )
                      ]
                  )
              )
          )
      );
    }
  }
