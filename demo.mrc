;; Demoralization v2.whogivesashit
;; this is all probably fucking terrible oh god
;; feel free to use it for your own demos if
;; you like using really dumb frameworks written
;; by a non-coder
;;
;; honestly, you probably won't have to change
;; anything here. really. there's some comments
;; that might explain more but i dunno lmao

;; --- ENGINE -----

alias dmDrawFrame {

        set %dm.c $calc($ticks - %dm.ticks.main)

        dmDebug

        drawdot @demo

        if (%dm.fs == 1) {

                drawcopy @demo 0 0 %dm.screen.w %dm.screen.h @demo.fs 0 0 %dm.fs.w %dm.fs.h
        }

        drawrect -nrf @demo 0 0 0 0 %dm.screen.w %dm.screen.h

        .timerdmDrawFrame -tmh 1 0 noop $!dmStartDraw( $1 )

        set %dm.frt $calc(%dm.c - %dm.frt.start)
}


alias dmStartDraw {

        set %dm.frt.start %dm.c
        $1
}

alias dmDebug {

        if (%dm.debug == 1) {

                inc %dm.fps.count

                if ($calc($ticks - %dm.fps.ticks.start) >= 1000) {

                        set %dm.fps.current %dm.fps.count
                        set %dm.fps.count 0
                        set %dm.fps.ticks.start $ticks
                }

                var %s $calc(4 + (%dm.screenmode * 1.75))
                var %h $height(a,terminal,%s)

                .drawtext -nrb @demo 16777215 0 terminal %s 2  2                  fps: %dm.fps.current
                .drawtext -nrb @demo 65535    0 terminal %s 2 $calc(2 + %h)       frt: %dm.frt
                .drawtext -nrb @demo 16776960 0 terminal %s 2 $calc(2 + (%h * 2)) var: $var(%dm.*, 0)
                .drawtext -nrb @demo 255      0 terminal %s 2 $calc(2 + (%h * 3)) __c: %dm.c
                .drawtext -nrb @demo 16711935 0 terminal %s 2 $calc(2 + (%h * 4)) __t: $asctime($calc($ctime - %dm.time),nn:ss)

                if (%dm.dcpf == 1) {

                        set %dm.dcpf.tot $calc(%dm.screenmode * 5)

                        var %cnt 0
                        var %t $line(@dm.debug, 0)

                        while (%cnt < %dm.dcpf.tot) {

                                .drawtext -nbr @demo 65280 0 terminal %s 2 $calc((%dm.screen.h - (%h + 2)) - (%cnt * %h)) $line(@dm.debug, $calc(%t - %cnt))

                                inc %cnt
                        }
                        .drawtext -nrb @demo 16776960 0 terminal %s 2 $calc((%dm.screen.h - (%h + 2)) - (%cnt * %h)) dcpf: %dm.dcpf.cnt
                }

                set %dm.dcpf.cnt 0
        }
}

