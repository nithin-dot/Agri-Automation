import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Service {
  Service({
    @required this.icon,
  });

  IconData icon;
  static getHomeService(roomIcon) {
    List<Service> services = [
      Service(icon: FontAwesomeIcons.water),
      Service(icon: FontAwesomeIcons.seedling),
      Service(icon: Icons.camera),
      Service(icon: Icons.notifications_active),
      Service(icon: FontAwesomeIcons.phoenixFramework),
      Service(icon: FontAwesomeIcons.cloudRain),
      Service(icon: FontAwesomeIcons.newspaper),
      Service(icon: Icons.agriculture),
      Service(icon: Icons.amp_stories_rounded),
      Service(icon: Icons.monetization_on),
      Service(icon: FontAwesomeIcons.pastafarianism),
    ];
    if (roomIcon == "Drone") {
      return services[4].icon;
    }
    if (roomIcon == "Irrigation") {
      return services[1].icon;
    }
    if (roomIcon == "Plant Disease") {
      return services[2].icon;
    }
    if (roomIcon == "Crop Growth") {
      return services[7].icon;
    }
    if (roomIcon == "Live Stock") {
      return services[10].icon;
    }

    if (roomIcon == "Weather") {
      return services[5].icon;
    }
    if (roomIcon == "Crop Price") {
      return services[9].icon;
    }
    if (roomIcon == "Animal") {
      return services[3].icon;
    }
    if (roomIcon == "Crop Guidance") {
      return services[8].icon;
    }
    if (roomIcon == "Crop News") {
      return services[6].icon;
    } else {
      return services[1].icon;
    }
  }
}
