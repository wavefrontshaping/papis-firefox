/*
On startup, connect to the "ping_pong" app.
*/
var port = browser.runtime.connectNative("papis_connector");

/*
Listen for messages from the app.
*/
port.onMessage.addListener((response) => {
  console.log("Received: " + response);
});

function logTabs(tabs) {
    let tab = tabs[0]; // Safe to assume there will only be one result
    console.log(tab.url);
}

function onError(err){
    console.error(err);
}


/*
On a click on the browser action, send the app a message.
*/
browser.browserAction.onClicked.addListener(() => {
  //var activeTab = browser.tabs.query({active: true, currentWindow: true}).then(logTabs, onError);;
  //var url = activeTab;
  browser.tabs.query({currentWindow: true, active:true}).then(queryInfo => {
    browser.tabs.get(queryInfo[0].id).then(tab => {
      var tabUrl = tab.url;
      console.log(`Sending url: '${tabUrl}' to the Papis connector app.`)
      port.postMessage(`papis:${tabUrl}`);
      browser.tabs.update(tab.id, {url: updUrl});    
    });
  });
  //console.log(`URL '${url}' URL.`)
  
});
