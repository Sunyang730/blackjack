# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'fail', =>
      @get('dealerHand').models[0].flip()



  declareWinner: ->
    if @get('dealerHand').scores()[0] > 21
      @get('playerHand').isWinner = true
    else if @get('playerHand').scores()[0] > 21
      @get('dealerHand').isWinner = true
    else
      if @get('playerHand').scores()[0] > @get('dealerHand').scores()[0] or (@get('playerHand').scores()[1] > @get('dealerHand').scores()[1] && @get('playerHand').scores()[1] < 22)
        @get('playerHand').isWinner = true
      else
        @get('dealerHand').isWinner = true
