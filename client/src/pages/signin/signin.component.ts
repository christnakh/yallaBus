import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-signin',
  templateUrl: './signin.component.html',
  styleUrls: ['./signin.component.css']
})
export class SigninComponent implements OnInit {
  fieldTextType: boolean = false;
  loginform!: FormGroup;
  message: string = '';
  pVisibility: boolean = false;

  constructor(
    private fb: FormBuilder,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loginform = this.fb.group({
      Email: ['', Validators.required],
      Password: ['', Validators.required],
    });
  }

  submitlogin() {
    const apiUrl = 'http://localhost:3477/api/users';
    fetch(apiUrl)
      .then(response => response.json())
      .then((results: any[]) => {
        const matchedUser = results.find(user =>
          user.email === this.loginform.value.Email &&
          user.password === this.loginform.value.Password
        );
        if (matchedUser) {
          if (matchedUser.blocked) {
            alert("Your account has been blocked. Please contact support.");
            // Optionally, you might want to navigate somewhere else or perform additional actions.
          } else {
            if (matchedUser.levelOfAccess === 2) {
              if (matchedUser.approved) {
                // User is approved as a driver, navigate to driver page.
                this.router.navigate(['/driver-page']);
              } else {
                // User is not approved yet, show alert and navigate to user page.
                alert("You will be redirected to the user page. Once you're approved as a driver, you can access the driver page.");
                this.router.navigate(['/user-page']);
              }
            } else if (matchedUser.levelOfAccess === 3) {
              // User is a regular user, navigate to user page.
              this.router.navigate(['/user-page']);
            } else if (matchedUser.levelOfAccess === 1) {
              // User is an admin, navigate to admin page.
              this.router.navigate(['/admin']);
            }
          }
        } else {
          // User credentials are invalid.
          alert("Invalid email or password.")
        }

      })
      .catch(err => {
        alert("An error occurred while fetching user data.")
      });
  }



  toggleFieldTextType() {
    this.fieldTextType = !this.fieldTextType;
  }
}
