class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="nextGame-button">Next Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '
  canHit: true
  canStand: true

  events:
    'click .hit-button': ->
      if @canHit
        @model.get('playerHand').hit()
    'click .stand-button': ->
      if @canStand
        @canHit = false
        @canStand = false
        @model.get('dealerHand').stand()
        @model.declareWinner()
        @render()
    'click .nextGame-button': ->
      @model.set 'deck' , deck = new Deck()
      @model.set 'playerHand', @model.get('deck').dealPlayer()
      @model.set 'dealerHand', @model.get('deck').dealDealer()
      @canHit = true
      @canStand = true
      @render()


  initialize: ->
    @render()
    @model.get('playerHand').on 'fail', =>
      @canHit = false
      @canStand = false
      @model.declareWinner()
      @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el


