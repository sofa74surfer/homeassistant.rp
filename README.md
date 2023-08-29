# Home Assistant Projekt Rotseepark
Home Assistant Installation für eine Liegenschaft mit verschiedenen Integrationen und Automationen. 

Dieses Projekt umfasst die Integration von verschiedenen technischen Anlagen wie Netzwerk, Heizung, Solar-Log, u.a
für eine Liegenschaft mit 4 Häusern. Ziel ist die Geräteüberwachung und Steuerung zur optimalen Energienutzung. 

Integrationen

* Wärmepumpe 
    * Luxtronik 2.0 (4 Wärmepumpen Alpha Innotec SWP 410H) über Node-Red
* Netzwerk
    * UniFi Network
    * UniFi Protect
* Solaranlagen
    * Solar-Log (4 Installationen)
* Strommessung
    * Hausanschluss 500A Janitza UMG-604 Energie- und Spannungsqualitäts Messgerät
    * Elektromobilität 400A Shelly Pro3 EM Home Relay
* Forecast.Solar
* GWF DR60 über Node-Red
* MyStrom
    * MyStrom Adapter für Ladevorgänge an allgemeinen Einstellhallen Steckdosen (E-Bike, E-Motos, Batterie-Erhaltung, Caravan)
* HACS
    * Zaptec
    * Average Sensor
    * Node-RED Companion
    * Holidays
    * Diverse Frontend Integrationen

Automationen

Eine kleine Auswahl ...

* Heizung
    * Warmwasser Produktion abhängig Solar Prognose und Solar-Strom initiieren
    * Überwachung aller Heizungsparameter und erkennen von Unregelmässigkeiten
    * Warmwasser thermische Desinfektion optimieren
    * Wärmepumpe Verdichterstarts überwachen
* Strom
    * Verbräuche nach Heizung, Warmwasser, E-Mobilität und Häuser aufschlüsseln
    * Solar Stromproduktion auswerten
 
Projekte ...

* Lüftung Keller mit automatischen Klappen ergänzen und abhängig absoluter Luftfeuchtigkeit optimieren
