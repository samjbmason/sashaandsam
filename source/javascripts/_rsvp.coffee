RevealFormSections = {

  init: ->
    this.hideOptions()
    this.displayChoice()
    this.showPlusOne()
    this.revealIfComing()

  hideOptions: ->
    $('.result, .plus-one, .which-song, .special-requirements, .sad-rufus').hide()

  displayChoice: ->
    $('[data-fork]').on('change', ->
      qGroup = $(this).closest('.q-group')

      if $(this).data('fork') is true
        qGroup.find('[data-result="false"]').slideUp()
        qGroup.find('[data-result="true"]').slideDown()
      else
        qGroup.find('[data-result="true"]').slideUp()
        qGroup.find('[data-result="false"]').slideDown()
    )

  showPlusOne: ->
    $('[name="plus one"]').on('change', ->
      if $(this).val() is 'Yes'
        $('.plus-one-details').slideDown()
      else
        $('.plus-one-details').slideUp()
    )

  revealIfComing: ->
    $('[name="attending all day"], [name="attending ceremony"], [name="attending-evening"]').on('change', ->
      if $(this).val() is 'Yes'
        $('.plus-one, .which-song, .special-requirements').slideDown()
        $('.sad-rufus').fadeOut()
      else
        $('.plus-one, .which-song, .special-requirements').slideUp()
        $('.sad-rufus').fadeIn()
    )
}

RevealFormSections.init()


$('.form--rsvp').on('submit', ->
  formData = $(this).serialize()
  $.post('https://formkeep.com/f/69b9f95b1c5b', formData, ->
    $('.rsvp-form').fadeOut(300, ->
      $('.rsvp-confirmed').fadeIn()
    )

  )
  return false
)