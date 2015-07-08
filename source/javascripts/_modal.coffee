$('.honeymoon-item__buy').click( ->
  setupForm(this)
  $('.modal-overlay, .modal').fadeIn()
  return false
)

$('.close-modal').click( ->
  $('.modal-overlay, .modal').fadeOut()
  return false
)

setupForm = (btn) ->
  $('.payment-form').trigger('reset').show()
  $('.success-payment').hide()

  $btn = $(btn)
  $item = $btn.closest('.honeymoon-item')
  title = $item.find('.honeymoon-item__title').text()
  priceText = $item.find('.honeymoon-item__price').text()
  pricePennies =  $item.find('.honeymoon-item__price').data('price')
  $('.modal__header h2').text(title)
  $('.payment-form__item').val(title)
  $('.payment-form__button .button-text').text("Pay #{priceText}")
  $('.payment-form__price').val(pricePennies)