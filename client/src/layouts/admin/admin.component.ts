import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {
  users: any[] = [];

  constructor(private http: HttpClient) {}

  ngOnInit(): void {
    this.fetchUsers();
  }

  fetchUsers() {
    const apiUrl = 'http://localhost:3477/api/users';
    fetch(apiUrl)
      .then(response => response.json())
      .then((results: any[]) => { // Explicit type casting to any[]
        console.log(results);
        this.users = results;
      })
      .catch(error => {
        console.error('Error fetching users:', error);
      });
  }


  updateUser(user: any) {
    const apiUrl = `http://localhost:3477/api/users/${user.id}`;
    const updatedUser = {
      email: user.email,
      username: user.username,
      password: user.password,
      active: user.active,
      blocked: user.blocked,
      approved: user.approved,
      levelOfAccess: user.levelOfAccess
    };

    this.http.put(apiUrl, updatedUser).subscribe(
      response => {
        console.log(response);
        this.fetchUsers(); // Refresh the user data after update
      },
      error => {
        console.error('Error updating user:', error);
      }
    );
  }


  toggleValue(user: any, property: string) {
    user[property] = user[property] === 1 ? 0 : 1;
  }

  deleteUser(user: any) {
    const apiUrl = `http://localhost:3477/api/users/${user.id}`;
    this.http.delete(apiUrl).subscribe(
      response => {
        console.log(response);
        this.fetchUsers(); // Refresh the user data after delete
      },
      error => {
        console.error('Error deleting user:', error);
      }
    );
  }
}
