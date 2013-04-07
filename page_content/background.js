// Generated by CoffeeScript 1.6.1
var getLocation, handleURLChange, registeredChannels, ws;

ws = io.connect('http://localhost:8000');

registeredChannels = {};

getLocation = function(url) {
  var a;
  a = document.createElement('a');
  a.href = url;
  return a;
};

handleURLChange = function(tabId, changeInfo, tab) {
  var link, _ref;
  if (changeInfo.status === 'complete') {
    link = getLocation(tab.url);
    if ((_ref = link.protocol) === 'http:' || _ref === 'https:') {
      chrome.pageAction.show(tabId);
      return chrome.pageAction.onClicked.addListener(function(tab) {
        return chrome.pageAction.setPopup({
          tabId: tabId,
          popup: 'page_content/popup.html'
        });
      });
    }
  }
};

chrome.tabs.onUpdated.addListener(handleURLChange);

chrome.runtime.onMessage.addListener(function(message, sender, response) {
  if ((message != null ? message.type : void 0) == null) {
    return false;
  }
  switch (message.type) {
    case 'create-comment':
      ws.emit('publish', message.data);
      break;
    case 'comments':
      chrome.tabs.query({
        active: true,
        currentWindow: true
      }, function(tabs) {
        var tabId, url;
        if (tabs.length) {
          url = tabs[0].url;
        }
        if (tabs.length) {
          tabId = tabs[0].id;
        }
        if (!url) {
          return;
        }
        return ws.emit('search', {
          uri: url,
          hash: tabId
        });
      });
      break;
    case 'url':
      chrome.tabs.query({
        active: true,
        currentWindow: true
      }, function(tabs) {
        if (tabs.length) {
          return response({
            url: tabs[0].url
          });
        }
      });
      break;
    default:
      console.log("Unknown type '" + message.type + "'");
      return false;
  }
  return true;
});

ws.on('channel-created', function(data) {
  return console.log(data);
});

ws.on('search-result', function(data) {
  var message;
  console.log(data);
  message = {
    type: 'search-result',
    data: data
  };
  return chrome.runtime.sendMessage(message, function(response) {
    return false;
  });
});
