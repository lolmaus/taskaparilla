`import Ember from 'ember'`

NewTaskComponent = Ember.Component.extend

  newTask:  undefined

  classNames: 'newTask'

  store: Ember.inject.service()

  _populateNewTask: Ember.on 'init', ->
    store = @get 'store'
    newTask = store.createRecord 'task'
    @set 'newTask', newTask

  _save: ->
    @get 'newTask'
      .moveTo null
      .then =>
        @_populateNewTask()

  actions:
    save: -> @_save()



`export default NewTaskComponent`
