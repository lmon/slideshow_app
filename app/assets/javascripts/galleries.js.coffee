# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/




###
For Gallery Form Sortable *******
###
$("#sortable-toadd").sortable
  cursor: "move"
  opacity: 0.4
  placeholder: "ui-state-highlight"
  handle: ".handle"
  receive: (event, ui) ->
    
    # on drop, uncheck the check box
    ui.item.find("input:checkbox").prop "checked", false
    return

$("#sortable, #sortable-toadd").sortable connectWith: ".connectedSortable"
$("#sortable, #sortable-toadd").disableSelection()
$("#sortable").sortable
  cursor: "move"
  opacity: 0.4
  placeholder: "ui-state-highlight"
  handle: ".handle"
  receive: (event, ui) ->
    
    # on drop, check the check box
    console.log ui.item.find("input:checkbox") #containercheck
    ui.item.find("input:checkbox").prop "checked", true
    ui.item.find("input:checkbox").attr "checked", "checked"
    console.log "checkbox checked"
    return

  update: ->
    unless $("#sortable").attr("gid")
      console.error "there was an error w gid"
      return
    AUTH_TOKEN = $("meta[name=csrf-token]").attr("content")
    unless AUTH_TOKEN?
      console.error "there was an error w Auth"
      return
    
    # works :  $.get('/galleries/'+$( "#sortable" ).attr( "gid" )+'/sort/id?', '_method=put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize')); 
    postdata = authenticity_token: AUTH_TOKEN
    $.ajax
      url: "/galleries/" + $("#sortable").attr("gid") + "/sort/id?" + $(this).sortable("serialize")
      data: postdata
      type: "post"
      beforeSend: (req) ->
        slideshow.loader false
        console.log "sorting start"
        return

      error: (textStatus, errorThrown) ->
        slideshow.loader true
        console.log "sorting error"
        return

      complete: (req) ->
        
        # call global loader func
        slideshow.loader true
        console.log "sorting complete"
        return

    return

# end call
# end update
$("#assetsubmit").click (event) ->
  alert("i work");
  #slideshow.loader false
  #$("#assetform").submit()
  return
