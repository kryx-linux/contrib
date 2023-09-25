contrib/pipewire how to
=======================

## Intro
`pipewire` is a modern multimedia server. Quoting gentoo wiki, it's strenghts are:

>  -  Minimal latency capture/playback of audio and video
>  -  Real-time multimedia processing
>  -  Multi-process architecture allowing multimedia content sharing between applications
>  -  Seamless support for ALSA, Bluez, GStreamer, JACK, PulseAudio..
>  -  applications sandboxing support with Flatpak

Getting `pipewire` to run is relatively easy on `CRUX`.
This is a simple guide and relies on further reading upon official and unofficial resources.

⚠️ Work in progress!
> Although `pipewire` works perfectly fine with everything I have thrown at it by date (HDMI, USB, Bluetooth, ..) this article is incomplete.
> You can make it better by expanding it.

## Prerequisites
  - working kernel with alsa audio
  - `opt/alsa-utils` will be installed by default as a dependency and needs to be configured by the user
  - pipewire requires a session-manager to run to operate correctly. The only supported implementation available right now is `contrib/wireplumber` and is installed by default
  - currently, pipewires default config likes to make use of `opt/alsa-ucm-conf`, consider installing that alongside the default dependency `opt/alsa-utils`

### Optional prerequisites
  - pipewire needs pulseaudio to be built with xorg-libxtst around to have the pulseaudio portal available
    - `prt-get depinst xorg-libxtst && prt-get update -fr pulseaudio`
  - `contrib/rtkit` and a realtime compatible kernel to help with latency, add your user to `rtkit` group to be able to make use of it
    - [an stackoverflow question on the topic](https://stackoverflow.com/questions/817059/what-is-preemption-what-is-a-preemtible-kernel-what-is-it-good-for)
    - [Real-Time Linux collaborative project](https://wiki.linuxfoundation.org/realtime/start)
    - [Arch wiki](https://wiki.archlinux.org/index.php/Realtime_kernel_patchset)
    - [linuxaudio.org wiki](https://wiki.linuxaudio.org/wiki/system_configuration#the_kernel)
  - please look at `contrib/pipewire/Pkgfile` for further optional dependencies listed and rebuild the package after installing new optional dependencies

## Running pipewire

### Setting up pipewire
💡 Note
> Mostly nothing of that chapter is normally needed to get a working pipewire session that manages your audio and video.
> Doing so allows for a better control of your settings, as well as running compatibility layers provided by `pipewire` for e.g. `pulseaudio`.

`pipewire` will always leverage `alsa`, so you should configure that first.
Do that with e.g. `alsamixer` and use `alsactl store` to store those settings.
Afterwards, we can configure `/etc/rc.conf` to add `alsa` and `dbus` to the SERVICES to be started.

⚠️ Things to keep in mind
> Currently, pipewires default config format might ~~always~~ change, so its advised to check either upstream or in `/usr/share/pipewire` for changes.

The default config can be copied from `/usr/share/pipewire` to `/etc/pipewire` to be modified.
Alternatively, it will read the config from `$XDG_CONFIG_HOME/pipewire`.

With the config moved to either place, you should enable wireplumber.
In `pipewire.conf`, almost at the bottom of the file, you will find the `context.exec` section where you should uncomment the lines for wireplumber:
```
#{ path = "/usr/bin/pipewire-media-session" args = ""
#  condition = [ { exec.session-manager = null } { exec.session-manager = true } ] }
```

💡 Quality of life
To make things easier to work with, you might opt for smaller configuration files, e.g. something like the following structure:

```
/etc/pipewire
├── pipewire-pulse.conf.d
│   ├── 10-rtmodule.conf
│   ├── 92-lowlatency.conf
│   └── 10-tcp.conf
└── pipewire.conf.d
    ├── 10-sessions.conf
    ├── 10-rtmodule.conf
    ├── 92-lowlatency.conf
    ├── 10-settings.conf
    └── 10-rates.conf
```

The same words count for `wireplumber` which stores its default configs in `/usr/share/wireplumber`.
You can copy to `/etc/wireplumber` and so on.


### Managing a user session
You are now ready to try out to run a pipewire session.
From a users shell run `/usr/bin/pipewire` - if there aren't any serious errors your session should be working.

You can verify your running pipewire session by examining the output of `pw-dump`.

### Running pipewire-pulse as a pulseaudio-server replacement
It is crucial that you make sure that `pulseaudio` is not started automagically before you start your `pipewire` server, or it will not work.
You can do that by adding `autospawn = no` to `/etc/pulse/client.conf`.

After that, you can theoretically start `pulseaudio-pulse` in another terminal and run `pactl info` to see what `Server Name` it returns.
It should say `Server Name: PulseAudio (on PipeWire 0.3.yy)`.
Success!

You can have that start by default by editing your sessions configurations, e.g.:

```
$ cat /etc/pipewire/pipewire.conf.d/10-sessions.conf
context.exec = [
    { path = "/usr/bin/wireplumber" args = ""
      condition = [ { exec.session-manager = null } { exec.session-manager = true } ] }
    { path = "/usr/bin/pipewire" args = "-c pipewire-pulse.conf"
      condition = [ { exec.pipewire-pulse = null } { exec.pipewire-pulse = true } ] }
]
```

Now you can use tools like `contrib/pavucontrol` or `contrib/ncpamixer` to control your typical sources and sink settings.
Ports like `opt/firefox-bin` and whatever else uses `pulseaudio` should work ootb for you too.

### Running jack applications through pipewire
⚠️ Work in progress!
> There is no jack port in CRUX and therefor this port lacks support of it.

### Debbuging pipewire
You can run `pipewire` like that from a terminal: `PIPEWIRE_DEBUG=3 pipewire`
Make sure to kill your previous session.

## tl;dr
> „I don't have any time to read up on stuff myself, tell me what I need to do right now to get this hot mess!“ -some user

 - optional: `prt-get depinst xorg-libxtst pulseaudio` et al, see Pkgfile
 - install `prt-get depinst pipewire`
 - setup `pipewire` to use `wireplumber` as your session-manager
 - execute while starting your X11/Wayland-Session: `/usr/bin/pipewire` & `/usr/bin/pipewire-pulse` & `/usr/bin/wireplumber` (setting up a basic config is cooler though)

## Ressources

  - [Official pipewire wiki](https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/home)
  - [Official ALSA wiki](https://alsa-project.org/wiki/Main_Page)
  - [Gentoo wiki - ALSA](https://wiki.gentoo.org/wiki/ALSA)
  - [Gentoo wiki - Pipewire](https://wiki.gentoo.org/wiki/PipeWire)
  - [Arch wiki - ALSA](https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture)
  - [Arch wiki - Pipewire](https://wiki.archlinux.org/index.php/PipeWire)

// vim:filetype=markdown
// End of file
