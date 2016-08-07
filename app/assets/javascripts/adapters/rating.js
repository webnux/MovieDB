// For more information see: http://emberjs.com/guides/models/customizing-adapters/

MovieDB.RatingAdapter = DS.ActiveModelAdapter.extend({
  host: 'http://localhost:3000',
  headers:
  {'Content-Type': 'application/json',
  'Accept': 'application/json'
  }
});
