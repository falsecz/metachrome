main = ->	
	chrome.runtime.sendMessage type:'comments', (response) ->
		commentList = $ '#comments-list'
		$.each response, (index, item) ->
			commentList.append "<tr><td>#{item.date}</td><td>#{item.content}</td><td>#{item.content}</td><td>#{item.nick}</td></tr>"
	
	
	commentAddForm = $ 'form#comments-add-form'

	commentAddForm.submit ->
		alert commentAddForm.serializeArray()
		return no

document.addEventListener 'DOMContentLoaded', main, no

