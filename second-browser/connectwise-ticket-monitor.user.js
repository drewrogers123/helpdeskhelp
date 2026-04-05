// ==UserScript==
// @name        ConnectWise Ticket Monitor
// @namespace   Violentmonkey Scripts
// @match       https://*.connectwise.SUBDOMAIN.com/* CHANGE THIS SUBDOMAIN TO THE SAME ONE IN YOUR CONNECTWISE URL
// @grant       GM_addStyle
// @version     2.1
// @author      drew
// @description Manual per-tab toggle to refresh the ResourceList feed via Enter key.
// ==/UserScript==
(function() {
    'use strict';
    const selector = '#ResourceList-input';
    let enabled = false;
    let intervalId = null;

    const sendEnter = () => {
        if (document.hidden || !enabled) return;
        const target = document.querySelector(selector);
        if (target) {
            target.focus();
            const eventSettings = { key: 'Enter', code: 'Enter', keyCode: 13, which: 13, bubbles: true, cancelable: true };
            target.dispatchEvent(new KeyboardEvent('keydown', eventSettings));
            target.dispatchEvent(new KeyboardEvent('keypress', eventSettings));
            target.dispatchEvent(new KeyboardEvent('keyup', eventSettings));
            console.log('Enter key dispatched to ' + selector + ' at ' + new Date().toLocaleTimeString());
        }
    };

    // ui for the toggle button
    const btn = document.createElement('button');
    btn.textContent = '⏸ Refresher OFF';
    btn.style.cssText = `
        position: fixed; bottom: 20px; right: 20px; z-index: 99999;
        padding: 6px 12px; border-radius: 6px; border: 1px solid #ccc;
        background: #f0f0f0; color: #333; font-size: 12px;
        cursor: pointer; opacity: 0.75;
    `;
    btn.addEventListener('click', () => {
        enabled = !enabled;
        btn.textContent = enabled ? '▶ Refresher ON' : '⏸ Refresher OFF';
        btn.style.background = enabled ? '#d4edda' : '#f0f0f0';
        btn.style.color = enabled ? '#155724' : '#333';
    });
    document.body.appendChild(btn);

    // alt+r hotkey
    document.addEventListener('keydown', (e) => {
        if (e.altKey && e.key === 'r') {
            enabled = !enabled;
            btn.textContent = enabled ? '▶ Refresher ON' : '⏸ Refresher OFF';
            btn.style.background = enabled ? '#d4edda' : '#f0f0f0';
            btn.style.color = enabled ? '#155724' : '#333';
        }
    });
    // 10s interval by default 
    intervalId = setInterval(sendEnter, 10000);
})();
