'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"version.json": "7eace3672340522829ce48c2123bdf59",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp%255BFILL,GRAD,opsz,wght%255D.ttf": "b04fe9737cef2b6eb89ecb5e1fb40518",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded%255BFILL,GRAD,opsz,wght%255D.ttf": "4cfc24daa42633b56477bc561d09a510",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined%255BFILL,GRAD,opsz,wght%255D.ttf": "1a58f36d5ca6ddbad6d1132d04ca4b2f",
"assets/packages/youtube_player_iframe/assets/player.html": "dc7a0426386dc6fd0e4187079900aea8",
"assets/AssetManifest.json": "336d82ccb4021cbf54862fa2c1f0c002",
"assets/assets/images/transparent_logo.png": "ce21481d8bb0520f2918db4f8a29e3f8",
"assets/assets/images/logo.jpg": "a82fa3c0e1841288221c7ce6ccb595a8",
"assets/assets/images/logo.png": "0ddc64aba934fbfcd2908aebeb8305ef",
"assets/assets/animations/splash_animation.json": "572aad4a464eeacea42287b03dd5b5a9",
"assets/assets/icons/actress_icon.svg": "d8527b72dc32cf87c339cc05c36868e2",
"assets/assets/icons/anime_girl.svg": "3599969631661732f714f97f1bb7bcd9",
"assets/assets/icons/actor_icon.svg": "4f544e1db88f76188ae07cdeea888393",
"assets/assets/icons/anime_boy.svg": "e57e47681319c9c595acd0682c1245b2",
"assets/assets/icons/actor_profile_not_found.svg": "5396e3b69dab33e75335c40360ce4d38",
"assets/assets/icons/flags/bs_flag.svg": "3ea64c6781bb4096804d0e99ee8c9717",
"assets/assets/icons/flags/es_pr.svg": "254a0a191eac9d03750503cc3495c6cb",
"assets/assets/icons/flags/pt_st.svg": "758851c9aa347c8bba6369575081dcd0",
"assets/assets/icons/flags/sk_flag.svg": "3d17db8fe9fdcbe625db93e59aab766e",
"assets/assets/icons/flags/it_flag.svg": "7630e428726bb9d8ac3f23669875af55",
"assets/assets/icons/flags/nl_flag.svg": "8e983d171aa34796ffebe61e6c981e71",
"assets/assets/icons/flags/en_flag.svg": "f24e77d467bdb5c62b5099f06c6e95e5",
"assets/assets/icons/flags/sv_flag.svg": "95207f6b8e4430784b31417711584296",
"assets/assets/icons/flags/el_flag.svg": "77e7a82b227f67bd7dd97f2075b2f435",
"assets/assets/icons/flags/es_flag.svg": "a7c4a0fd30274575f96e18c95eabf520",
"assets/assets/icons/flags/ja_flag.svg": "955dc96064b5a3e6fb2934b1681a8bd6",
"assets/assets/icons/flags/hy_flag.svg": "04bdc3ed95d8da54450c320244ca7bea",
"assets/assets/icons/flags/fr_flag.svg": "8b5e163f68f38970c9322c829b3ebc5e",
"assets/assets/icons/flags/de_flag.svg": "e764a26c0c57231d271e415fddd615ab",
"assets/assets/icons/flags/hi_flag.svg": "67ca66b6c45a714899fdfc2fbf390108",
"assets/assets/icons/flags/es_cr_flag.svg": "14264347374a53ad2cff2631e765dfe0",
"assets/assets/icons/flags/vi_flag.svg": "131d5ecc383455d7cbeb92c79ea0995d",
"assets/assets/icons/flags/fi_flag.svg": "13e69e216040dafa679d642b96df08fe",
"assets/assets/icons/flags/is_flag.svg": "be3ef49fec39ca2f1462a44e0a92821d",
"assets/assets/icons/placeholder_image.svg": "e4ae65427ae871ed156b27e5c9dcf9f5",
"assets/AssetManifest.bin": "23c58285f1535a60d61b02b3e08aac6f",
"assets/fonts/YsabeauInfant-Regular.ttf": "77ae2e2aabf54e66a34647b20d8cf52d",
"assets/fonts/LilitaOne-Regular.ttf": "ce83b4bfa37f53ea2a3fc97088af7181",
"assets/fonts/YsabeauInfant-Italic.ttf": "da83ed1275af2b85313f2cabce2d5d7e",
"assets/fonts/ShadowsIntoLight-Regular.ttf": "e8f47a72dddf523096a21b4a93f56f89",
"assets/fonts/YsabeauInfant-Bold.ttf": "0e7502d2bffcf0aba596b408a39bdd09",
"assets/fonts/MaterialIcons-Regular.otf": "0fb779ba18ad6085cb51e20f76011983",
"assets/NOTICES": "29756d3397fd8c52bbb6f762f4e653a4",
"assets/FontManifest.json": "33ead0c61d2e2267c7a67c2e333d67e9",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"icons/Icon-maskable-192.png": "f53c659909d5a5a8414518fbae5eadb2",
"icons/Icon-512.png": "99097ce705554d072efbc3932a66ce94",
"icons/Icon-192.png": "f53c659909d5a5a8414518fbae5eadb2",
"icons/Icon-maskable-512.png": "99097ce705554d072efbc3932a66ce94",
"index.html": "82ef0fcf46c373d1c645d70f80df98f3",
"/": "82ef0fcf46c373d1c645d70f80df98f3",
"main.dart.js": "b99b53d5fc538644b3592fb31a40dad3",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "4eadc1fd9b3c4b46ebe5370ab2a3dbe4",
"manifest.json": "44ed34434b2e95be77f452a54f34995b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
