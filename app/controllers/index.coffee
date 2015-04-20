`import Ember from 'ember'`

IndexController = Ember.Controller.extend

  rootTasks: Ember.computed 'model.tasks.@each.parent', ->
    allTasks = @get 'model.tasks'
    @_filterRootTasks allTasks

  _filterRootTasks: (tasks) ->
    tasks.filter (task) ->
      not task.get('parent') and not task.get('isNew')


`export default IndexController`
