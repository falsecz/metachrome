// Copyright (c) 2011 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Called when the url of a tab changes.
function checkForValidUrl(tabId, changeInfo, tab) {
  
  
  
  if (tab.url.indexOf('g') > -1) {
    // ... show the page action.
    chrome.pageAction.setIcon({tabId: tabId,path:"icons/icon_16_active.png"});
    chrome.pageAction.setPopup({tabId: tabId, popup: "popup.html"});
    
  } else {
    chrome.pageAction.setIcon({tabId: tabId, path:"icons/icon_16_inactive.png"});
  }
  chrome.pageAction.show(tabId);
};

// Listen for any changes to the URL of any tab.
chrome.tabs.onUpdated.addListener(checkForValidUrl);