'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"style.css": "a708bf0410ffc1bee6d25f1a1bd7b3b7",
"index.html": "6ad30813690d326dc2e83a2994c4aeea",
"/": "6ad30813690d326dc2e83a2994c4aeea",
"assets/NOTICES": "93744c2cff6fa05c6a3848d9ece755d8",
"assets/assets/animations/splash_animation.json": "852bd621dfd4b5d115bad696800f79a1",
"assets/assets/images/empty_state.jpg": "d1b1e9258f407f08b14c753f36e8c292",
"assets/assets/images/no_image_movie.svg": "c6c48458a6bd925d9e8dcea56affc6fa",
"assets/assets/images/logo.png": "8a523e1f7d71a4c561ad20585b33f30c",
"assets/assets/images/logo.svg": "041a37842bdd4e3d2319af4074eb322e",
"assets/assets/icons/placeholder_image.svg": "e4ae65427ae871ed156b27e5c9dcf9f5",
"assets/assets/icons/github_icon.svg": "8dcc6b5262f3b6138b1566b357ba89a9",
"assets/assets/icons/anime_boy.svg": "e57e47681319c9c595acd0682c1245b2",
"assets/assets/icons/anime_girl.svg": "3599969631661732f714f97f1bb7bcd9",
"assets/assets/icons/actor_icon.svg": "4f544e1db88f76188ae07cdeea888393",
"assets/assets/icons/actress_icon.svg": "d8527b72dc32cf87c339cc05c36868e2",
"assets/assets/icons/full_heart.svg": "d32bfea4eafb69c26e80b1756ea5290c",
"assets/assets/icons/actor_profile_not_found.svg": "5396e3b69dab33e75335c40360ce4d38",
"assets/assets/flags/ko_flag.svg": "60ecf8a541810a7891b44411cc5f18bc",
"assets/assets/flags/nl_flag.svg": "8e983d171aa34796ffebe61e6c981e71",
"assets/assets/flags/pt_flag.svg": "b0fe9d1a130b18f724e5c6d45776f0d8",
"assets/assets/flags/zh_flag.svg": "b6bc696c40d05a541d9ef0115769fdc7",
"assets/assets/flags/sv_flag.svg": "4f1092575b3787aadf22d025af1cd6a4",
"assets/assets/flags/hi_flag.svg": "67ca66b6c45a714899fdfc2fbf390108",
"assets/assets/flags/sk_flag.svg": "c93846255f705a0c3ba7c1e30972eb4c",
"assets/assets/flags/ja_flag.svg": "955dc96064b5a3e6fb2934b1681a8bd6",
"assets/assets/flags/fr_flag.svg": "8b5e163f68f38970c9322c829b3ebc5e",
"assets/assets/flags/en_flag.svg": "f24e77d467bdb5c62b5099f06c6e95e5",
"assets/assets/flags/de_flag.svg": "e764a26c0c57231d271e415fddd615ab",
"assets/assets/flags/it_flag.svg": "7630e428726bb9d8ac3f23669875af55",
"assets/assets/flags/is_flag.svg": "be3ef49fec39ca2f1462a44e0a92821d",
"assets/assets/flags/fi_flag.svg": "13e69e216040dafa679d642b96df08fe",
"assets/assets/flags/es_flag.svg": "a7c4a0fd30274575f96e18c95eabf520",
"assets/assets/flags/pl_flag.svg": "ecf0d00f68396036662529bc6cfdba51",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "befdbf95b0c772bf20ef2d8bc88af7f7",
"assets/fonts/ShadowsIntoLight-Regular.ttf": "e8f47a72dddf523096a21b4a93f56f89",
"assets/fonts/LilitaOne-Regular.ttf": "ce83b4bfa37f53ea2a3fc97088af7181",
"assets/fonts/YsabeauInfant-Regular.ttf": "77ae2e2aabf54e66a34647b20d8cf52d",
"assets/fonts/YsabeauInfant-Italic.ttf": "da83ed1275af2b85313f2cabce2d5d7e",
"assets/fonts/MaterialIcons-Regular.otf": "be30066a9be57bfe0dee2118b3b5f06b",
"assets/fonts/YsabeauInfant-Bold.ttf": "0e7502d2bffcf0aba596b408a39bdd09",
"assets/FontManifest.json": "51facad46f23a30336e59b4f50c12502",
"assets/AssetManifest.bin.json": "340d7df63874c9048edb919b681db832",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "5f59c294156ed630ab8bcafd624be62a",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "8ae6f3e200218929e64d7d58482e1aec",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "108a418e34f1828a107a1c7bfd21245b",
"assets/packages/youtube_player_iframe/assets/player.html": "663ba81294a9f52b1afe96815bb6ecf9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "d7d83bd9ee909f8a9b348f56ca7b68c6",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/AssetManifest.json": "a48e4730b7fe51bbf91a40e7aae5e45c",
"version.json": "4784e683c1e5d8d34f51f3aebde3280e",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"main.dart.js": "64c21f38e768ea3f7d846b9036629a1f",
"icons/Icon-maskable-512.png": "b672d25326c75b588297e32f9ab23ca7",
"icons/Icon-192.png": "a9e1959196fb78772069bc29a6195165",
"icons/Icon-512.png": "b672d25326c75b588297e32f9ab23ca7",
"icons/Icon-maskable-192.png": "a9e1959196fb78772069bc29a6195165",
"manifest.json": "1be8c53aa6127b7896305e1ebc29f643",
"favicon.png": "f5d2ae1a99d31dbf3877e3dfa1c4c83a",
"flutter_bootstrap.js": "450653bff23d1b23b15975b540bdf62e"};
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
