stripeKey = $('body').data('stripe')
Stripe.setPublishableKey(stripeKey)

$.fn.toggleInputError = (erred) ->
  this.toggleClass('has-error', erred)
  if erred
    this.addClass('shake').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
      $(this).removeClass('shake')
    )
  return this

window.showModal = (modal, innerModal) ->
  animate(
    el: modal,
    opacity: [0,1],
    easing: 'easeInQuart',
    duration: 600,
    begin: (el) ->
      $(el).show()
  )
  animate(
    el: innerModal,
    opacity: [0,1]
    translateY: [-30, 0],
    delay: 700
  )