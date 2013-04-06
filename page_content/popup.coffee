chrome.runtime.sendMessage type:'url', (response) ->
	h = document.querySelector 'h1'
	h.innerText = response.url

