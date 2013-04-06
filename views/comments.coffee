loadComments = ->	
	console.log 'load'
	chrome.runtime.sendMessage type:'comments', (response) ->
		commentList = $ '#comments_list'
		$.each response, (index, item) ->
			commentList.append "<tr><td>#{item.date}</td><td>#{item.content}</td><td>#{item.content}</td><td>#{item.nick}</td></tr>"

document.addEventListener 'DOMContentLoaded', loadComments, no

