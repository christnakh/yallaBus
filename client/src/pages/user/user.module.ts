import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms'; // Import FormsModule
import { UserComponent } from './user.component'; // Import your component

@NgModule({
  declarations: [
    UserComponent // Add your component here
  ],
  imports: [
    BrowserModule,
    FormsModule // Add FormsModule here
  ],
})
export class AppModule { }
