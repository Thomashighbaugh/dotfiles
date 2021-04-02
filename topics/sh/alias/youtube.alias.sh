#!/bin/env sh 

# Youtube DL
##########################################################################
#### Warning: Do not use to download videos or audio 
#### without the express permission of the copyright owner
## Usage: yt-audio "link-to-content"
# Download Audio Track only
alias yt-audio="youtube-dl -x  --audio-format mp3 --audio-quality 0"

# Download YouTube playlist videos in separate directory indexed by video order in a playlist
alias yt-dl-playlist="youtube-dl -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"

# Download all playlists of YouTube channel/user keeping each playlist in separate directory
alias yt-dl-user="youtube-dl -o '%(uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'  "
alias yadl-user="youtube-dl -x  --audio-format mp3 --audio-quality 0 -o  '%(uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'  "

