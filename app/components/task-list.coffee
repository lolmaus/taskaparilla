`import Ember from 'ember'`

TaskListComponent = Ember.Component.extend

  task:     undefined
  allTasks: undefined


  classNames: 'taskList'

  tasks: Ember.computed 'task.children', ->
    task = @get 'task'

    if task
      task.get 'children'
    else
      null

  initSortable: Ember.on 'didInsertElement', ->
    element =
      @$ '.tasklist-list'
        .get 0

    sortable =
      Sortable.create element,
        group: 'tasks'

        onUpdate: (event) =>
          console.log 'onUpdate', event

        onAdd: (event) =>
          @onAdd event


  onAdd: (event) ->

    draggedTask   = @findTaskByElement event.item, 'child'
    newParentTask = @get 'task'

    draggedTask.moveTo newParentTask, event.newIndex, event.oldIndex

#    console.log event
#
#    draggedTask   = @findTaskByElement event.item, 'child'
#    newParentTask = @get 'task'
#
#    console.log "draggedTask",   draggedTask.get 'title'
#    console.log "newParentTask", newParentTask?.get 'title'
#
#    if newParentTask
#      draggedTask
#        .get 'parent.children'
#        ?.removeObject draggedTask
#
#      draggedTask.set 'parent', newParentTask
#
#      newParentTask
#        .get 'children'
#        .insertAt event.newIndex, draggedTask
#
#      console.log 'new children: ', newParentTask.get('children')
#
#      draggedTask.save()
#
#    else
#      draggedTask
#        .get 'parent.children'
#        ?.removeObject draggedTask
#
#      draggedTask.set 'parent', null
#      draggedTask.save().then -> console.log 'saved'



  findTaskByElement: (element, direction) ->

    id =
      Ember.$ element
        .children '.taSk'
        .data 'taskid'

    @get 'allTasks'
      .find (task) -> task.get('id') is id



`export default TaskListComponent`
