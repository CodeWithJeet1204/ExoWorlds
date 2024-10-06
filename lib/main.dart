import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:glassmorphism/glassmorphism.dart';

void main() {
  runApp(ExoplanetApp());
}

class ExoplanetApp extends StatefulWidget {
  const ExoplanetApp({Key? key}) : super(key: key);

  @override
  State<ExoplanetApp> createState() => _ExoplanetAppState();
}

class _ExoplanetAppState extends State<ExoplanetApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExoWorlds',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: ExoplanetHomePage(),
    );
  }
}

class ExoplanetHomePage extends StatefulWidget {
  const ExoplanetHomePage({Key? key}) : super(key: key);

  @override
  State<ExoplanetHomePage> createState() => _ExoplanetHomePageState();
}

class _ExoplanetHomePageState extends State<ExoplanetHomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Rotatable3DPlanet(),
                    ),
                    GlassContainer(
                      height: 470,
                      child: InfoSection(
                        title: "What Are Exoplanets?",
                        description:
                            "Exoplanets are planets that orbit stars beyond our solar system. They come in a wide variety of sizes, from gas giants larger than Jupiter to small, rocky worlds. "
                            "Since their discovery in the 1990s, thousands of exoplanets have been found using advanced telescopes. These distant worlds offer new insights into how planetary systems form and evolve. "
                            "Many exoplanets are found in the 'habitable zone' of their stars, where conditions might allow liquid water to exist, making them candidates in the search for life beyond Earth.",
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade700,
                      height: 24,
                    ),
                    Text(
                      'Example',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GlassContainer(
                          width: width * 0.66,
                          height: 120,
                          child: InfoItem(
                            title: 'Name',
                            detail: 'Proxima Centauri B',
                          ),
                        ),
                        GlassContainer(
                          width: width * 0.25,
                          height: 120,
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/5/52/Proxima_Centauri_b.png',
                            width: width * 0.25,
                            height: width * 0.25,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GlassContainer(
                          width: width * 0.466,
                          height: 180,
                          child: InfoItem(
                            title: 'Distance from Earth',
                            detail: '4.24 light-years',
                          ),
                        ),
                        GlassContainer(
                          width: width * 0.466,
                          height: 180,
                          child: InfoItem(
                            title: 'Star',
                            detail: 'Proxima Centauri',
                          ),
                        ),
                      ],
                    ),
                    GlassContainer(
                      height: 300,
                      child: InfoItem(
                        title: 'Planet Info',
                        detail:
                            'Proxima Centauri B is a terrestrial exoplanet that orbits an M-type star. '
                            'It is located in the habitable zone of its star, which may allow for liquid water to exist on its surface.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Rotatable3DPlanet extends StatefulWidget {
  const Rotatable3DPlanet({Key? key}) : super(key: key);

  @override
  _Rotatable3DPlanetState createState() => _Rotatable3DPlanetState();
}

class _Rotatable3DPlanetState extends State<Rotatable3DPlanet> {
  late Object planet;
  Timer? _timer;

  // INIT STATE
  @override
  void initState() {
    super.initState();
    initializePlanet();
  }

  // DISPOSE
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // INITIALIZE PLANET
  void initializePlanet() {
    planet = Object(
      fileName: 'assets/AlienPlanet2.obj',
      scale: Vector3(20, 20, 20),
    );
  }

  // UPDATE PLANET PROPERTIES
  void updatePlanetProperties() {
    _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        planet.rotation.y += 0.25;
      });
      planet.updateTransform();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Cube(
        onSceneCreated: (Scene scene) {
          scene.camera.position.z = 20;
          scene.world.add(planet);
          updatePlanetProperties();
        },
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    Key? key,
    required this.child,
    required this.height,
    this.width,
  }) : super(key: key);

  final Widget child;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: GlassmorphicContainer(
        width: width ?? double.infinity,
        height: height,
        alignment: Alignment.center,
        borderRadius: 20,
        blur: 5,
        border: 1,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.25),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final String title;
  final String detail;

  const InfoItem({Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
