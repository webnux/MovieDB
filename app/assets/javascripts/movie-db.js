//= require ./environment
//= require ember
//= require ember-data
//= require active-model-adapter
//= require ember-template-compiler
//= require_self
//
//= require_tree ./adapters
//= require_tree ./mixins
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./components
//= require_tree ./templates
//= require_tree ./routes
//= require ./router

// for more details see: http://emberjs.com/guides/application/
MovieDB = Ember.Application.create({
  root: '#ember-rails-app'
});
