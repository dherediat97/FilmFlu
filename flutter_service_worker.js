'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "01787ee728197d8f7b7516d748c20228",
"assets/assets/images/movie_not_found.svg": "c6c48458a6bd925d9e8dcea56affc6fa",
"assets/assets/images/logo.png": "8a523e1f7d71a4c561ad20585b33f30c",
"assets/assets/images/profile_not_found.svg": "5396e3b69dab33e75335c40360ce4d38",
"assets/assets/images/empty_state.jpg": "d1b1e9258f407f08b14c753f36e8c292",
"assets/assets/flags/en_flag.svg": "f24e77d467bdb5c62b5099f06c6e95e5",
"assets/assets/flags/fi_flag.svg": "13e69e216040dafa679d642b96df08fe",
"assets/assets/flags/sk_flag.svg": "c93846255f705a0c3ba7c1e30972eb4c",
"assets/assets/flags/pt_flag.svg": "b0fe9d1a130b18f724e5c6d45776f0d8",
"assets/assets/flags/it_flag.svg": "7630e428726bb9d8ac3f23669875af55",
"assets/assets/flags/nl_flag.svg": "8e983d171aa34796ffebe61e6c981e71",
"assets/assets/flags/fr_flag.svg": "8b5e163f68f38970c9322c829b3ebc5e",
"assets/assets/flags/ko_flag.svg": "60ecf8a541810a7891b44411cc5f18bc",
"assets/assets/flags/es_flag.svg": "a7c4a0fd30274575f96e18c95eabf520",
"assets/assets/flags/sv_flag.svg": "4f1092575b3787aadf22d025af1cd6a4",
"assets/assets/flags/zh_flag.svg": "b6bc696c40d05a541d9ef0115769fdc7",
"assets/assets/flags/hi_flag.svg": "67ca66b6c45a714899fdfc2fbf390108",
"assets/assets/flags/ja_flag.svg": "955dc96064b5a3e6fb2934b1681a8bd6",
"assets/assets/flags/is_flag.svg": "be3ef49fec39ca2f1462a44e0a92821d",
"assets/assets/flags/de_flag.svg": "e764a26c0c57231d271e415fddd615ab",
"assets/assets/flags/pl_flag.svg": "ecf0d00f68396036662529bc6cfdba51",
"assets/assets/animations/loading.json": "607b3b95e350298ed7a5bdd77caa0b30",
"assets/assets/animations/loading_screen.riv": "30e32e928c2026725ad6e364398eb401",
"assets/assets/icons/full_heart.svg": "d32bfea4eafb69c26e80b1756ea5290c",
"assets/assets/icons/actress_icon.svg": "d8527b72dc32cf87c339cc05c36868e2",
"assets/assets/icons/actor_icon.svg": "4f544e1db88f76188ae07cdeea888393",
"assets/assets/icons/anime_girl.svg": "3599969631661732f714f97f1bb7bcd9",
"assets/assets/icons/WW_0nizu_SpecialGift_Animations.package": "7ea7af2479d71eee96f04debfeca68c0",
"assets/assets/icons/WW_0nizu_Animations.package": "f3de02bc333431636d6701b24950d3bf",
"assets/assets/icons/github_icon.svg": "8dcc6b5262f3b6138b1566b357ba89a9",
"assets/assets/icons/anime_boy.svg": "e57e47681319c9c595acd0682c1245b2",
"assets/assets/icons/production_person_male.png": "c507577095ead8ff95c3a15fd48d5c12",
"assets/assets/icons/production_person_female.png": "7ee0ee5187cf11f57c0a75fc7c24192c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/FontManifest.json": "51facad46f23a30336e59b4f50c12502",
"assets/AssetManifest.json": "c049ac33ec81a3796dd097158b17aea7",
"assets/fonts/LilitaOne-Regular.ttf": "ce83b4bfa37f53ea2a3fc97088af7181",
"assets/fonts/ShadowsIntoLight-Regular.ttf": "e8f47a72dddf523096a21b4a93f56f89",
"assets/fonts/YsabeauInfant-Regular.ttf": "77ae2e2aabf54e66a34647b20d8cf52d",
"assets/fonts/MaterialIcons-Regular.otf": "8c05589b45ba14ea60b37525e8f49b5b",
"assets/fonts/YsabeauInfant-Bold.ttf": "0e7502d2bffcf0aba596b408a39bdd09",
"assets/fonts/YsabeauInfant-Italic.ttf": "da83ed1275af2b85313f2cabce2d5d7e",
"assets/AssetManifest.bin.json": "ac777f6ce597dbe5e8e8e9c5c69a4f93",
"assets/NOTICES": "1b8a547615ebe061cde5b8e6aee616b8",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "3ec23c2e1c821134f8ee88ef6df5eb72",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "0759632cdeba59c978186ca0581ce761",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "e2633b3dae529f1842a3ea5d9f40785d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "d7d83bd9ee909f8a9b348f56ca7b68c6",
"assets/packages/youtube_player_iframe/assets/player.html": "663ba81294a9f52b1afe96815bb6ecf9",
"version.json": "034f306235b4b2eb310485fd78e89bc7",
"manifest.json": "da43eee48ec1005522346f3ea99c3697",
"flutter_bootstrap.js": "18b8330d66967f0cc59b55e4323aa90a",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"index.html": "d4fcc705142fba671af1b9ab50911a6d",
"/": "d4fcc705142fba671af1b9ab50911a6d",
"favicon.png": "cea902f9d45123fe481c24df79cb6ab6",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"icons/Icon-512.png": "377b4d1eaa3ea016453aecccb33de72b",
"icons/Icon-192.png": "db92df20794c63e56978731e798d5a14",
"icons/Icon-maskable-512.png": "377b4d1eaa3ea016453aecccb33de72b",
"icons/Icon-maskable-192.png": "db92df20794c63e56978731e798d5a14",
"main.dart.js": "63a21c4618f543ecca0f94a5c3c5e632"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
