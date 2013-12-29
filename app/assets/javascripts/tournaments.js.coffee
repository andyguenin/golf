# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$ ->
		$("#b0, #b1, #b2, #b3, #b4, #b5").sortable
			connectWith: ".player-list"
		.disableSelection()
		
	$("#save-bucketing").click ->
		buckets = []
		$(".player-bucket").each (e) ->
			bucket_id = $(this).children(".bucket-id").text()
			$(this).children(".player-list").children(".player-data").each (f) ->
				id = $(this).children(".tp-id").text()
				buckets.push([id, bucket_id])
		$("#bucketing_data").val( btoa(JSON.stringify(buckets)))
		$("#tournament-bucket").submit()
		

			
		
	