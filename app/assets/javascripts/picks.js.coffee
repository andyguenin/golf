# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
	highlight = (e)->
		e.removeClass("btn-primary").addClass("btn-warning")
		
	$(".bucket-pick").each (e)->
		highlight($("#player-" + $(this).val()))
		
	$(".player-pick").click ->
		parent_id = $(this).parent().attr('id')
		patt=/^.*-(.*)$/
		bucket_id = patt.exec(parent_id)[1]
		$(this).parent().children(".player-pick").removeClass("btn-warning").addClass("btn-primary")
		highlight($(this))
		this_id = patt.exec($(this).attr('id'))[1]
		$("#pick_p"+bucket_id).val(this_id)
		