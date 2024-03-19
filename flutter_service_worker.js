'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "3e7f4af4bb14ab170991c9bf8db00c09",
"/": "3e7f4af4bb14ab170991c9bf8db00c09",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"favicon.png": "4eadc1fd9b3c4b46ebe5370ab2a3dbe4",
"assets/FontManifest.json": "f3267a17cf81a8625fd73f297f6ea9be",
"assets/fonts/LilitaOne-Regular.ttf": "ce83b4bfa37f53ea2a3fc97088af7181",
"assets/fonts/YsabeauInfant-Bold.ttf": "0e7502d2bffcf0aba596b408a39bdd09",
"assets/fonts/MaterialIcons-Regular.otf": "0e914069cb2efbd9cf20ea2497bb8f9b",
"assets/fonts/ShadowsIntoLight-Regular.ttf": "e8f47a72dddf523096a21b4a93f56f89",
"assets/fonts/YsabeauInfant-Italic.ttf": "da83ed1275af2b85313f2cabce2d5d7e",
"assets/fonts/YsabeauInfant-Regular.ttf": "77ae2e2aabf54e66a34647b20d8cf52d",
"assets/AssetManifest.bin.json": "0889f1cc4640651a88c54f3ab103b117",
"assets/assets/images/logo.png": "0ddc64aba934fbfcd2908aebeb8305ef",
"assets/assets/images/transparent_logo.png": "ce21481d8bb0520f2918db4f8a29e3f8",
"assets/assets/images/logo.jpg": "a82fa3c0e1841288221c7ce6ccb595a8",
"assets/assets/animations/splash_animation.json": "852bd621dfd4b5d115bad696800f79a1",
"assets/assets/icons/actor_profile_not_found.svg": "5396e3b69dab33e75335c40360ce4d38",
"assets/assets/icons/actor_icon.svg": "4f544e1db88f76188ae07cdeea888393",
"assets/assets/icons/anime_boy.svg": "e57e47681319c9c595acd0682c1245b2",
"assets/assets/icons/flags/vi_flag.svg": "131d5ecc383455d7cbeb92c79ea0995d",
"assets/assets/icons/flags/is_flag.svg": "be3ef49fec39ca2f1462a44e0a92821d",
"assets/assets/icons/flags/en_flag.svg": "f24e77d467bdb5c62b5099f06c6e95e5",
"assets/assets/icons/flags/hi_flag.svg": "67ca66b6c45a714899fdfc2fbf390108",
"assets/assets/icons/flags/hy_flag.svg": "04bdc3ed95d8da54450c320244ca7bea",
"assets/assets/icons/flags/sk_flag.svg": "3d17db8fe9fdcbe625db93e59aab766e",
"assets/assets/icons/flags/sv_flag.svg": "95207f6b8e4430784b31417711584296",
"assets/assets/icons/flags/fr_flag.svg": "8b5e163f68f38970c9322c829b3ebc5e",
"assets/assets/icons/flags/es_pr.svg": "254a0a191eac9d03750503cc3495c6cb",
"assets/assets/icons/flags/fi_flag.svg": "13e69e216040dafa679d642b96df08fe",
"assets/assets/icons/flags/es_flag.svg": "a7c4a0fd30274575f96e18c95eabf520",
"assets/assets/icons/flags/el_flag.svg": "77e7a82b227f67bd7dd97f2075b2f435",
"assets/assets/icons/flags/de_flag.svg": "e764a26c0c57231d271e415fddd615ab",
"assets/assets/icons/flags/es_cr_flag.svg": "14264347374a53ad2cff2631e765dfe0",
"assets/assets/icons/flags/pt_st.svg": "758851c9aa347c8bba6369575081dcd0",
"assets/assets/icons/flags/nl_flag.svg": "8e983d171aa34796ffebe61e6c981e71",
"assets/assets/icons/flags/bs_flag.svg": "3ea64c6781bb4096804d0e99ee8c9717",
"assets/assets/icons/flags/ja_flag.svg": "955dc96064b5a3e6fb2934b1681a8bd6",
"assets/assets/icons/flags/it_flag.svg": "7630e428726bb9d8ac3f23669875af55",
"assets/assets/icons/placeholder_image.svg": "e4ae65427ae871ed156b27e5c9dcf9f5",
"assets/assets/icons/anime_girl.svg": "3599969631661732f714f97f1bb7bcd9",
"assets/assets/icons/actress_icon.svg": "d8527b72dc32cf87c339cc05c36868e2",
"assets/AssetManifest.bin": "431f283156c63269ff5f538817d6354d",
"assets/NOTICES": "eb665a8f74c8d779b907e2a1668eaeb1",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "74b534f0f5d37c5a01be63abb0ccd85a",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "3cf688cd0d35587d8b97dc14c9e1eba5",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "2b09d8f8d0536cd5bb0d8fa81aca91b9",
"assets/packages/youtube_player_iframe/assets/player.html": "ea69af402f26127fa4991b611d4f2596",
"assets/AssetManifest.json": "72d498f1406d4032d011ca3db778048d",
"version.json": "ba944e67953733cc72462b96e08dc6bd",
"icons/Icon-512.png": "99097ce705554d072efbc3932a66ce94",
"icons/Icon-maskable-192.png": "f53c659909d5a5a8414518fbae5eadb2",
"icons/Icon-maskable-512.png": "99097ce705554d072efbc3932a66ce94",
"icons/Icon-192.png": "f53c659909d5a5a8414518fbae5eadb2",
"manifest.json": "44ed34434b2e95be77f452a54f34995b",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"main.dart.js": "d257cf4b75b21f561d5ad69e3b8e036f"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
