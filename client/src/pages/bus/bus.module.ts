import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms'; // Import FormsModule
import { BusComponent } from './bus.component'; // Import your component
import { CommonModule } from '@angular/common';

@NgModule({
  declarations: [
    BusComponent // Add your component here
  ],
  imports: [
    BrowserModule,
    FormsModule,
    CommonModule // Add FormsModule here
  ],
})
export class AppModule { }
