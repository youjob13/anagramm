import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit {
  public title = 'Anagramm';

  ngOnInit(): void {
    setTimeout(() => (this.title = 'Anagramm title has been changed'), 3000);
  }
}
