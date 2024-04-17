import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {
  signupform!: FormGroup;

  constructor(
    private fb: FormBuilder,
    private router: Router,
    private http: HttpClient
  ) {}

  ngOnInit(): void {
    this.signupform = this.fb.group({
      username: ['', Validators.required],
      email: ['', Validators.required],
      password: ['', Validators.required],
      levelOfAccess: ['']
    });
  }

  submitsignup() {
    if (this.signupform.valid) {
      const userData = this.signupform.value;

      this.http.post('http://localhost:3477/signup', userData).subscribe(
        (res: any) => {
          console.log(res);

          if (userData.levelOfAccess === 2) {
            window.alert('Signup successful! You will log in as a user. You will become a driver when approved by admins.');
          } else {
            window.alert('Signup successful!');
          }

          this.router.navigate(['/signin']);
        },
        (err) => {
          console.log(err.error.message);

          window.alert('Signup failed username already exist');
        }
      );
    }
  }
}
