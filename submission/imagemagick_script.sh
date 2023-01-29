#!/bin/bash
# Negative images
convert *.jpeg -threshold 50% -separate +channel -negate img_%d.jpeg

# Make collage
montage -geometry +0+0 -tile 3x *.jpeg result.jpeg

# Convert into GIF
convert -filter Gaussian -normalize -delay 20 -loop 0 img_negated*.jpeg -resize 2048x2048^ -gravity center -extent 2048x2048 myimage.gif

# GIF1
convert myimage.gif -coalesce -resize 700x525 -fuzz 2% +dither -layers Optimize +map output.gif

# GIF2 - generate thin lines around pattern
convert myimage.gif -channel A -morphology Erode Diamond:3 +channel -morphology EdgeIn Diamond edge_pixels.gif
