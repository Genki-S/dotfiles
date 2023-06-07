// Tips:
// - map <C-h> & <C-l> (prev, next tab) on Vivaldi (so that it works on tabs with Surfingkeys disabled)

// settings {{{
// unfortunate, but this is the best way at the moment
settings.blocklistPattern = /.*docs\.google\.com.*/i
// show hints to the left of elements (same as vimperator)
settings.hintAlign = 'left'
// wait explicit input when there's only one hint
settings.hintExplicit = true
// focus to the left tab after closing current tab
settings.focusAfterClosed = 'left'
// open new tabs to the right of the current one
settings.newTabPosition = 'right'
// no hint-style tab selection (always use omnibar, for consistency)
settings.tabsThreshold = 0
// TODO: try this (default is 100)
// settings.omnibarHistoryCacheSize = 1000
// }}}

// set theme {{{
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult>ul>li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
// }}}

// mappings {{{
api.unmap('j') // useful on Gmail, not using for scrolling
api.unmap('k') // ditto
api.unmap('u') // use '?' for usage
api.unmap('R') // next tab
api.unmap('E') // prev tab
api.unmap('x') // close current tab: with Vivaldi workspace, surfingkeys doesn't activate expected tab after closing tab. So I'm mapping x on Vivaldi keyboard shortcut config.
api.unmap('<Ctrl-h>') // mouse over elements

api.mapkey('<Ctrl-o>', '#4Go back in history', function() {
  history.go(-1);
}, { repeatIgnore: true });
api.mapkey('<Ctrl-i>', '#4Go forward in history', function() {
  history.go(1);
}, { repeatIgnore: true });

// scrolls {{{
api.mapkey('<Ctrl-y>', '#2Scroll up', function() {
  api.Normal.scroll('up')
}, { repeatIgnore: true })
api.mapkey('<Ctrl-e>', '#2Scroll down', function() {
  api.Normal.scroll('down')
}, { repeatIgnore: true })
api.mapkey('<Ctrl-d>', '#2Scroll a page down', function() {
  api.Normal.scroll('pageDown')
}, { repeatIgnore: true })
api.mapkey('<Ctrl-f>', '#2Scroll a full page down', function() {
  api.Normal.scroll('fullPageDown')
}, { repeatIgnore: true })
api.mapkey('<Ctrl-u>', '#2Scroll a page up', function() {
  api.Normal.scroll('pageUp')
}, { repeatIgnore: true })
api.mapkey('<Ctrl-b>', '#2Scroll a full page up', function() {
  api.Normal.scroll('fullPageUp')
}, { repeatIgnore: true })
// }}}

api.map('F', 'gf') // open a link in new tab

api.mapkey('R', '#4Reload the page skipping the cache', () => {
  api.RUNTIME('reloadTab', {
    nocache: true
  })
})

api.mapkey(',r', '#11Reload settings', () => {
  api.RUNTIME('loadSettingsFromUrl', {
    url: 'file://<%= ENV["HOME"] %>/.surfingkeys.js'
  })
  api.Front.showBanner('settings were reloaded');
})

api.mapkey(',<', '#3Move current tab to leftmost', function() {
  api.RUNTIME('moveTab', {
    step: -99
  })
})
api.mapkey(',>', '#3Move current tab to rightmost', function() {
  api.RUNTIME('moveTab', {
    step: 99
  })
})

// copies {{{
api.mapkey('yo', "#7Copy current page's URL & title in org-mode format", function() {
  var title = document.title.replace(/[\[\]]+/g, '');
  api.Clipboard.write('[[' + window.location.href + '][' + title + ']]');
})

api.mapkey('ym', "#7Copy current page's URL & title in markdown format", function() {
  var title = document.title.replace(/[\[\]]+/g, '');
  const locationParts = window.location.href.split('/');
  api.Clipboard.write('[' + title + '](' + window.location.href + ')');
})

// useful for e.g. copying JIRA keys
// stole from https://github.com/kalbasit/dotfiles/blob/master/overlays/all/surfingkeys-config/surfingkeys.js
function copyLastElementInPath() {
  const locationParts = window.location.href.split('/')
  const lastElement = locationParts[locationParts.length - 1].split('#')[0].split('?')[0]
  if (!lastElement) {
    api.Front.showBanner(`No last element was found.`)
    return
  }
  api.Clipboard.write(lastElement)
  api.Front.showBanner(`Copied ${lastElement} to the clipboard.`)
}
api.mapkey('yl', '#7Copy the last element of the path in the URL', copyLastElementInPath)
// }}}

// vimperator compatibility {{{
// qmarks
var overlayedGlobalMarks = {
  'm': 'https://mail.google.com',
  'n': 'http://www.nicovideo.jp/ranking?header',
  's': 'https://www.google.com/calendar/render?pli=1',
  'r': 'https://www.rakuten.co.jp/',
  'a': 'http://www.amazon.co.jp/',
  'g': 'https://github.com/',
  't': 'https://twitter.com/',
  'y': 'https://youtube.com/',
  'p': 'http://getpocket.com/a/queue/'
}
api.mapkey('gn', '#10Jump to vim-like mark in new tab.', function(mark) {
  var priorityURL = overlayedGlobalMarks[mark];
  if (priorityURL === undefined) {
    // fallback to Surfingkeys default jump
    api.Normal.jumpVIMark(mark, true)
    return
  }
  var markInfo = {
    url: priorityURL,
    scrollLeft: 0,
    scrollTop: 0
  }
  markInfo.tab = {
    tabbed: true,
    active: true
  }
  api.RUNTIME("openLink", markInfo)
})

