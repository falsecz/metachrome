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
	if message?.get? and message.get is 'url'
		chrome.tabs.query {active:yes, currentWindow:yes}, (tabs) ->
			response url:tabs[0].url if tabs.length
		return yes
