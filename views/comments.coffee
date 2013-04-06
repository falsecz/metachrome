# <<<<<<< HEAD
# main = ->	
# 	chrome.runtime.sendMessage type:'comments', (response) ->
# 		commentList = $ '#comments-list'
# 		$.each response, (index, item) ->
# 			commentList.append "<tr><td>#{item.date}</td><td>#{item.content}</td><td>#{item.content}</td><td>#{item.nick}</td></tr>"
# 	
# 	
# 	commentAddForm = $ 'form#comments-add-form'
# =======
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
		
renderComments =  (data) ->
	console.log 'rc'
	
	console.log data

	commentList = $ '#comments-list'
	$.each data, (index, item) ->
		commentList.append "<tr><td>#{item.date}</td><td>#{item.message}</td><!--td>#{item.content}</td><td>#{item.nick}</td--></tr>"


chrome.runtime.onMessage.addListener (message, sender, response) ->
	if message.type is 'search-result'
		renderComments message.data

loadComments = ->	
	button = $ "#send_button"
	button.click sendComment
	console.log 'load'
	chrome.runtime.sendMessage type:'comments', (response) ->
		return no
# >>>>>>> comments handling
# 
	# commentAddForm.submit ->
	# 	alert commentAddForm.serializeArray()
	# 	return no
# 
# document.addEventListener 'DOMContentLoaded', main, no

document.addEventListener 'DOMContentLoaded', loadComments, no



