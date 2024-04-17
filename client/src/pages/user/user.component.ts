import { Component, OnInit, AfterViewInit } from '@angular/core';
import Map from 'ol/Map';
import View from 'ol/View';
import { fromLonLat } from 'ol/proj';
import TileLayer from 'ol/layer/Tile';
import OSM from 'ol/source/OSM';
import Feature from 'ol/Feature';
import Point from 'ol/geom/Point';
import VectorSource from 'ol/source/Vector';
import VectorLayer from 'ol/layer/Vector';
import { HttpClient } from '@angular/common/http';
import { Style, Circle, Fill } from 'ol/style';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit, AfterViewInit {
  latitude: number = 0;
  longitude: number = 0;
  routeId: number | undefined;
  departures: any[] = [];
  destinations: any[] = [];
  departId: number | undefined;
  destinationId: number | undefined;
  map: Map | undefined;
  marker: Feature | undefined;
  routes: any;
  pickupDate: string | undefined;

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.initMap();
    this.fetchAndUpdateBusLocation();
  }

  ngAfterViewInit() {
    this.fetchRoutes();
  }

  initMap() {
    this.map = new Map({
      target: 'map',
      layers: [
        new TileLayer({
          source: new OSM()
        })
      ],
      view: new View({
        center: fromLonLat([this.longitude, this.latitude]),
        zoom: 18
      })
    });

    this.marker = new Feature({
      geometry: new Point(fromLonLat([this.longitude, this.latitude]))
    });

    const vectorSource = new VectorSource({
      features: [this.marker]
    });

    const markerLayer = new VectorLayer({
      source: vectorSource
    });

    if (this.map) {
      this.map.addLayer(markerLayer);
    }
  }

  fetchRoutes() {
    const apiUrl = 'http://localhost:3477/route';
    this.http.get(apiUrl).subscribe(
      (data: any) => {
        this.routes = data;
      },
      error => {
        console.error('Error fetching routes:', error);
      }
    );
  }

  fetchDeparturesAndDestinations() {
    if (this.routeId) {
      const apiUrl = `http://localhost:3477/stoppoint/${this.routeId}`;
      this.http.get(apiUrl).subscribe(
        (data: any) => {
          this.departures = data;
          this.destinations = data;
        },
        error => {
          console.error('Error fetching stop points:', error);
        }
      );
    }
  }

  fetchAndUpdateBusLocation() {
    const apiUrl = 'http://localhost:3477/getBusLocation';
    this.http.get(apiUrl).subscribe(
      (data: any) => {
        this.latitude = data.latitude;
        this.longitude = data.longitude;
        this.updateMapMarker();
        setTimeout(() => {
          this.fetchAndUpdateBusLocation();
        }, 5000);
      },
      error => {
        console.error('Error fetching bus location:', error);
        setTimeout(() => {
          this.fetchAndUpdateBusLocation();
        }, 5000);
      }
    );
  }
  isPickupDateValid(pickupDate: string): boolean {
    const selectedDate = new Date(pickupDate).getTime();
    const currentDate = new Date().getTime();
    return selectedDate >= currentDate;
  }

  submitPickup() {
    if (
      this.departId &&
      this.pickupDate &&
      this.routeId &&
      this.destinationId &&
      this.isPickupDateValid(this.pickupDate) // Check if the date is valid
    ) {
      const apiUrl = 'http://localhost:3477/booking';
      const requestData = {
        departId: this.departId,
        destinationId: this.destinationId,
        pickupDate: this.pickupDate,
        routeId: this.routeId
      };

      this.http.post(apiUrl, requestData).subscribe(
        (response: any) => {
          console.log('Booking submitted successfully:', response.message);
          // Refresh the page
          window.location.reload();
        },
        error => {
          console.error('Error submitting booking:', error);
        }
      );
    } else {
      console.error('Invalid departure ID, destination ID, pickup date, or route ID');
      alert("This date its before the today date")
    }
  }


  updateMapMarker() {
    if (this.map && this.marker) {
      const newCoordinates = fromLonLat([this.longitude, this.latitude]);
      const newGeometry = new Point(newCoordinates);

      this.marker.setGeometry(newGeometry);

      const markerStyle = new Style({
        image: new Circle({
          radius: 5,
          fill: new Fill({
            color: 'red'
          })
        })
      });

      this.marker.setStyle(markerStyle);

      this.map.getView().setCenter(newCoordinates);
    }
  }
}
