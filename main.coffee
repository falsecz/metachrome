changeTitle = (ev) ->
	ev.tartget.value 

onInputChange = (header) ->
	(ev) ->
		header.innerText = ev.target.value

main = ->
	header = document.querySelector 'h1'
	header.innerText = 'NASER SI!'

	input = document.createElement 'input'
	document.body.appendChild input

	input.addEventListener 'keyup', onInputChange(header), false

window.addEventListener 'load', main, false
