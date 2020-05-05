'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "b5d9e386791515833c9a4dc2d07aae65",
"/": "b5d9e386791515833c9a4dc2d07aae65",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "bdd8d75eb9e6832ccd3117e06c51f0d3",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "d21f791b837673851dd14f7c132ef32e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "3ca122272cfac33efb09d0717efde2fa",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "9a62a954b81a1ad45a58b9bcea89b50b",
"assets/assets/home_banner.jpeg": "40401d8e3aae57b5a26f1a21852d6e09",
"assets/assets/math_activity.jpg": "04b57ce66c238cb525f3b8731bb01ac4",
"assets/assets/child_handwriting.jpeg": "b9e848a66a76b384a409d3965b5cde02",
"assets/assets/self_picture.jpg": "8498800f71865c680278c2c4d97e074d",
"assets/FontManifest.json": "49423f9a6412e252fd13cd387ffc158e",
"assets/AssetManifest.json": "1ecac4d9d1a76d6dc821cdd159c1d2c1",
"assets/LICENSE": "89ccce1dfd2ea201733616a7ccfdd5da",
"main.dart.js": "10d5684831e4ea6b0eee73f89dc9a179"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
