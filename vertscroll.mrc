alias demo_vertscroll {

        ;; gradient background

        var %cnt 0

        while (%cnt < 3) {

                drawpic -ns @demo 0 $calc((-90 * %cnt) - %dm.vertscroll.bg.offset) 320 90 $qt($scriptdirimg\gradient.png)

                inc %cnt
        }

        if (%dm.vertscroll.bg.offset > -180) {

                ddec dm.vertscroll.bg.offset .01
        }

        else {

                set %dm.vertscroll.bg.offset -90
        }

        ;; vertical bitmap scroll

        var %cnt %dm.vertscroll.offset

        var %speed 3
        var %freq 32
        var %vol 32

        while (%cnt <= %dm.vertscroll.textLen) {

                var %y $calc(%dm.vertscroll.scrollY + (%cnt * 20))

                if (%y > -24) {

                        if (%y < 180) {

                                var %chr $right($left(%dm.vertscroll.text, %cnt), 1)

                                if ((%chr != $chr(32)) && (%chr != $chr(160))) {

                                        var %pic $qt($+($scriptdirimg\chr\05\,%chr,.png))

                                        var %sin $calc(($sin($calc((%dm.c / %speed) + (%cnt * %freq))).deg * %vol) + 144)
                                        var %cos $calc(($sin($calc(((%dm.c / %speed) + (%cnt * %freq)) + 180)).deg * %vol) + 144)

                                        drawpic -ntc @dm.vertscroll.1 0 $calc(%cos - (%vol *  6)) %y %pic
                                        drawpic -ntc @dm.vertscroll.1 0 $calc(%sin - (%vol *  4)) %y %pic
                                        drawpic -ntc @dm.vertscroll.1 0 $calc(%cos - (%vol *  2)) %y %pic
                                        drawpic -ntc @dm.vertscroll.1 0       %sin                %y %pic
                                        drawpic -ntc @dm.vertscroll.1 0 $calc(%cos + (%vol *  2)) %y %pic
                                        drawpic -ntc @dm.vertscroll.1 0 $calc(%sin + (%vol *  4)) %y %pic
                                        drawpic -ntc @dm.vertscroll.1 0 $calc(%cos + (%vol *  6)) %y %pic
                                        drawpic -ntc @dm.vertscroll.1 0 $calc(%cos - (%vol *  6)) %y %pic
                                }
                        }

                        else {

                                break
                        }
                }

                else {

                        inc %dm.vertscroll.offset
                }

                inc %cnt
        }

        drawcopy -nt @dm.vertscroll.1 $rgb(255,255,255) 0 0 320 180 @demo 0 0 320 180

        ;; flash

        if (%dm.c > 0) {

                if (%dm.vertscroll.flash >= 1) {

                        set %dm.vertscroll.flash.c 255
                        set %dm.vertscroll.flash 0
                }

                dinc dm.vertscroll.flash %dm.bpm

                ddec dm.vertscroll.flash.c 4

                if (%dm.vertscroll.flash.c < 0) {

                        set %dm.vertscroll.flash.c 0
                }
        }

        drawrect -nrf @dm.vertscroll.1 $rgb(%dm.vertscroll.flash.c, %dm.vertscroll.flash.c, %dm.vertscroll.flash.c) 0 0 0 320 180


        ddec dm.vertscroll.scrollY .25

        dmDrawFrame demo_vertscroll

        if (%dm.c > 17000) {

                .signal -n dmSelectPart picwobble
                halt
        }
}