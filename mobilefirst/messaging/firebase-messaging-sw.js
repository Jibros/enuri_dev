// Import and configure the Firebase SDK
// These scripts are made available when the app is served or deployed on Firebase Hosting
// If you do not serve/host your project using Firebase Hosting see https://firebase.google.com/docs/web/setup
importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-app.js');
//importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-messaging.js');
importScripts('../messaging/messaging.js');
// importScripts('/__/firebase/init.js');
var config = {
  messagingSenderId: "21003064041"
};
firebase.initializeApp(config);
// [START get_messaging_object]
// Retrieve Firebase Messaging object.
const messaging = firebase.messaging();

/**
 * Here is is the code snippet to initialize Firebase Messaging in the Service
 * Worker when your app is not hosted on Firebase Hosting.

 // [START initialize_firebase_in_sw]
 // Give the service worker access to Firebase Messaging.
 // Note that you can only use Firebase Messaging here, other Firebase libraries
 // are not available in the service worker.
 importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-app.js');
 importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-messaging.js');

 // Initialize the Firebase app in the service worker by passing in the
 // messagingSenderId.
 firebase.initializeApp({
   'messagingSenderId': 'YOUR-SENDER-ID'
 });

 // Retrieve an instance of Firebase Messaging so that it can handle background
 // messages.
 const messaging = firebase.messaging();
 // [END initialize_firebase_in_sw]
 **/


// If you would like to customize notifications that are received in the
// background (Web app is closed or not in browser focus) then you should
// implement this optional method.
// [START background_handler]
messaging.setBackgroundMessageHandler(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  // Customize notification here
  // data.notification.title;

  var data = payload || {};
  var shinyData = decoder.run(data);
  const notificationTitle = shinyData.notification.title;
  var real_icon = "";

  if(shinyData.notification.icon != null || shinyData.notification.icon !== typeof undefined || shinyData.notification.icon != ""){
      real_icon = shinyData.notification.icon;
  }else{
      real_icon ='../messaging/enuri_logo.jpg';
  }
  real_icon ='../messaging/enuri_logo.jpg';
  const notificationOptions = {
    body: shinyData.notification.body,
    click_action: shinyData.notification.click_action,
    icon: real_icon

  };

  return self.registration.showNotification(notificationTitle,
      notificationOptions);
});
// [END background_handler]
// [START foreground_handler]
self.addEventListener('notificationclick', function(event) {
  event.notification.close();
  //console.log('[notification]  '+ event.notification.tag);
  //console.log('[notification]  '+ event.notification.click_action);
  // This looks to see if the current is already open and
  // focuses if it is
  event.waitUntil(clients.matchAll({
    type: "window"
  }).then(function(clientList) {
    for (var i = 0; i < clientList.length; i++) {
      var client = clientList[i];
      if (client.url == '/' && 'focus' in client)
        return client.focus();
    }
    if (clients.openWindow) {
        return clients.openWindow(event.notification.tag);
      }
  }));
});
// [END foreground_handler]
