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

_sample_comments = [
	{ "type": "comment",  "date" : "1.4.2013",  "content":  "První comment",   "nick": "A", "uid": "4Rx4RNk1UX7Dvq"},
	{ "type": "comment",  "date" : "1.4.2013",  "content":  "2. komentář",     "nick": "B", "uid": "4Rx4RNk1UX7Dvq"},
	{ "type": "comment",  "date" : "1.4.2013",  "content":  "Další příspěvek", "nick": "C", "uid" : "99wFJ0B"}
]

chrome.tabs.onUpdated.addListener handleURLChange

chrome.runtime.onMessage.addListener (message, sender, response) ->
	return no unless message?.type?

	switch message.type
		when 'comments'
			response _sample_comments

		when 'url'
			chrome.tabs.query {active:yes, currentWindow:yes}, (tabs) ->
				response url:tabs[0].url if tabs.length
		else
			console.log "Unknown type '#{message.type}'"
			return no
	
	return yes
