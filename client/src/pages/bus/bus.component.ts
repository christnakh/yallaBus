import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subscription, interval } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';
interface PeopleCount {
  [key: string]: number;
}

@Component({
  selector: 'app-bus',
  templateUrl: './bus.component.html',
  styleUrls: ['./bus.component.css']
})
export class BusComponent implements OnInit, OnDestroy {
  routeDetails: string = '';
  trafficUpdate: string = '';
  estimatedTime: string = '';
  error: string | undefined;
  latitude: number | undefined;
  longitude: number | undefined;
  routes: any[] = [];
  booking: PeopleCount = {};
  private geolocationSubscription: Subscription | undefined;
  httpClient: any;
  distanceroute: any;
  timeest: any;
  destination:any;
  description: any;

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.startGeolocationRefresh();
    this.fetchData();
  }

  private startGeolocationRefresh() {
    this.geolocationSubscription = interval(1000).subscribe(() => {
      this.getGeolocation();
    });
  }

  ngOnDestroy() {
    if (this.geolocationSubscription) {
      this.geolocationSubscription.unsubscribe();
    }
  }

  refreshRoute() {

    this.fetchData();

    console.log(this.routes);
    console.log(this.booking);

    const existingData = {
     " distanceA": [this.routes[0]],
      "distanceB": [this.routes[1]],
      "distanceC": [this.routes[2]],
      "trafficA": [0],
      "trafficB": [5],
      "trafficC": [10],
      "nbOfUsersA": [this.booking[1]],
      "nbOfUsersB": [this.booking[2]],
      "nbOfUsersC": [this.booking[3]],
    };

    console.log(existingData);

    const url = 'http://192.168.1.109:5001/predict';

    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
    });

    this.http.post(url, existingData, { headers: headers })
      .subscribe(
        (data: any) => {
          this.routeDetails = data.predictions;
            if (this.routeDetails == "Antelias-Tripoli"){
              this.distanceroute =this.routes[0]+ "Km";
              this.timeest = "1:33 mins";
              this.destination = "Antelias";
              this.description = "This is the description of antelias tripolio";
            }
            else if (this.routeDetails == "Khalde-Tyre"){
              this.distanceroute =this.routes[1]+ "Km"
              this.timeest = "1:40 mins "
              this.destination = "Khalde";
              this.description = "this is the description of khalde tyre";
            }
            else if (this.routeDetails == "Hazmieh-Baalbak"){
              this.distanceroute =this.routes[2]+ "Km"
              this.timeest = "1:57 mins"
              this.destination = "Hazmieh";
              this.description = "this the description of hazmieh balbaak";

            }
        },
        (error: any) => {
          console.error('Error:', error);
        }
      );
  }


  fetchData() {
    const routes_url = 'http://localhost:3477/route';
    const booking_url = 'http://localhost:3477/api/predict';

    const currentTime = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

    const windowStart = new Date();
    windowStart.setMinutes(windowStart.getMinutes() - 30);
    const windowEnd = new Date();
    windowEnd.setMinutes(windowEnd.getMinutes() + 30);

    this.http.get<any[]>(routes_url).subscribe(
      (routesData) => {
        this.routes = routesData.map(item => item.Distane);
        console.log('Routes:', this.routes);

        this.http.get<any[]>(booking_url).subscribe(
          (bookingData) => {

            const peopleCount: PeopleCount = {1:0,2:0,3:0};

            bookingData.forEach((bookingItem) => {
              const routeId = bookingItem.routeId;
              const bookingTimeString = bookingItem.pickupdate;

              const bookingTime = new Date(bookingTimeString);

              const bookingTimeHHmm = bookingTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

              if (bookingTime >= windowStart && bookingTime <= windowEnd) {
                if (!peopleCount[routeId]) {
                  peopleCount[routeId] = 0;
                }
                peopleCount[routeId]++;
              }
            });

            this.booking = peopleCount;
            console.log('Booking Data:', this.booking);
          },
          (bookingError) => {
            console.error('Error fetching booking data:', bookingError);
            this.error = 'Error fetching booking data.';
          }
        );
      },
      (routesError) => {
        console.error('Error fetching routes data:', routesError);
        this.error = 'Error fetching routes data.';
      }
    );
  }



  getGeolocation() {
    if ('geolocation' in navigator) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          this.latitude = position.coords.latitude;
          this.longitude = position.coords.longitude;
          const apiUrl = 'http://localhost:3477/updateLocation';
          this.http
            .post(apiUrl, { latitude: this.latitude, longitude: this.longitude })
            .subscribe(
              () => {},
              (error) => {
                console.error('Error sending location data:', error);
                this.error = 'Error sending location data.';
              }
            );
        },
        (error) => {
          console.error('Error getting geolocation:', error);
          this.error = 'Error getting geolocation.';
        }
      );
    } else {
      console.log('Geolocation is not available in this browser.');
      this.error = 'Geolocation is not available in this browser.';
    }
  }
}
