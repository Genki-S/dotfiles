map('<Ctrl-n>', 'R') // next tab
map('<Ctrl-p>', 'E') // prev tab
// TODO: maybe use mapkey to free R/E mappings

mapkey('<Ctrl-o>', '#4Go back in history', function() {
    history.go(-1);
}, {repeatIgnore: true});
mapkey('<Ctrl-i>', '#4Go forward in history', function() {
    history.go(1);
}, {repeatIgnore: true});

// scrolls
mapkey('<Ctrl-d>', '#2Scroll a page down', function() {
    Normal.scroll('pageDown')
}, {repeatIgnore: true});
mapkey('<Ctrl-f>', '#2Scroll a full page down', function() {
    Normal.scroll('fullPageDown')
}, {repeatIgnore: true});
mapkey('<Ctrl-u>', '#2Scroll a page up', function() {
    Normal.scroll('pageUp')
}, {repeatIgnore: true});
mapkey('<Ctrl-b>', '#2Scroll a full page up', function() {
    Normal.scroll('fullPageUp')
}, {repeatIgnore: true});

// hints
map('F', 'af'); // open a link in new tab

settings.hintAlign = 'left';

// open new tabs to the right of the current one
settings.newTabPosition = "right"

// marks
var overlayedGlobalMarks = {
    'm': 'https://mail.google.com',
    'n': 'http://www.nicovideo.jp/ranking?header',
    's': 'https://www.google.com/calendar/render?pli=1',
    'r': 'http://feedly.com/#my',
    'a': 'http://www.amazon.co.jp/',
    'g': 'https://github.com/',
    'p': 'http://getpocket.com/a/queue/'
};
mapkey('gn', '#10Jump to vim-like mark in new tab.', function(mark) {
    var priorityURL = overlayedGlobalMarks[mark];
    if (priorityURL === undefined) {
        // fallback to Surfingkeys default jump
        Normal.jumpVIMark(mark, true);
        return;
    }
    var markInfo = {
        url: priorityURL,
        scrollLeft: 0,
        scrollTop: 0
    };
    markInfo.tab = {
        tabbed: true,
        active: true
    };
    RUNTIME("openLink", markInfo);
});

// copies
mapkey('yo', "#7Copy current page's URL & title in org-mode format", function() {
    Clipboard.write('[[' + window.location.href + '][' + document.title + ']]');
});

// vimperator's "ignore" feature
var PassThroughOnce = (function() {
    var self = new Mode("PassThroughOnce", "pass through once");
    self.addEventListener('keydown', function(event) {
        // prevent this event to be handled by Surfingkeys' other listeners
        event.sk_suppressed = true;
        self.exit();
    })
    return self;
})();
mapkey('i', '#0enter PassThroughOnce mode to temporarily suppress SurfingKeys', function() {
    PassThroughOnce.enter()
});

// set theme
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
