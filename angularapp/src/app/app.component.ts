import { Component } from '@angular/core';
import {Http, Response, Headers} from '@angular/http';

class Hero {
	id: number;
	name: string;
	power: string;
	nemesis: string;
}

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  myHero: Hero = new Hero();
  currentHero: Hero = new Hero
  heroes: Hero[] = [];
  baseApiUrl: string = 'http://localhost:9393/hero/';

  constructor(private http: Http){
  	// grab all the heroes from the api and set them into the array
  	this.getHeroes();
  	console.log(this.heroes);
  }

  getHeroes() {
  	this.http.get(this.baseApiUrl)
    .subscribe(response => this.heroes =response.json());
  }

  postHero(){
  	this.http.post(this.baseApiUrl, this.myHero)
  	.subscribe(response => this.heroes.push(response.json()));	
  }

  patchHero(){
    //localhost:9393/hero/1
    this.http.patch(this.baseApiUrl + this.currentHero.id, this.currentHero)
    .subscribe(response => this.heroes =response.json());
  }

  destroyHero(hero){
    this.http.delete(this.baseApiUrl + hero.id)
    .subscribe(response => this.heroes =response.json());
  }

  editHero(hero){
    this.currentHero = Object.assign({}, hero);
  }

}
