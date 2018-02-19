L.ExtendedIcon = L.Icon.extend(createIcon: (oldIcon) ->
  icon = L.Icon::createIcon.call(this, oldIcon)
  if @options.id
    icon.id = @options.id
  if @options.onclick
    clickHandler = @options.onclick
    icon.addEventListener 'click', ->
      clickHandler(this.id)
  icon
)

L.extendedIcon = (options) ->
  new (L.ExtendedIcon)(options)
return
