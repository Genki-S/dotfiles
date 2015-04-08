let g:tweetvim_tweet_per_page = 50
let g:tweetvim_say_insert_account = 1
let g:tweetvim_async_post = 1
let g:tweetvim_display_username = 1

nnoremap <SID>[tweetvim] <Nop>
nmap <Leader>T <SID>[tweetvim]

nnoremap <silent> <SID>[tweetvim]a :<C-u>TweetVimSwitchAccount<CR>
nnoremap <silent> <SID>[tweetvim]s :<C-u>TweetVimSay<CR>
nnoremap <silent> <SID>[tweetvim]h :<C-u>TweetVimHomeTimeline<CR>
nnoremap <silent> <SID>[tweetvim]m :<C-u>TweetVimMentions<CR>
