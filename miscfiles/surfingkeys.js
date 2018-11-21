map('<Ctrl-n>', 'R') // next tab
map('<Ctrl-p>', 'E') // prev tab
// TODO: maybe use mapkey to free R/E mappings

mapkey('<Ctrl-o>', '#4Go back in history', function() {
    history.go(-1);
}, {repeatIgnore: true});
mapkey('<Ctrl-i>', '#4Go forward in history', function() {
    history.go(1);
}, {repeatIgnore: true});

// scrolls {{{
map('<Ctrl-e>', 'j')
map('<Ctrl-y>', 'k')
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
// }}}

map('F', 'gf'); // open a link in new tab

mapkey('R', '#4Reload the page skipping the cache', () => {
    RUNTIME('reloadTab', {
        nocache: true
    });
});

mapkey(',r', '#11Reload settings', () => {
    RUNTIME('loadSettingsFromUrl', {
        url: 'file://<%= ENV["HOME"] %>/.surfingkeys.js'
    });
    Front.showBanner('settings were reloaded');
})

// settings {{{
// show hints to the left of elements (same as vimperator)
settings.hintAlign = 'left';
// open new tabs to the right of the current one
settings.newTabPosition = "right"
// }}}

// copies {{{
mapkey('yo', "#7Copy current page's URL & title in org-mode format", function() {
    var title = document.title.replace(/[\[\]]+/g, '');
    Clipboard.write('[[' + window.location.href + '][' + title + ']]');
});

// useful for e.g. copying JIRA keys
// stole from https://github.com/kalbasit/dotfiles/blob/master/overlays/all/surfingkeys-config/surfingkeys.js
function copyLastElementInPath() {
    const locationParts = window.location.href.split('/');
    const lastElement = locationParts[locationParts.length-1].split('#')[0].split('?')[0];
    if (!lastElement) {
        Front.showBanner(`No last element was found.`);
        return;
    }
    Clipboard.write(lastElement);
    Front.showBanner(`Copied ${lastElement} to the clipboard.`);
}
mapkey('yl', '#7Copy the last element of the path in the URL', copyLastElementInPath)
// }}}

// vimperator compatibility {{{
// qmarks
var overlayedGlobalMarks = {
    'm': 'https://mail.google.com',
    'n': 'http://www.nicovideo.jp/ranking?header',
    's': 'https://www.google.com/calendar/render?pli=1',
    'r': 'http://feedly.com/#my',
    'a': 'http://www.amazon.co.jp/',
    'g': 'https://github.com/',
    't': 'https://twitter.com/',
    'y': 'https://youtube.com/',
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

// "ignore" feature
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

// open URL from clipboard
mapkey('p', '#3Open URL from clipboard', () => {
    Clipboard.read(response => {
        window.location.href = response.data;
    });
});
mapkey('P', '#1Open URL from clipboard in a new tab', () => {
    Clipboard.read(response => {
        window.open(response.data);
    });
})
// }}}

// insert mode mappings
imap('<Ctrl-f>', '<Alt-f>')
imap('<Ctrl-b>', '<Alt-b>')
imap('<Ctrl-w>', '<Alt-w>')

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

// vim: foldmethod=marker
