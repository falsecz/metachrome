connect = (url, nick, callback) ->
	chrome.tabs.query {active:yes, currentWindow:yes}, (tabs) ->
		request = {type: 'connect', url, nick}
		chrome.runtime.sendMessage request, callback

main = ->
	connBtn = $ 'button#send'
	connBtn.click (ev) ->
		url = $('input#url').val()
		nick = $('input#nick').val()
		if url.length and nick.length
			connect url, nick, (response) ->
				window.location = '/views/comments.html'
		else
			console.log 'Specify URL and nickname'

document.addEventListener 'DOMContentLoaded', main, false
