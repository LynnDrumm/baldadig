alias demo_picwobble {

        ;; fade pic in

        if (%dm.c < 2000) {

                if (%dm.picwobble.picfade < 180) {

                        dinc dm.picwobble.picfade .05

                }

                drawpic -nc  @demo 0 38 %dm.picwobble.pic
                drawpic -ncs @demo 0 $calc(38 + %dm.picwobble.picfade) 320 180 0 %dm.picwobble.picfade 320 1 %dm.picwobble.pic
        }

        else {

                if (%dm.c > 15000) {

                        ddec dm.picwobble.c .28
                }

                else {

                        dinc dm.picwobble.c .25
                }

                ;; draw picture by vertical lines and according to sine to the buffer (distort y)

                var %s 2

                var %cnt %dm.picwobble.fadeout
                var %pw $calc(%dm.picwobble.c / 96)

                while (%cnt < 320) {

                        if (%xor == 1) {

                                drawpic -nc @dm.picwobble.1 %cnt $calc(($sin($calc(%dm.picwobble.c + %cnt)).deg * %pw) + 38) %cnt 0 %s 179 %dm.picwobble.pic
                                var %xor 0
                        }

                        else {
                                drawpic -nc @dm.picwobble.1 %cnt $calc(($sin($calc((%dm.picwobble.c + %cnt) + %dm.picwobble.offset)).deg * %pw) + 38) %cnt 0 %s 179 %dm.picwobble.pic
                                var %xor 1
                        }

                        inc %cnt %s
                }

                if (%dm.c > 11000) {

                        dinc Dm.picwobble.offset .05
                }

                ;; copy over buffer by horizontal lines according to sine to the buffer (distort x)

                var %s 2

                var %cnt 0
                var %c/3 $calc(%dm.picwobble.c / 1.3)
                var %pw $calc(%dm.picwobble.c / 64)

                while (%cnt < 180) {

                        drawcopy -n @dm.picwobble.1 0 %cnt 320 %s @demo $calc($cos($calc(%c/3 + %cnt)).deg * %pw) %cnt 320 %s
                        inc %cnt %s
                }

                if (%dm.c > 16000) {

                        if (%dm.picwobble.fadeout < 320) {

                                dinc dm.picwobble.fadeout .12
                        }
                }

                ;; clear buffer

                drawrect -nrf @dm.picwobble.1 0 0 0 0 320 180

        }

        dmDrawFrame demo_picwobble

        if (%dm.c > 18500) {

                .signal -n dmSelectPart moire
                halt
        }
}