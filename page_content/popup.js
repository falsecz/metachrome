// Generated by CoffeeScript 1.6.2
chrome.runtime.sendMessage({
  type: 'url'
}, function(response) {
  var h;
  h = document.querySelector('h1');
  return h.innerText = response.url;
});
