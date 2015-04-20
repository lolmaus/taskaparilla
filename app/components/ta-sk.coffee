`import Ember from 'ember'`

TaSkComponent = Ember.Component.extend

  task: undefined
  allTasks: undefined

  classNames: 'taSk'
  attributeBindings: 'data-taskid'

  'data-taskid': Ember.computed.alias 'task.id'

  tasksWithoutCurrent: Ember.computed 'allTasks.[]', ->
    task = @get 'task'

    tasksWithoutCurrent =
      @get 'allTasks'
        .filter (candidate) => candidate isnt task && not candidate.get 'isNew'

    tasksWithoutCurrent.unshift null

    tasksWithoutCurrent


  _delete: ->
    task = @get 'task'
    task.destroyRecord()

  _edit: ->
    @set 'isEditing', true

  _save: ->
    @get 'task'
      .save()
      .then =>
        @set 'isEditing', false

  actions:
    delete: -> @_delete()
    edit:   -> @_edit()
    save:   -> @_save()

`export default TaSkComponent`
