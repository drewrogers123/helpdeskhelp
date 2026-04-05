A Violentmonkey userscript that keeps your ConnectWise service board up to date without a full page reload. 
Instead of refreshing the page, it simulates pressing Enter on the ResourceList search/filter input every 10 seconds, which re-triggers the board's own query and pulls in any new tickets, preserving your filters exactly as you set them. 
A small toggle button sits in the bottom-right corner of the page so you can turn it on or off with the click of a button (and you can also toggle it with Alt+R). 

The script only fires when the tab is visible, so it won't run in the background. To install it, update the @match line at the top with your ConnectWise subdomain, then load it into Violentmonkey

I use Edge as my second browser.
