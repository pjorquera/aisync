import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import PouchDB from 'pouchdb-browser';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {

  private db = new PouchDB('http://localhost:4984/aisync', { auth: { username: 'admin', password: 'zxc123' } });

  title = 'front';

  constructor() {

    console.log('Started');
    // console.log(JSON.stringify(this.db));

    this.db.info().then(value => {
      console.log('info');
      console.log(JSON.stringify(value));
    });

    this.db.allDocs({ include_docs: true }).then(docs => {
      console.log('allDocs');
      console.log(JSON.stringify(docs));
    });

    this.db.changes({ live: true, since: 'now', include_docs: true }).on('change', value => {
      console.log(JSON.stringify(value));
    });
  }

}
