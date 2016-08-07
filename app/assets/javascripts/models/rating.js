// for more details see: http://emberjs.com/guides/models/defining-models/

MovieDB.Rating = DS.Model.extend({
  score: DS.attr('string'),
  movieId: DS.attr('string')
});
