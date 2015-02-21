class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isWinner, @isDealer ) ->
  hit: ->
    @add(@deck.pop())
    console.log @scores()[0]
    if @scores()[0] > 20
      @trigger 'fail', @

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  stand: ->
    # reveal dealer's first card
    @models[0].flip()
    # check dealer's score
    # if dealer's score < 17 then hit
    @dealerHit @scores()


  dealerHit: (currentScore) ->
    if currentScore[0] < 17 or currentScore[1] < 17
      @hit()
      @dealerHit @scores()







  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


