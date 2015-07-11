$('.stripe-number').payment('formatCardNumber')
$('.stripe-exp-date').payment('formatCardExpiry')
$('.stripe-cvc').payment('formatCardCVC')

$form = $('.js-gift-form')

$form.on('submit', ->
  expDate = $('.stripe-exp-date').payment('cardExpiryVal')

  $('.gift-form__email').toggleInputError(!$('.gift-form__email').val())
  $('.stripe-name').toggleInputError(!$('.stripe-name').val())
  $('.stripe-number').toggleInputError(!$.payment.validateCardNumber($('.stripe-number').val()))
  $('.stripe-exp-date').toggleInputError(!$.payment.validateCardExpiry(expDate))
  $('.stripe-cvc').toggleInputError(!$.payment.validateCardCVC($('.stripe-cvc').val()))

  # Only run this code if we a re on the donation page by lookign for the input element
  if($('.gift-form__donated-amount').length)
    amountFloat = parseFloat($('.gift-form__donated-amount').val())
    $('.gift-form__price').val(amountFloat *100)

  $('.payment-errors').empty()

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
    finishedPayment(data)
  )
  return false


finishedPayment = (response) ->
  if response.error
    $form.find('.payment-errors').html("<span>#{response.error.message}</span>")
  else
    showModal($('.modal'), $('.js-thankyou'))
  $('.gift-form__button').prop('disabled', false).removeClass('processing')