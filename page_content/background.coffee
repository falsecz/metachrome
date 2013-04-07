ws = null
connectSocket = (url, callback) ->
	ws = io.connect url
	ws.on 'channel-created', (data) ->
		console.log data
		
	ws.on 'search-result', (data) ->
		console.log data
		message = 
			type: 'search-result'
			data: data
		console.log 'a'
		chrome.runtime.sendMessage message, (response) ->
			return no
	callback?()

connectSocket 'http://localhost:8000'

registeredChannels = {}

getLocation = (url) ->
	a = document.createElement 'a'
	a.href = url
	return a

handleURLChange = (tabId, changeInfo, tab) ->
	if changeInfo.status is 'complete'
		link = getLocation tab.url
		if link.protocol in ['http:', 'https:']
			chrome.pageAction.show tabId
			chrome.pageAction.onClicked.addListener (tab) ->
				chrome.pageAction.setPopup {tabId, popup:'page_content/popup.html'}

chrome.tabs.onUpdated.addListener handleURLChange

chrome.runtime.onMessage.addListener (message, sender, response) ->
	return no unless message?.type?

	switch message.type
		when 'create-comment'
			ws.emit 'publish', message.data
	
		when 'comments'
				chrome.tabs.query {active:yes, currentWindow:yes}, (tabs) ->
					url = tabs[0].url if tabs.length
					tabId = tabs[0].id if tabs.length
					return unless url 
#					return if registeredChannels[tabHash]
#					registeredChannels[tabHash] = 1
					ws.emit 'search', {uri: url, hash: tabId }
		when 'url'
			chrome.tabs.query {active:yes, currentWindow:yes}, (tabs) ->
				response url:tabs[0].url if tabs.length
		
		when 'connect'
			connectSocket message.url, -> response message

		else
			console.log "Unknown type '#{message.type}'"
			return no
	
	return yes
	