alias dmInit {

        if ($version != 6.35) {

                echo -a No. Read the fucking nfo.
                halt
        }

        ;; set debug display options here

        set %dm.debug 0
        set %dm.dcpf  0

        set %dm.dcpf.cnt 0

        window -h @dm.debug
        clear @dm.debug

        echo @dm.debug .
        echo @dm.debug .
        echo @dm.debug .
        echo @dm.debug .
        echo @dm.debug .

        ;;--------------------------------------------------------
        ;;
        ;; okay, here we go! Experimental screenmode support!
        ;;
        ;; the system used to be fixed to resolutions of 320*180.
        ;; this is mainly for speed purposes, since mIRC is slower
        ;; than a snail on opiates.
        ;;
        ;; However, for some parts it may be desired to have a higher
        ;; resolution.
        ;;
        ;; What we do is, we define at the start different screenmodes.
        ;; When selecting a part, the signal "<partname> run" will be sent.
        ;; from there, you can simply execute the following:
        /*

        on *:SIGNAL:demo_foo: {

                if ($1 == run) {

                        dmScreenMode n
                }
        }

        */
        ;;
        ;; Where n is any of the following modes:
        ;;
        ;; 1) 320*180
        ;; 2) 640*360
        ;; 3) 854*480
        ;; 4) 1280*720
        ;; 5) 1600*900
        ;; 6) 1920*1080
        ;;
        ;; This list will be expanded; any future modes will be added
        ;; at the end of the list, and thus it is not sorted from lores
        ;; to hires.
        ;;
        ;; If you don't set a screenmode on init_run, don't worry. It'll
        ;; safely assume 320*180 for compatibility.
        ;;
        ;; Of course your custom screen will still be copied to the
        ;; fullscreen window if fullscreen is enabled, so keep in mind
        ;; that screenmodes will most likely be limited to 16:9 aspect
        ;; ratio resolutions.
        ;;
        ;; And please be aware that this has *nothing* to do with any
        ;; background buffers you may want to use. Those are still
        ;; "unlimited" in size, although using buffers equal to or
        ;; larger than the native resolution of the target machine
        ;; has a tendency to bug out.

        dmScreenMode 1

        window -ao @demo

        if ($1 == fs) {

                set %dm.fs.w $window(-1).w
                set %dm.fs.h $window(-1).h

                if ($window(@demo.fs) != $null) {

                        window -c @demo.fs
                }

                window -dak0pfBbo +d @demo.fs 0 0 %dm.fs.w %dm.fs.h

                set %dm.fs 1

                tokenize 32 $2-
        }

        elseif ($1 == fs2) {

                ;; this is purely for me to test shit on my projector
                ;; regardless, if you want to run fullscreen on a second monitor,
                ;; just adjust the settings below at your own discretion.

                set %dm.fs.w 1280
                set %dm.fs.h 800

                if ($window(@demo.fs) != $null) {

                        window -c @demo.fs
                }

                window -dak0pfBbo +d @demo.fs 1600 0 %dm.fs.w %dm.fs.h

                set %dm.fs 1

                tokenize 32 $2-
        }

        set %dm.flags $1-

        set %dm.ticks.main $ticks
        set %dm.fps.ticks.start $ticks
        set %dm.fps.count 0

        set %dm.preload.cnt 1
        set %dm.preload.ctab 0 197379 395015 657930 986639 1250068 1579032 1907997 2302498 2631720 3026222 3421236 3815994 4276289 4671303 5066062 5526613 6052700 6513506 6974058 7434609 7895160 8355967 8882055 9342606 9803413 10263708 10789796 11250346 11645362 12105912 12500927 12895685 13421771 13750737 14145495 14539996 14869218 15198183 15527148 15856112 16119029 16382200 16579836 16777215 16579836 16382201 16119029 15855856 15527148 15198183 14869218 14539996 14145495 13750737 13355979 12961221 12500926 12105912 11645361 11185066 10789796 10263965 9803157 9342606 8882055 8421504 7895160 7434609 6974058 6513506 5987419 5592405 5066317 4736839 4276544 3815994 3421235 3026477 2631720 2236962 1907997 1578776 1250067 986894 723722 395015 197379 0
        set %dm.preload.c 1

        window -he @dm.log
        clear @dm.log

        .load -rs $qt($scriptdirpreload.mrc)

        set %dm.ticks $ticks

        .signal -n dmSelectPart preload
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alias dinc {

        inc $+(%,$1) $calc(%dm.frt * $2)
}

alias ddec {

        dec $+(%,$1) $calc(%dm.frt * $2)
}

alias dmScreenMode {

        var %modes.w 320   640   854  1280  1600  1920
        var %modes.h 180   360   480   720   900  1080

        if ($isid) {

                if ($1 == $null) {

                        return %dm.screenmode
                }

                else {
                        if ($prop == w) {

                                return $gettok(%modes.w, $1, 32)
                        }

                        elseif ($prop == h) {

                                return $gettok(%modes.h, $1, 32)
                        }
                }
        }

        if ($1 isnum) {

                echo -s Setting screenmode: $1

                set %dm.screen.w $gettok(%modes.w, $1, 32)
                set %dm.screen.h $gettok(%modes.h, $1, 32)

                set %dm.screenmode $1
        }

        elseif ($1 == -c) {

                echo -s Setting custom screenmode: $2-

                set %dm.screen.w $2
                set %dm.screen.h $3

                set %dm.screenmode 0
        }
        set %dm.screen.x $calc($window(-1).w - %dm.screen.w)
        set %dm.screen.y 0

        ;echo -s Screen will be set to %dm.screen.w * %dm.screen.h

        window -dk0pfbB +b @demo %dm.screen.x %dm.screen.y %dm.screen.w %dm.screen.h
}

alias dmExit {

        ;; Demoralization is a polite demosystem that (mostly)
        ;; cleans up after itself before leaving, as any decent
        ;; being would do.

        .timerdmDrawFrame off
        splay stop
        drawpic -c
        unset %dm.*

        if ($window(@demo) != $null) {

                window -c @demo
        }

        if ($window(@demo.fs) != $null) {

                window -c @demo.fs
        }

        var %cnt 1
        var %tot $window(@dm.*, 0)

        while (%cnt <= %tot) {

                var %win $window(@dm.*, %cnt)

                if ((%win != $null) && (%win != @dm.log)) {

                        window -c %win
                }

                inc %cnt
        }

        if ($script(debug.mrc) != $null) {

                .unload -rs debug.mrc
        }
}

