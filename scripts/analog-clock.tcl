#!/usr/bin/env tclsh

# Show analog clock in a small window.
# All credits go to 'wdb': http://wiki.tcl.tk/15505
# The source code is from: http://wiki.tcl.tk/1011

package require Tk

canvas .uhr -width 200 -height 200 -highlightthickness 0
wm geometry .  +[expr {[winfo screenwidth .]-[winfo reqwidth .]}]+0

pack .uhr
bind .uhr <Double-Button-1> {
    if {[expr {![wm overrideredirect .]}]} {
        wm overrideredirect . yes
        # .uhr configure -background SystemBackground
    } else {
        wm overrideredirect . no
        # .uhr configure -background SystemButtonFace
    }
}

bind . <Escape> {exit 0}

set PI [expr {asin(1)*2}]
set sekundenzeigerlaenge 85
set minutenzeigerlaenge  75
set stundenzeigerlaenge  60

proc drawClock {} {
    global PI
    global sekundenzeigerlaenge
    global minutenzeigerlaenge
    global stundenzeigerlaenge
    set aussenradius 95.0
    set innenradius  83.0
    # Ziffernblatt
    .uhr create oval 5 5 195 195 -fill white -outline ""
    # Zeiger
    .uhr create line 100 100     [expr {100+$stundenzeigerlaenge}] 100 -tag stundenschatten
    .uhr create line 100 100 100 [expr {100-$minutenzeigerlaenge}]     -tag minutenschatten
    .uhr create line 100 100 100 [expr {100+$sekundenzeigerlaenge}]    -tag sekundenschatten
    .uhr create line 100 100     [expr {100+$stundenzeigerlaenge}] 100 -tag {stundenzeiger zeiger}
    .uhr create line 100 100 100 [expr {100-$minutenzeigerlaenge}]     -tag {minutenzeiger zeiger}
    .uhr create line 100 100 100 [expr {100+$sekundenzeigerlaenge}]    -tag {sekundenzeiger zeiger}
    .uhr itemconfigure stundenzeiger    -width 8
    .uhr itemconfigure minutenzeiger    -width 4
    .uhr itemconfigure sekundenzeiger   -width 2 -fill red
    .uhr itemconfigure stundenschatten  -width 8 -fill gray
    .uhr itemconfigure minutenschatten  -width 4 -fill gray
    .uhr itemconfigure sekundenschatten -width 2 -fill gray
    # Ziffern
    for {set i 0} {$i < 60} {incr i} {
        set r0 [expr {$innenradius + 5}]
        set r1 [expr {$innenradius +10}]
        set x0 [expr {sin($PI/30*(30-$i))*$r0+100}]
        set y0 [expr {cos($PI/30*(30-$i))*$r0+100}]
        set x1 [expr {sin($PI/30*(30-$i))*$r1+100}]
        set y1 [expr {cos($PI/30*(30-$i))*$r1+100}]
        if {[expr {$i%5}]} {
        }
    }
    for {set i 0} {$i < 12} {incr i} {
        set x [expr {sin($PI/6*(6-$i))*$innenradius+100}]
        set y [expr {cos($PI/6*(6-$i))*$innenradius+100}]
        .uhr create text $x $y \
                -text [expr {$i ? $i : 12}] \
                -font {Helvetica 13 bold} \
                -fill #666666 \
                -tag ziffer
    }
    wm resizable . no no
}

proc stundenZeigerAuf {std} {
    global PI
    global stundenzeigerlaenge
    set x0 100
    set y0 100
    set dx [expr {sin ($PI/6*(6-$std))*$stundenzeigerlaenge}]
    set dy [expr {cos ($PI/6*(6-$std))*$stundenzeigerlaenge}]
    set x1 [expr {$x0 + $dx}]
    set y1 [expr {$y0 + $dy}]
    .uhr coords stundenzeiger $x0 $y0 $x1 $y1
    set schattenabstand 3
    set x0s [expr {$x0 + $schattenabstand}]
    set y0s [expr {$y0 + $schattenabstand}]
    set x1s [expr {$x1 + $schattenabstand}]
    set y1s [expr {$y1 + $schattenabstand}]
    .uhr coords stundenschatten $x0s $y0s $x1s $y1s
}

proc minutenZeigerAuf {min} {
    global PI
    global minutenzeigerlaenge
    set x0 100
    set y0 100
    set dx [expr {sin ($PI/30*(30-$min))*$minutenzeigerlaenge}]
    set dy [expr {cos ($PI/30*(30-$min))*$minutenzeigerlaenge}]
    set x1 [expr {$x0 + $dx}]
    set y1 [expr {$y0 + $dy}]
    .uhr coords minutenzeiger $x0 $y0 $x1 $y1
    set schattenabstand 4
    set x0s [expr {$x0 + $schattenabstand}]
    set y0s [expr {$y0 + $schattenabstand}]
    set x1s [expr {$x1 + $schattenabstand}]
    set y1s [expr {$y1 + $schattenabstand}]
    .uhr coords minutenschatten $x0s $y0s $x1s $y1s
}

proc sekundenZeigerAuf {sec} {
    global PI
    global sekundenzeigerlaenge
    set x0 100
    set y0 100
    set dx [expr {sin ($PI/30*(30-$sec))*$sekundenzeigerlaenge}]
    set dy [expr {cos ($PI/30*(30-$sec))*$sekundenzeigerlaenge}]
    set x1 [expr {$x0 + $dx}]
    set y1 [expr {$y0 + $dy}]
    .uhr coords sekundenzeiger $x0 $y0 $x1 $y1
    set schattenabstand 5
    set x0s [expr {$x0 + $schattenabstand}]
    set y0s [expr {$y0 + $schattenabstand}]
    set x1s [expr {$x1 + $schattenabstand}]
    set y1s [expr {$y1 + $schattenabstand}]
    .uhr coords sekundenschatten $x0s $y0s $x1s $y1s
}

proc showTime {} {
    after cancel showTime
    after 1000 showTime
    set secs [clock seconds]
    set l [clock format $secs -format {%H %M %S} ]
    wm title . [join $l :]
    set std [lindex $l 0]
    set min [lindex $l 1]
    set sec [lindex $l 2]
    regsub ^0 $std "" std
    regsub ^0 $min "" min
    regsub ^0 $sec "" sec
    set min [expr {$min + 1.0 * $sec/60}]
    set std [expr {$std + 1.0 * $min/60}]
    stundenZeigerAuf $std
    minutenZeigerAuf $min
    sekundenZeigerAuf $sec
}

drawClock
showTime