// "ignore" feature
// var PassThroughOnce = (function() {
//   var self = new Mode("PassThroughOnce", "pass through once");
//   self.addEventListener('keydown', function(event) {
//     if (event.key == 'Control' || event.key == 'Shift') {
//       // don't exit PassThroughOnce when only modifier keys are pressed
//       return
//     }
//     // prevent this event to be handled by Surfingkeys' other listeners
//     event.sk_suppressed = true;
//     self.exit();
//   })
//   return self;
// })();
// mapkey('i', '#0enter PassThroughOnce mode to temporarily suppress SurfingKeys', function() {
//   PassThroughOnce.enter()
// });

// try using ephemeral PassThrough mode; TODO: consider if PassThroughOnce is still useful
api.map('i', 'p')
api.unmap('p')

// open URL from clipboard
api.mapkey('p', '#3Open URL from clipboard', () => {
  api.Clipboard.read(response => {
    window.location.href = response.data
  })
})
api.mapkey('P', '#1Open URL from clipboard in a new tab', () => {
  api.Clipboard.read(response => {
    window.open(response.data)
  })
})
// }}}

// insert mode mappings
api.iunmap(':') // disable emoji completion

// }}}

var inlineQuery = {
  url: function(query) {
    return "https://eow.alc.co.jp/search?q=" + query
  },

  parseResult: function(res) {
    var parser = new DOMParser();
    var junkHead = /[\s\S]*<div id="resultsList"/;
    var content = res.text.replace(junkHead, '<div id="resultsList"');
    var junkTail = /<!-- ▲ 検索結果本体 ▲ -->[\s\S]*/;
    var content = content.replace(junkTail, '');
    return content;
  }
}
api.Front.registerInlineQuery(inlineQuery)


// search aliases {{{

// https://github.com/brookhong/Surfingkeys/blob/master/docs/API.md#addsearchalias

const searchleader = "s"
const searches = {}

// Arch Linux Wiki
searches.a = {
  alias: "a",
  name: "archwiki",
  search: "https://wiki.archlinux.org/index.php?go=go&search=",
  compl: "https://wiki.archlinux.org/api.php?action=opensearch&format=json&formatversion=2&namespace=0&limit=10&suggest=true&search=",
}
searches.a.callback = response => JSON.parse(response.text)[1]

// Google
searches.g = {
  alias: "g",
  name: "google",
  search: "https://www.google.com/search?q=",
  compl: "https://www.google.com/complete/search?client=chrome-omni&gs_ri=chrome-ext&oit=1&cp=1&pgcl=7&q=",
}

// Mozilla Developer Network (MDN)
searches.m = {
  alias: "m",
  name: "mdn",
  search: "https://developer.mozilla.org/en-US/search?q=",
  compl: "https://developer.mozilla.org/en-US/search.json?q=",
}
searches.m.callback = (response) => {
  const res = JSON.parse(response.text)
  return res.documents.map((s) => {
    let excerpt = escape(s.excerpt)
    if (excerpt.length > 240) {
      excerpt = `${excerpt.slice(0, 240)}…`
    }
    res.query.split(" ").forEach((q) => {
      excerpt = excerpt.replace(new RegExp(q, "gi"), "<strong>$&</strong>")
    })
    const title = escape(s.title)
    const slug = escape(s.slug)
    return createSuggestionItem(`
      <div>
        <div class="title"><strong>${title}</strong></div>
        <div style="font-size:0.8em"><em>${slug}</em></div>
        <div>${excerpt}</div>
      </div>
    `, { url: s.url })
  })
}

// YouTube
searches.y = {
  alias: "y",
  name: "youtube",
  search: "https://www.youtube.com/search?q=",
  // compl:  `https://www.googleapis.com/youtube/v3/search?maxResults=20&part=snippet&type=video,channel&key=${keys.google_yt}&safeSearch=none&q=`,
}
searches.y.callback = response => JSON.parse(response.text).items
  .map((s) => {
    switch (s.id.kind) {
      case "youtube#channel":
        return createURLItem(
          `${s.snippet.channelTitle}: ${s.snippet.description}`,
          `https://youtube.com/channel/${s.id.channelId}`,
        )
      case "youtube#video":
        return createURLItem(
          ` ▶ ${s.snippet.title}`,
          `https://youtu.be/${s.id.videoId}`,
        )
      default:
        return null
    }
  }).filter(s => s !== null)

Object.values(searches).forEach((s) => {
  api.addSearchAlias(s.alias, s.name, s.search, searchleader, s.compl, s.callback)
})
// }}}


// vim: foldmethod=marker
