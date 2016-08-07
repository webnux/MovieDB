MovieDB.MovieRatingComponent = Ember.Component.extend({
  score: Ember.computed.alias('rating.score'),
  star_1: (function(){return(parseInt(this.get('score')) >= 1)}).property('score'),
  star_2: (function(){return(parseInt(this.get('score')) >= 2)}).property('score'),
  star_3: (function(){return(parseInt(this.get('score')) >= 3)}).property('score'),
  star_4: (function(){return(parseInt(this.get('score')) >= 4)}).property('score'),
  star_5: (function(){return(parseInt(this.get('score')) >= 5)}).property('score'),
  click: function(event){
    this.set('score', $(event.target).val());
    this.get('rating').save();
  }
})
