angular.module('loomioApp').factory 'PollOptionModel', (BaseModel) ->
  class PollOptionModel extends BaseModel
    @singular: 'pollOption'
    @plural: 'pollOptions'
    @indices: ['pollId']

    relationships: ->
      @belongsTo 'poll'
      @hasMany   'stanceChoices'

    stances: ->
      _.chain(@stanceChoices())
       .map((stanceChoice) -> stanceChoice.stance())
       .filter((stance) -> stance.latest)
       .compact()
       .value()

    beforeRemove: ->
      _.each @stances(), (stance) -> stance.remove()
