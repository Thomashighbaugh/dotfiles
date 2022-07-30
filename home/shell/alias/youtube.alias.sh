#!/bin/env bash

# Youtube DL
##########################################################################
#### Warning: Do not use to download videos or audio
#### without the express permission of the copyright owner

# Download Audio Track only
alias yt-audio="yt-dlp -x  --audio-format mp3 --audio-quality 0"

# Download YouTube playlist videos in separate directory indexed by video order in a playlist
alias yt-dl-playlist="yt-dlp -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"

# Download all playlists of YouTube channel/user keeping each playlist in separate directory
alias yt-dl-user="yt-dlp -o '%(uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'  "
alias yadl-user="yt-dlp -x  --audio-format mp3 --audio-quality 0 -o  '%(uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'  "
