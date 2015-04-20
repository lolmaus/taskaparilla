`import ApplicationAdapter from './application'`
`import Ember from 'ember'`

TaskAdapter = ApplicationAdapter.extend

  moveTaskTo: (movedTask, newParentTask, newPosition, oldPosition) ->

    oldParentTask = movedTask.get 'parent'

    oldAffectedTasks =
      if not oldPosition? then []
      else
        @store
          .all 'task'
          .filter (candidate) ->
            candidate isnt movedTask \
            and not candidate.get('isNew') \
            and `candidate.get('parent') == oldParentTask` \
            and candidate.get('position') >= oldPosition

    oldAffectedTasks.forEach (task) ->
      originalPosition = task.get 'position'
      task.set 'position', originalPosition - 1

    newSiblings =
      @store
        .all 'task'
        .filter (candidate) ->
          candidate isnt movedTask \
          and not candidate.get('isNew') \
          and `candidate.get('parent') == newParentTask`

    newAffectedTasks =
      if newPosition?
        newSiblings.filter (candidate) ->
          candidate.get('position') >= newPosition
      else
        []

    newAffectedTasks.forEach (task) ->
      originalPosition = task.get 'position'
      task.set 'position', originalPosition + 1


    newPosition =
      if newPosition? then newPosition else newSiblings.get 'length'

    movedTask.set 'position', newPosition
    movedTask.set 'parent', newParentTask

    savePromises =
      []
        .concat movedTask, oldAffectedTasks, newAffectedTasks
        .map (task) ->
          task.save()


    Ember.RSVP.all savePromises
      .then =>
        # DEBUG OUTPUT
        console.log '----------------'

        debugTask = (task, depth = 0) ->
          prefix = ""

          [0 .. depth].forEach (i) ->
            return if i is 0
            prefix += ". "

          console.log "#{prefix}#{task.get 'title'}: #{task.get 'position'}"

          task.get 'children'
            .sortBy 'position'
            .map (task) ->
              debugTask task, depth + 1

        @store
          .all 'task'
          .filter (task) -> not task.get('parent') and not task.get('isNew')
          .sortBy 'position'
          .map (task) ->
            debugTask task







`export default TaskAdapter`
