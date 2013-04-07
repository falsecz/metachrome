sendComment = ->
	console.log "click"
	dataSource = $ "#comment_area"
	
	chrome.tabs.query {active:yes, currentWindow:yes}, (tabs) ->
					console.log dataSource
					request = 
						type: 'create-comment',
						data:
							uri : tabs[0].url if tabs.length,
							channel : '838b612f-2f22-4d6f-a214-0da2f69a5c9c',
							message: dataSource.val()		
					chrome.runtime.sendMessage request, (response) ->
						console.log response
					dataSource.val("")	
		
renderComments =  (data) ->	
	commentList = $ '#comments-list'
	$.each data, (index, item) ->
		commentList.append "<tr><td>#{item.date}</td><td>#{item.message}</td><!--td>#{item.content}</td><td>#{item.nick}</td--></tr>"
	
	cont = document.getElementById 'container'
	cont.scrollTop = cont.scrollHeight

chrome.runtime.onMessage.addListener (message, sender, response) ->
	if message.type is 'search-result'
		renderComments message.data

loadComments = ->	
	button = $ "#send_button"
	button.click sendComment
	chrome.runtime.sendMessage type:'comments', (response) ->
		return no

document.addEventListener 'DOMContentLoaded', loadComments, no



