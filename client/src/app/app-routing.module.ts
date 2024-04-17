import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SigninComponent } from 'src/pages/signin/signin.component';
import { SignupComponent } from 'src/pages/signup/signup.component';
import { BusComponent } from 'src/pages/bus/bus.component'; // Assuming this is for the user page
import { UserComponent } from 'src/pages/user/user.component'; // Assuming this is for the bus page
import { AdminComponent } from 'src/layouts/admin/admin.component';
const routes: Routes = [
  { path: '', redirectTo: '/signin', pathMatch: 'full' },
  { path: 'signin', component: SigninComponent },
  { path: 'signup', component: SignupComponent },
  { path: 'user-page', component: UserComponent }, // Corrected to BusComponent for the user page
  { path: 'driver-page', component: BusComponent } ,  // Corrected to UserComponent for the bus page

  { path: 'admin', component: AdminComponent }   // Corrected to UserComponent for the bus page
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