;; Generates a colour table based on a 1*n image.
;; $1- refers to any image.

alias dmGenCtab {

        var %pic $1-
        var %cnt 1
        var %tot $pic(%pic).height

        var %r

        if ($window(@palgen) != $null) {

                window -c @palgen
        }

        window -dak0pfh @palgen 0 0 1 %tot

        drawpic @palgen 0 0 $qt(%pic)

        while (%cnt <= %tot) {

                var %r $instok(%r, $getdot(@palgen, 0, %cnt), 0, 32)

                inc %cnt
        }

        ;; for some reason this garbage number is added to the end
        ;; of every table. This is just a quick'n'dirty hack to
        ;; get rid of it.

        return $remove(%r, 4294967295)

        window -c @palgen
}

;; Opens a new background window/buffer/whatev
;; $1 == window name, $2- == w / h

alias dmOpenBuffer {

        window -dk0pfh $1 0 0 $2-
        drawrect -nrf $1 0 0 0 0 $2-
}

;; Tiles an image across a background buffer
;; $1 == window, $2 == image
alias dmTilePic {

        var %win        $1
        var %win.w      $window(%win).w
        var %win.h      $window(%win).h
        var %pic        $2
        var %pic.w      $pic(%pic).width
        var %pic.h      $pic(%pic).height

        var %x 0

        while (%x < %win.w) {

                var %y 0

                while (%y < %win.h) {

                        drawpic -n %win %x %y %pic

                        inc %y %pic.h
                }

                inc %x %pic.w
        }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ---- EVENTS ----
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

on *:SIGNAL:dmSelectPart: {

        dmScreenMode 1

        signal -n $+(demo_,$1) init
        signal -n $+(demo_,$1) run

        set %dm.ticks.main $ticks
        set %dm.fps.ticks.start $ticks
        ;set %dm.fps.count 0
        set %dm.c 0
        set %dm.frt.start 0

        $+(demo_,$1)
}

on *:CLOSE:@demo*: {

        dmExit
}

on *:KEYDOWN:*:*: {

        echo -s Keypress: $keyval


        ;; ESC
        if ($keyval == 27) {

                dmExit
        }

        ;; space

        if ($keyval == 32) {

                echo -s %dm.c
        }


        ;; F3
        if ($keyval == 114) {

                set %dm.debug $xor(%dm.debug, 1)
        }

        ;; F4
        if ($keyval == 115) {

                set %dm.dcpf $xor(%dm.dcpf, 1)

                if (%dm.dcpf == 1) {

                        .load -rs $qt($scriptdirdebug.mrc)
                }

                else {

                        .unload -rs $qt($scriptdirdebug.mrc)
                }
        }
        ;; F5
        if ($keyval == 116) {

                ;var %mode $dmScreenMode
                ;var %screen.w $dmScreenMode($dmScreenMode).w
                ;var %screen.h $dmScreenMode($dmScreenMode).h

                ;window -dak0pfbBo +b @debug.view $calc($window(-1).w - %screen.w) 0 %screen.w %screen.h

                .load -rs $qt($scriptdirdebug.mrc)

                set %dm.debug 0
                set %dm.debug.height 40
                set %dm.debug.total $line(@dm.debug, 0)
                set %dm.debug.offset $calc((%dm.debug.total) - (%dm.debug.height / 2))

                .timerdmDrawFrame off

                .signal -n dmSelectPart debug
        }

        ;; F6
        if ($keyval == 117) {

                set %dm.framedump 1
                echo -s framedumping enabled.
        }

        ;; up
        if ($keyval == 38) {

                dec %dm.debug.offset
        }

        ;; down
        if ($keyval == 40) {

                inc %dm.debug.offset
        }

        ;;pgup
        if ($keyval == 33) {

                dec %dm.debug.offset %dm.debug.height

        }

        ;;pgdn
        if ($keyval == 34) {

                inc %dm.debug.offset %dm.debug.height
        }
}

on *:LOAD: {

        load -rs $qt($scriptdirtools.mrc)
}

alias dmLoadPart {

        var %file $+($scriptdir,$1-)

        if ($nopath(%file) != demo.mrc) {

                echo @dm.log > %file

                .load -rs $qt(%file)
        }
}

alias baldadig {

        dmInit fs logozoom
}