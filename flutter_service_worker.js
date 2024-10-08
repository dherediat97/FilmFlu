'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.json": "12706d647c2d27ba878c8bc8b54f7533",
"assets/assets/animations/splash_animation.json": "852bd621dfd4b5d115bad696800f79a1",
"assets/assets/flags/ja_flag.svg": "955dc96064b5a3e6fb2934b1681a8bd6",
"assets/assets/flags/pt_flag.svg": "b0fe9d1a130b18f724e5c6d45776f0d8",
"assets/assets/flags/fi_flag.svg": "13e69e216040dafa679d642b96df08fe",
"assets/assets/flags/sk_flag.svg": "c93846255f705a0c3ba7c1e30972eb4c",
"assets/assets/flags/it_flag.svg": "7630e428726bb9d8ac3f23669875af55",
"assets/assets/flags/hi_flag.svg": "67ca66b6c45a714899fdfc2fbf390108",
"assets/assets/flags/de_flag.svg": "e764a26c0c57231d271e415fddd615ab",
"assets/assets/flags/es_flag.svg": "a7c4a0fd30274575f96e18c95eabf520",
"assets/assets/flags/en_flag.svg": "f24e77d467bdb5c62b5099f06c6e95e5",
"assets/assets/flags/is_flag.svg": "be3ef49fec39ca2f1462a44e0a92821d",
"assets/assets/flags/fr_flag.svg": "8b5e163f68f38970c9322c829b3ebc5e",
"assets/assets/flags/sv_flag.svg": "4f1092575b3787aadf22d025af1cd6a4",
"assets/assets/flags/nl_flag.svg": "8e983d171aa34796ffebe61e6c981e71",
"assets/assets/icons/actress_icon.svg": "d8527b72dc32cf87c339cc05c36868e2",
"assets/assets/icons/github_icon.svg": "8dcc6b5262f3b6138b1566b357ba89a9",
"assets/assets/icons/actor_icon.svg": "4f544e1db88f76188ae07cdeea888393",
"assets/assets/icons/full_heart.svg": "d32bfea4eafb69c26e80b1756ea5290c",
"assets/assets/icons/actor_profile_not_found.svg": "5396e3b69dab33e75335c40360ce4d38",
"assets/assets/icons/anime_boy.svg": "e57e47681319c9c595acd0682c1245b2",
"assets/assets/icons/placeholder_image.svg": "e4ae65427ae871ed156b27e5c9dcf9f5",
"assets/assets/icons/anime_girl.svg": "3599969631661732f714f97f1bb7bcd9",
"assets/assets/images/logo.png": "8a523e1f7d71a4c561ad20585b33f30c",
"assets/assets/images/logo.svg": "041a37842bdd4e3d2319af4074eb322e",
"assets/assets/images/empty_state.jpg": "d1b1e9258f407f08b14c753f36e8c292",
"assets/AssetManifest.bin.json": "b836fe2a7647e5f45fe07490ca60edad",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "5499096aea5b243ac55f011333af6e9f",
"assets/FontManifest.json": "51facad46f23a30336e59b4f50c12502",
"assets/NOTICES": "32da9b303b8869b81843d9d6c0fac599",
"assets/fonts/LilitaOne-Regular.ttf": "ce83b4bfa37f53ea2a3fc97088af7181",
"assets/fonts/YsabeauInfant-Regular.ttf": "77ae2e2aabf54e66a34647b20d8cf52d",
"assets/fonts/YsabeauInfant-Italic.ttf": "da83ed1275af2b85313f2cabce2d5d7e",
"assets/fonts/ShadowsIntoLight-Regular.ttf": "e8f47a72dddf523096a21b4a93f56f89",
"assets/fonts/YsabeauInfant-Bold.ttf": "0e7502d2bffcf0aba596b408a39bdd09",
"assets/fonts/MaterialIcons-Regular.otf": "4a6a13bdeb84341709789f22e5d54ec3",
"assets/packages/youtube_player_iframe/assets/player.html": "663ba81294a9f52b1afe96815bb6ecf9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "391ff5f9f24097f4f6e4406690a06243",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "63735e76e5c58a5f282ef6d6332bcd6c",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "0191c721971801378f58a5f43929d7b0",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "f08f3f802c314ce8cb2cba72bb6c16ff",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"main.dart.js": "a369eab7b602667f1b4c10691caf8b56",
"style.css": "a708bf0410ffc1bee6d25f1a1bd7b3b7",
"icons/Icon-512.png": "b672d25326c75b588297e32f9ab23ca7",
"icons/Icon-192.png": "a9e1959196fb78772069bc29a6195165",
"icons/Icon-maskable-512.png": "b672d25326c75b588297e32f9ab23ca7",
"icons/Icon-maskable-192.png": "a9e1959196fb78772069bc29a6195165",
"flutter_bootstrap.js": "473c83b5c408506b9dfe4a2dc969f28d",
"favicon.png": "f5d2ae1a99d31dbf3877e3dfa1c4c83a",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"index.html": "6ad30813690d326dc2e83a2994c4aeea",
"/": "6ad30813690d326dc2e83a2994c4aeea",
"version.json": "1e9e239529e04e44ba5769c47b8f4835",
"manifest.json": "1be8c53aa6127b7896305e1ebc29f643"};
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
