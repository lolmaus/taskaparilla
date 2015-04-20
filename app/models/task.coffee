`import DS from 'ember-data'`

Task = DS.Model.extend
  title:    DS.attr 'string'
  position: DS.attr 'number'

  parent:   DS.belongsTo 'task', inverse: 'children'
  children: DS.hasMany   'task', inverse: 'parent'

  moveTo: (newParentTask, newPosition, oldPosition) ->
    adapter = @store.adapterFor @constructor.typeKey

    if typeof newParentTask is 'string'
      newParentTask =
        @store
          .all 'task'
          .find (task) -> task.get('id') is newParentTaskId

    adapter.moveTaskTo this, newParentTask, newPosition, oldPosition

`export default Task`
