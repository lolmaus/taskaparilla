`import Ember from 'ember'`

IndexRoute = Ember.Route.extend

  model: ->
    Ember.RSVP.hash
      tasks: @store.find 'task'

`export default IndexRoute`
