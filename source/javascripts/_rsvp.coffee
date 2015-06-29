RevealFormSections = {

  init: ->
    this.hideOptions()
    this.displayChoice()
    this.showPlusOne()

  hideOptions: ->
    $('.result').hide()

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
    $('[name="plus-one"]').on('change', ->
      if $(this).val() is 'Yes'
        $('.plus-one-details').slideDown()
      else
        $('.plus-one-details').slideUp()
    )

}

RevealFormSections.init()