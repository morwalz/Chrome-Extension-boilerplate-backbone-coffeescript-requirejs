Chrome-Extension-boilerplate-backbone-coffeescript-requirejs
============================================================

This is a boilerplate for Chrome extension. It
should be easy enough to get started even if you've never built a Chrome
extension before by following the INSTALLATION notes.


INSTALLATION

  The boilerplate works out of the box, so start by installing it in Chrome:

  - git clone git://https://quirejs.git my-project-name
  - Visit chrome://extensions and expand "Development mode" (top right).
  - Choose "Load unpacked extension ..." and point to the new project directory.
  - It's installed! You should see a new button in your address bar. Click it!

CUSTOMIZATION

  I created background app, popup and content script entry points. You can delete if anything not required. 
  I done minification and done setting of grunt task for u. Read wiki for more details.

  Permissions:
  
    For convenience, these are mostly selected by default (except "experimental",
    as it requires you run Chrome with a special flag). Be sure to comment out
    what you don't need - i.e., most of them - before distributing your extension.


WHO MADE THIS?

  Michael Mahemoff (http://mahemoff.com). I was previously working in Google's
  Chrome team, but am no longer at Google and this is not an official
  Google/Chrome project.
