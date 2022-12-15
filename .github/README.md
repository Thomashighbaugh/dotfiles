# README: Dotfiles

<blockquote> Never Mind the Bullocks, Here's the Dotfiles!</blockquote> 
<hr/>
<blockquote>
There's unlimited supply <br/>
And there is no reason why <br/>
<br/>
<span style="font-size:2rem">...</span>
<br/> 
And you thought that we were faking <br/>
That we were all just money making <br/>
You do not believe we're for real <br/>
<br/>
Or you would lose your cheap appeal? <br/>
<br/>
Don't judge a book just by the cover <br/>
Unless you cover just another <br/>
And blind acceptance is a sign <br/>
Of stupid fools who stand in line <br />
</blockquote>
<figcaption> - The Sex Pistols <b>"EMI"</b> from the album <cite>Nevermind the Bullocks, Here's the Sex Pistols</cite></figcaption>

<img src=".github/assets/dreams.gif" alt="pictoral representation of the state of the repository at any given moment depicting palm trees engulfed in flames due to nearby nuclear testing" />

<h2>Introduction</h2>

<p>The files in this repository are my configurations powering my <span style="background-color:#1d1e22; color: #555566; font-size:85%;">archlinux</span> setup and the installation scripts that place them into the directories the system reads them from, after first installing the software that is.</p>

<p>This means that you are feasting your eyes upon a bare git repository featuring a home-rolled installation and configuration management system written by yours truly that has been derived from the organic process of reinstallations and daily management of these files and my system over all. </p>

<h2> Installation Scripts </h2>
<p>At this point, the history of this repo reflects my use of a litany of tools to arrive a useful configuration following the need to install or reinstall, from ansible to Makefiles. I have settled, for now, on using the much more precise but fickle set of BASH scripts found in the `install` subdirectory.</p>

<b>My goals for the installation process include:</b>

<ul>
<li>symlinking files within this repository to various locations in home so they are editable without needing to fuss with copying them over to the intended location again</li>
<li>copying over set-and-forget configurations I like having system wide and do not edit, thus need not symlink</li>
<li>adding in the extra package repositories I use to save me compule time</li>
<li>cloning the other configurations I back up to git, in the locations they are expected by the system to be in, but are too big and unruly to contain within this repository. Like my awesomewm configuration </li>
<li>Menu driven process breaking up installation into several portions that are idempotent (can run them multiple times over and over without changing the result, important for debugging <i>Tom style</i>)</li>
<li>Output to a log file to ease debugging when things go wrong, as they so often do </li>
</ul>

<hr/>

<h2></h2>
