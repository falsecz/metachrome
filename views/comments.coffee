main = ->	
	chrome.runtime.sendMessage type:'comments', (response) ->
		commentList = $ '#comments-list'
		$.each response, (index, item) ->
			commentList.append "<tr><td>#{item.date}</td><td>#{item.content}</td><td>#{item.content}</td><td>#{item.nick}</td></tr>"
	
	commentAddForm = document.querySelector 'form#comments-add-form'

	fuckOff = (ev) ->
		ev.preventDefault()
		alert 'bitch'
		alert commentAddForm.serializeArray()
		return no
	
	commentAddForm.addEventListener 'submit', fuckOff, false

document.addEventListener 'DOMContentLoaded', main, no

