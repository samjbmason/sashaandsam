$('.stripe-number').payment('formatCardNumber')
$('.stripe-exp-date').payment('formatCardExpiry')
$('.stripe-cvc').payment('formatCardCVC')

$form = $('.js-gift-form')

$.fn.toggleInputError = (erred) ->
  this.toggleClass('has-error', erred)
  if erred
    this.addClass('shake').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
      $(this).removeClass('shake')
    )
  return this


$form.on('submit', ->
  expDate = $('.stripe-exp-date').payment('cardExpiryVal')

  $('.gift-form__email').toggleInputError(!$('.gift-form__email').val())
  $('.stripe-name').toggleInputError(!$('.stripe-name').val())
  $('.stripe-number').toggleInputError(!$.payment.validateCardNumber($('.stripe-number').val()))
  $('.stripe-exp-date').toggleInputError(!$.payment.validateCardExpiry(expDate))
  $('.stripe-cvc').toggleInputError(!$.payment.validateCardCVC($('.stripe-cvc').val()))

  if $('.has-error').length is 0
    $('.gift-form__button').prop('disabled', true).addClass('processing')
    Stripe.card.createToken(
      name: $('.stripe-name').val()
      number: $('.stripe-number').val()
      cvc: $('.stripe-cvc').val()
      exp_month: expDate.month
      exp_year: expDate.year
    , stripeResponseHandler)

  return false
)


stripeResponseHandler = (status, response) ->
  if response.error
    $form.find('.payment-errors').html("<span>#{response.error.message}</span>")
    $('.gift-form__button').prop('disabled', false).removeClass('processing')
  else
    token = response.id
    $form.append($('<input type="hidden" name="stripeToken">').val(token))
    makePayment()



makePayment = ->
  formData = $form.serialize()
  siteUrl = $form.attr('action')
  $.post(siteUrl, formData, (data) ->
    console.log(data)
    finishedPayment(data)
  )
  return false


finishedPayment = (response) ->
  if response.error
    $form.find('.payment-errors').html("<span>#{response.error.message}</span>")
  else
    showSuccess()
  $('.gift-form__button').prop('disabled', false).removeClass('processing')

showSuccess = ->
  $('.js-success-payment').fadeIn(400, ->
    $('.js-thankyou').addClass('anim-bounce-in')
  )