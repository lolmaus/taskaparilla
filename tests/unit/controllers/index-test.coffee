`import { assert } from 'chai'`
`import { describeModule, it } from 'ember-mocha'`
`import Ember from 'ember'`

describeModule 'controller:index', 'IndexController', {
  # Specify the other units that are required for this test.
}, ->

  # Replace this with your real tests.
  it 'exists', ->
    controller = @subject()
    assert.ok controller

  it '_filterRootTasks', ->

    tasks = [
      foo = Ember.Object.create parent: null,  isNew: false, name: 'foo'
      Ember.Object.create       parent: true,  isNew: false, name: 'bar'
      baz = Ember.Object.create parent: false, isNew: false, name: 'baz'
      Ember.Object.create       parent: false, isNew: true,  name: 'quux'
      Ember.Object.create       parent: true,  isNew: true,  name: 'zomg'
    ]

    result = @subject()._filterRootTasks tasks

    assert.lengthOf result, 2,   "should only contain non-new items with no parent"
    assert.include  result, foo, "should include item foo"
    assert.include  result, baz, "should include item baz"

