alias demo_splash {

        ;; spawn new drop occasionally

        if (%dm.c < 6800) {

                ;; gradually increase rate of falling drops.
                ;; lower numbers are faster, but never spawn more than
                ;; one drop every other frame (droprate of 2)

                if (4 // %dm.c) {

                        ;; increment total drops. each drop will have a unique number.

                        inc %dm.splash.drop.t

                        ;; define x/y positions and initialize the size counter

                        set %dm.splash.drop.x. [ $+ [ %dm.splash.drop.t ] ] $rand(0,320)
                        set %dm.splash.drop.y. [ $+ [ %dm.splash.drop.t ] ] $rand(0,180)
                        set %dm.splash.drop.s. [ $+ [ %dm.splash.drop.t ] ] 1

                        ;; add drop to active drop table

                        set %dm.splash.drop.tab $addtok(%dm.splash.drop.tab, %dm.splash.drop.t, 32)
                }
        }

        ;; iterate through all "active" drops from the current offset and draw them

        var %cnt 1
        var %tot $numtok(%dm.splash.drop.tab, 32)

        while (%cnt <= %tot) {

                ;; get current drop and draw it

                var %a $gettok(%dm.splash.drop.tab, %cnt, 32)
                var %s %dm.splash.drop.s. [ $+ [ %a ] ]

                ;; sometimes, %s is $null. just skip further calculations
                ;; and drawing in that case.

                if (%s != $null) {

                        var %x $calc(%dm.splash.drop.x. [ $+ [ %a ] ] - (%s / 2))
                        var %y $calc(%dm.splash.drop.y. [ $+ [ %a ] ] - (%s / 2))
                        var %k $calc(196 - (%s * 2))

                        drawrect -nre @demo $rgb(0,%k,%k) $calc(%s / 12) %x %y %s %s

                        ;; check if max splash size has been reached

                        if (%s < 96) {

                                ;; if not, increment size

                                dinc dm.splash.drop.s. [ $+ [ %a ] ] .1
                        }

                        else {

                                ;; or remove it from the drop table

                                set %dm.splash.drop.tab $deltok(%dm.splash.drop.tab, $findtok(%dm.splash.drop.tab, %a, 32), 32)

                        }
                }

                inc %cnt
        }


        ;; fading text

        ;; check if all lines of text have been displayed

        if (%dm.splash.text.c < 8) {

                ;; increment line counter on BPM basis

                dinc dm.splash.text.c $calc(%dm.bpm / 4)

                ;; get the current line, and calculate position
                ;; so that it's centered.

                var %text %dm.splash.text. [ $+ [ $floor(%dm.splash.text.c) ] ]

                var %font Arial Black
                var %size 32

                var %x $calc(160 - ($width(%text, %font, %size) / 2))
                var %y $calc(90 - ($height(%text, %font, %size) / 2))

                ;; get the colour for fading the text in and out nicely.
                ;; just follows a simple table from black->white->black
                ;; if the end of the table has (almost) been reached,
                ;; jump back to the start

                if (%dm.splash.text.ctab.c < 255) {

                        dinc dm.splash.text.ctab.c $calc(%dm.bpm * 64)
                }

                else {
                        set %dm.splash.text.ctab.c 1
                }

                var %k $gettok(%dm.splash.text.ctab, %dm.splash.text.ctab.c, 32)

                drawtext -nr @dm.splash.3 %k $qt(%font) %size %x %y %text

                if (%dm.splash.text.interlace == 1) {

                        drawcopy -nt @dm.splash.1 $rgb(255, 255, 255) 0 0 320 180 @dm.splash.3 0 0 320 180

                        set %dm.splash.text.interlace 2
                }

                else {

                        drawcopy -nt @dm.splash.2 $rgb(255, 255, 255) 0 0 320 180 @dm.splash.3 0 0 320 180

                        set %dm.splash.text.interlace 1
                }

                drawcopy -nt @dm.splash.3 0 0 0 320 180 @demo 0 0 320 180

                drawrect -nrf @dm.splash.3 0 0 0 0 320 180
        }

        :error

        dmDrawFrame demo_splash

        if (%dm.c > 7800) {        

                .signal -n dmSelectPart copper
                halt
        }
}