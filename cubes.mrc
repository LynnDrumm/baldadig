alias demo_cubes {

        if (%dm.c > 2800) {

                dinc dm.cubes.colour.c $calc(%dm.bpm * 2)

                if (%dm.cubes.colour.c >= 1) {

                        set %dm.cubes.colour.1 $rand(0, 16777215)
                        set %dm.cubes.colour.2 $rand(0, 16777215)
                        set %dm.cubes.colour.3 $rand(0, 16777215)
                        set %dm.cubes.colour.4 $rand(0, 16777215)

                        set %dm.cubes.colour.c 0
                }

                ;; cube 1

                var %cos.old
                var %sin.old

                var %cnt 1

                while (%cnt <= 5) {

                        var %cos $calc(($cos($calc((%dm.c / 5) + (%cnt * 90))).deg * %dm.cubes.size) + (%dm.cubes.size + 4))
                        var %sin $calc(($sin($calc((%dm.c / 5) + (%cnt * 90))).deg * 8) + (%dm.cubes.size - 4))

                        drawline -nr @demo $calc(%dm.cubes.colour.1 - 96) 2 %cos.old       %sin.old          %cos       %sin
                        drawline -nr @demo $calc(%dm.cubes.colour.1 - 96) 2 %cos.old $calc(%sin.old + %dm.cubes.size) %cos $calc(%sin + %dm.cubes.size)
                        drawline -nr @demo $calc(%dm.cubes.colour.1 - 96) 2 %cos           %sin              %cos $calc(%sin + %dm.cubes.size)

                        drawline -nr @demo %dm.cubes.colour.1 1 %cos.old       %sin.old          %cos       %sin
                        drawline -nr @demo %dm.cubes.colour.1 1 %cos.old $calc(%sin.old + %dm.cubes.size) %cos $calc(%sin + %dm.cubes.size)
                        drawline -nr @demo %dm.cubes.colour.1 1 %cos           %sin              %cos $calc(%sin + %dm.cubes.size)

                        var %cos.old %cos
                        var %sin.old %sin

                        inc %cnt
                }

                ;; cube 2

                var %cos.old
                var %sin.old

                var %cnt 1

                while (%cnt <= 5) {

                        var %cos $calc((($cos($calc((%dm.c / 4) + (%cnt * 90))).deg * %dm.cubes.size) + (%dm.cubes.size + 4)) + %dm.cubes.offset)
                        var %sin $calc(($sin($calc((%dm.c / 4) + (%cnt * 90))).deg * 8) + (%dm.cubes.size - 4))

                        drawline -nr @demo $calc(%dm.cubes.colour.2 - 96) 2 %cos.old       %sin.old          %cos       %sin
                        drawline -nr @demo $calc(%dm.cubes.colour.2 - 96) 2 %cos.old $calc(%sin.old + %dm.cubes.size) %cos $calc(%sin + %dm.cubes.size)
                        drawline -nr @demo $calc(%dm.cubes.colour.2 - 96) 2 %cos           %sin              %cos $calc(%sin + %dm.cubes.size)

                        drawline -nr @demo %dm.cubes.colour.2 1 %cos.old       %sin.old          %cos       %sin
                        drawline -nr @demo %dm.cubes.colour.2 1 %cos.old $calc(%sin.old + %dm.cubes.size) %cos $calc(%sin + %dm.cubes.size)
                        drawline -nr @demo %dm.cubes.colour.2 1 %cos           %sin              %cos $calc(%sin + %dm.cubes.size)

                        var %cos.old %cos
                        var %sin.old %sin

                        inc %cnt
                }

                ;; cube 3

                var %cos.old
                var %sin.old

                var %cnt 1

                while (%cnt <= 5) {

                        var %cos $calc(($cos($calc((%dm.c / 3) + (%cnt * 90))).deg * %dm.cubes.size) + (%dm.cubes.size + 4))
                        var %sin $calc((($sin($calc((%dm.c / 3) + (%cnt * 90))).deg * 8) + (%dm.cubes.size - 4)) + %dm.cubes.offset)

                        drawline -nr @demo $calc(%dm.cubes.colour.3 - 96) 2 %cos.old       %sin.old          %cos       %sin
                        drawline -nr @demo $calc(%dm.cubes.colour.3 - 96) 2 %cos.old $calc(%sin.old + %dm.cubes.size) %cos $calc(%sin + %dm.cubes.size)
                        drawline -nr @demo $calc(%dm.cubes.colour.3 - 96) 2 %cos           %sin              %cos $calc(%sin + %dm.cubes.size)

                        drawline -nr @demo %dm.cubes.colour.3 1 %cos.old       %sin.old          %cos       %sin
                        drawline -nr @demo %dm.cubes.colour.3 1 %cos.old $calc(%sin.old + %dm.cubes.size) %cos $calc(%sin + %dm.cubes.size)
                        drawline -nr @demo %dm.cubes.colour.3 1 %cos           %sin              %cos $calc(%sin + %dm.cubes.size)

                        var %cos.old %cos
                        var %sin.old %sin

                        inc %cnt
                }

                ;; cube 4

                var %cos.old
                var %sin.old

                var %cnt 1

                while (%cnt <= 5) {

                        var %cos $calc((($cos($calc((%dm.c / 4.5) + (%cnt * 90))).deg * %dm.cubes.size) + (%dm.cubes.size + 4)) + %dm.cubes.offset)
                        var %sin $calc((($sin($calc((%dm.c / 4.5) + (%cnt * 90))).deg * 8) + (%dm.cubes.size - 4)) + %dm.cubes.offset)

                        drawline -nr @demo $calc(%dm.cubes.colour.4 - 96) 2 %cos.old       %sin.old          %cos       %sin
                        drawline -nr @demo $calc(%dm.cubes.colour.4 - 96) 2 %cos.old $calc(%sin.old + %dm.cubes.size) %cos $calc(%sin + %dm.cubes.size)
                        drawline -nr @demo $calc(%dm.cubes.colour.4 - 96) 2 %cos           %sin              %cos $calc(%sin + %dm.cubes.size)

                        drawline -nr @demo %dm.cubes.colour.4 1 %cos.old       %sin.old          %cos       %sin
                        drawline -nr @demo %dm.cubes.colour.4 1 %cos.old $calc(%sin.old + %dm.cubes.size) %cos $calc(%sin + %dm.cubes.size)
                        drawline -nr @demo %dm.cubes.colour.4 1 %cos           %sin              %cos $calc(%sin + %dm.cubes.size)

                        var %cos.old %cos
                        var %sin.old %sin

                        inc %cnt
                }

                ;drawcopy -n @demo 0 0 %dm.cubes.offset                  %dm.cubes.offset      @demo       %dm.cubes.offset              0            %dm.cubes.offset            %dm.cubes.offset
                ;drawcopy -n @demo 0 0 $calc(%dm.cubes.offset * 2)       %dm.cubes.offset      @demo        0             %dm.cubes.offset      $calc(%dm.cubes.offset * 2)       %dm.cubes.offset
                drawcopy -n @demo 0 0 $calc(%dm.cubes.offset * 2) $calc(%dm.cubes.offset * 2) @demo $calc(%dm.cubes.offset * 2)         0      $calc(%dm.cubes.offset * 2) $calc(%dm.cubes.offset * 2)
                drawcopy -n @demo 0 0 $calc(%dm.cubes.offset * 4) $calc(%dm.cubes.offset * 2) @demo        0       $calc(%dm.cubes.offset * 2) $calc(%dm.cubes.offset * 4) $calc(%dm.cubes.offset * 2)

                ;; fadein

                var %cnt 1
                var %tot $numtok(%dm.cubes.squaretab, 44)

                while (%cnt <= %tot) {

                        drawrect -nrf @demo 0 0 $gettok(%dm.cubes.squaretab, %cnt, 44) 43 43

                        inc %cnt
                }

                dinc dm.cubes.squaretab.c %dm.bpm

                if (%dm.cubes.squaretab.c >= 1) {

                        set %dm.cubes.squaretab $deltok(%dm.cubes.squaretab, $rand(1, $numtok(%dm.cubes.squaretab, 44)), 44)
                        set %dm.cubes.squaretab.c
                }

                ;; fadeout

                if (%dm.c > 9000) {

                        drawcopy -n @demo 0 0 165 180 @demo $calc(0 - %dm.cubes.fadeout.1) 0 165 180
                        drawrect -nrf @demo 0 0 $calc(165 - %dm.cubes.fadeout.1) 0 $calc(0 + (%dm.cubes.fadeout.1)) 180

                        dinc dm.cubes.fadeout.1 .075
                }

        }

        if (%dm.c < 3000) {

                if (%dm.cubes.picfade < 180) {

                        dinc dm.cubes.picfade .07

                }

                drawpic -nc  @demo $calc(320 - 153) 0 %dm.cubes.pic
                drawpic -ncs @demo $calc(320 - 153) %dm.cubes.picfade 320 180 0 %dm.cubes.picfade 320 1 %dm.cubes.pic
        }

        else {

                drawpic -nc @demo $calc((320 - 153) + %dm.cubes.fadeout.1) 0 %dm.cubes.pic
        }

        dmDrawFrame demo_cubes

        if (%dm.c > 11500) {

                .signal -n dmSelectPart vertscroll
                halt
        }
}


alias gentab {
        var %x 0
        while (%x < 170) {

                var %y 0

                while (%y < 170) {

                        var %r $instok(%r, $+(%x,$chr(32),%y), $rand(1, $numtok(%r, 44)), 44)

                        inc %y 43
                }

                inc %x 43
        }

        echo -s result: %r
}