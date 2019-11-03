---
layout: post
title: "Commenting or Uncomment a block of text in Vi"
description: Tips to help on how to Commenting or Uncomment a block of lines together in Vi
date: 2018-03-09 10:43
date_formatted: 2018-03-09 10:43
comments: true
categories: [Technical]
tags: vi, commenting, visualblock, vim, vieditor
keywords: comment, uncomment, vi, vim, editor, shortcuts, vi shortcuts, shorthands, commands, vi commands
---

Sometimes we do want to comment or uncomment a block of lines together in VI editor.
I struggle sometimes, so here are some tips.
<!--more-->

### For Uncommenting a block of text is almost the same:
```
Put your cursor on the first # character, press `CtrlV (or CtrlQ for gVim)`, and go down until the last commented line and press x, that will delete all the # characters vertically.
```

### For Commenting a block of text is almost the same:
```
* First, go to the first line you want to comment, press `Ctrl + v`. This will put the editor in the VISUAL BLOCK mode.
* Then using the arrow key and select until the last line and Now press `Shift + I` , which will put the editor in INSERT mode.
* Then press '#' character. This will add a hash to the first line.
* Then press Esc (give it a second), and it will insert a '#' character on all other selected lines.

For the stripped-down version of vim shipped with debian/ubuntu by default, type : s/^/# in the third step instead.
``` 

Reference: [Stackoverflow](http://stackoverflow.com/a/1676690/1915916)
