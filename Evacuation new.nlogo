turtles-own [fast]
patches-own [fire-strength]
breed [cars car]

to setup
  clear-all
  setup-patches
  setup-turtles
  ask patch -59 0 [sprout-cars 1[set shape "car" set size 5]]
  reset-ticks
end

to go
;  if ticks mod 10 = 0 [
;    if ticks < 300 [
;    let t random 6
;    if t = 0 [set fire-spread-here "metropolis" create-fire ]
;    if t = 1[set fire-spread-here "town" create-fire ]
;    if t = 2[set fire-spread-here "village" create-fire]
;    if t = 3[set fire-spread-here "thorpe" create-fire]
;    if t = 4[set fire-spread-here "city" create-fire]
;    if t = 5[set fire-spread-here "abode" create-fire     ]
;  ]
;]
  if any? patches with [fire-strength > 0] [spread-fire]
  ask turtles with [breed != cars][
    let d 0
    let r 0
    if pxcor > 58 [set r 1]
    if pxcor < -58 [set r 1]
    if pycor > 58 [set r 1]
    if pycor < -58 [set r 1]

  ask patch-here[
     if fire-strength > 1.0 [set d 1]
    ]
    if d = 1 [die]
    let x 0
      ask patch-ahead 1[
      ifelse pcolor = red
      [set x 1]
      [set x 0]
    ]
    ifelse x = 0[ifelse any? cars in-radius 2 and r = 0 [car-move][stroll]][evacuate]
  ]
  tick
end

to setup-turtles
  set-default-shape turtles "person" ;makes them look like people
  ask n-of number-metropolis patches with [pxcor < -1 and pycor < 55 and pxcor > -55 and pycor > 5 and pcolor = black]
  [
    sprout 1 [
      set fast 1 + random  3
      set size 4
      set color yellow
    ]
  ]

  ask n-of number-city patches with [pxcor < 30 and pycor < 55 and pxcor > 1 and pycor > 5 and pcolor = black]
  [
  sprout 1 [
      set fast 1 + random 3
      set size 4
      set color red
    ]
  ]

  ask n-of number-village patches with [pxcor < 55 and pycor < 55 and pxcor > 32 and pycor > 5 and pcolor = black]
  [
  sprout 1 [
      set fast 1 + random 3
      set size 4
      set color green
      ]
   ]

   ask n-of number-town patches with [pxcor < -10 and pycor < -5  and pxcor > -55 and pycor > -55 and pcolor = black]
 [
 sprout 1 [
      set fast 1 + random 3
      set size 4
      set color pink
    ]
  ]

   ask n-of number-thorpe patches with [pxcor > 1 and pycor < -5  and pxcor < 40 and pycor > -55 and pcolor = black]
 [
 sprout 1 [
      set fast 1 + random 3
      set size 4
      set color white
    ]
  ]

 ;; abode - cottage
   ask n-of number-abode patches with [pxcor < 55 and pycor < -5 and pxcor > 40 and pycor > -55 and pcolor = black]
 [
 sprout 1 [
      set fast 1 + random 3
      set size 4
      set color orange
    ]
 ]
  reset-ticks
 end

to setup-patches

  draw-wall
  draw-exit
  ask patches [ set fire-strength 0]
    ;Labels
  ask patch -25 25[
    set plabel-color white
    set plabel "Metropolis"
  ]
  ask patch 15 25[
    set plabel-color white
    set plabel "City"
  ]
  ask patch 45 25[
    set plabel-color white
    set plabel "Village"
  ]
   ask patch -25 -25[
    set plabel-color white
    set plabel "Town"
  ]
   ask patch 24 -25[
    set plabel-color white
    set plabel "Thorpe"
  ]
   ask patch 53 -25[
    set plabel-color white
    set plabel "Abode"
  ]
   ask patch -15 0[
    set plabel-color white
    set plabel "Exit"
  ]

   ask patch 30 0[
    set plabel-color white
    set plabel "Exit"
  ]
   ask patch -3 -20[
    set plabel-color yellow
    set plabel "Exit"
  ]
  ask patch -3 -40[
    set plabel-color yellow
    set plabel "Exit"
  ]
end

to draw-wall
  ask patches with [pxcor >= -56 and pxcor <= 56 and pycor = 4]
    [set pcolor blue]
  ask patches with [pxcor <= 56 and pxcor >= -56 and pycor = 56]
    [set pcolor blue]
  ask patches with [pxcor <= 56 and pxcor >= -56 and pycor = -56]
    [set pcolor blue]
  ask patches with [pycor <= 56 and pycor >= -56 and pxcor = -56]
    [set pcolor blue]
  ask patches with [pycor <= 56 and pycor >= -56 and pxcor = 56]
    [set pcolor blue]
  ask patches with [pycor <= 56 and pycor >= 4 and pxcor = 0]
    [set pcolor blue]
  ask patches with [pycor >= -56 and pycor <= -4 and pxcor = 41]
    [set pcolor blue]
  ask patches with [pycor <= -4 and pycor >= -56 and pxcor = -9]
    [set pcolor blue]
   ask patches with [pxcor >= -56 and pxcor <= -9 and pycor = -4]
    [set pcolor blue]
   ask patches with [pycor >= 4 and pycor <= 56 and pxcor = 31]
    [set pcolor blue]
  ask patches with [pycor <= -4 and pycor >= -56 and pxcor = 0]
    [set pcolor blue]
  ask patches with [pxcor <= 56 and pxcor >= 0 and pycor = -4]
    [set pcolor blue]
  end

to draw-exit
  ask patches with [pxcor < -25 and pxcor >= -25 - wall-distance-x and pycor = 4]
    [set pcolor black]
  ask patches with [pxcor > 20 and pxcor <= 20 + wall-distance-x and pycor = 4]
    [set pcolor black]
  ask patches with [pxcor > 42 and pxcor <= 42 + wall-distance-x and pycor = 4]
    [set pcolor black]
  ask patches with [pxcor < -25 and pxcor >= -25 - wall-distance-x and pycor = -4]
    [set pcolor black]
  ask patches with [pxcor > 25 and pxcor <= 25 + wall-distance-x and pycor = -4]
    [set pcolor black]
  ask patches with [pxcor > 46 and pxcor <= 46 + wall-distance-x and pycor = -4]
    [set pcolor black]
  ask patches with [pycor < -25 and pycor >= -25 - wall-distance-y and pxcor = -9]
    [set pcolor black]
  ask patches with [pycor < -25 and pycor >= -25 - wall-distance-y and pxcor = 41]
    [set pcolor black]
  ask patches with [pycor > 25 and pycor <= 25 + wall-distance-y and pxcor = 0]
    [set pcolor black]
  ask patches with [pycor > 25 and pycor <= 25 + wall-distance-y and pxcor = 31]
    [set pcolor black]
  ask patches with [pxcor > -9 and pxcor < 0 and pycor = -56]
    [set pcolor orange]
  ask patches with [pycor > -4 and pycor < 4 and pxcor = 56 ]
    [set pcolor orange]
  ask patches with [pycor > -4 and pycor < 4 and pxcor = -56 ]
    [set pcolor orange]
 end

to stroll
  rt random 360
  let y 0
  ask patch-ahead 1
  [
    ifelse pcolor = blue [set y 1][set y 0]
  ]
  while [y = 1]
  [
    rt 90
    ask patch-ahead 1
  [
    ifelse pcolor = blue [set y 1][set y 0]
  ]
    ]
  fd fast / 4
end

to car-move

  ;if any? cars in-radius 1 [
    face one-of cars in-radius 2
    fd 1
end

to create-fire
  if fire [
  let x 0
  let y 0
  if fire-spread-here = "metropolis" [
  set x -1 + random -55 ; -1 to -55
  set y 5 + random 51 ; 5 to 55
  ]
  if fire-spread-here = "city" [
    set x 1 + random 30 ; 1 to 30
    set y 5 + random 51 ; 5 to 55
  ]
  if fire-spread-here = "village" [
    set x 32 + random 24 ; 32 to 55
    set y 5 + random 51 ; 5 to 55
  ]
  if fire-spread-here = "town" [
    set x -10 + random -46 ; -10 to -55
    set y -5 + random -51 ; -5 to -55
  ]
  if fire-spread-here = "thorpe" [
    set x  1 + random 40 ; 1 to 40
    set y -5 + random -51 ; -5 to -55
  ]
  if fire-spread-here = "abode" [
  set x 42 + random 14 ;42 to 55
    set y -5 + random -51 ; -5 to -55
  ]

  ask patch x y [
    set fire-strength 2.0
    set pcolor red
    if fire-spread-here = "metropolis" [
      ask patches with [pcolor != blue and pxcor < 0 and pxcor > -56 and pycor < 56 and pycor > 4] in-radius explosion-radius[set fire-strength random-float 1.0]
    ]

    if fire-spread-here = "city" [
      ask patches with [pcolor != blue and pxcor < 31 and pxcor > 0 and pycor < 56 and pycor > 4] in-radius explosion-radius[set fire-strength random-float 1.0]
    ]

    if fire-spread-here = "village" [
      ask patches with [pcolor != blue and pxcor < 56 and pxcor > 31 and pycor < 56 and pycor > 4] in-radius explosion-radius[set fire-strength random-float 1.0]
    ]

    if fire-spread-here = "town" [
      ask patches with [pcolor != blue and pxcor < -9 and pxcor > -56 and pycor < -4 and pycor > -56] in-radius explosion-radius[set fire-strength random-float 1.0]
    ]

    if fire-spread-here = "thorpe" [
      ask patches with [pcolor != blue and pxcor < 41 and pxcor > 0 and pycor < -4 and pycor > -56] in-radius explosion-radius[set fire-strength random-float 1.0]
    ]

    if fire-spread-here = "abode" [
      ask patches with [pcolor != blue and pxcor < 56 and pxcor > 41 and pycor < -4 and pycor > -56] in-radius explosion-radius[set fire-strength random-float 1.0]
    ]
    ;ask patches with [pcolor != blue] in-radius explosion-radius[set fire-strength random-float 1.0]
  ]
]
end

to evacuate
  let col 0
  ask patch-ahead 1 [if pcolor = red [set col 1]]

  if col = 0 [
    ask patch-ahead 2 [if pcolor = red [set col 1]]
  ]
  if col = 1 [
    rt 180
    fd fast / 4
  ]
end

to spread-fire
  ask patches with[pcolor != blue]
  [
    if fire-strength > 0 [
      set fire-strength fire-strength + fire-strength * fire-growth-rate
    ]
    if fire-strength > 0 [
      set pcolor scale-color red fire-strength 10 -5
    ]
  ]
  if not any? patches with [fire-strength > 0 and fire-strength < 15 ][ask patches with [fire-strength > 15][set fire-strength 0]]
end

to move-up
  ask cars [ set heading 0 fd 1]
end

to move-right
  ask cars [ set heading 90 fd 1]
end

to move-down
  ask cars [ set heading 180 fd 1]
end

to move-left
  ask cars [ set heading 270 fd 1]
end
@#$#@#$#@
GRAPHICS-WINDOW
470
30
930
491
-1
-1
3.21
1
10
1
1
1
0
1
1
1
-70
70
-70
70
1
1
1
ticks
30.0

SLIDER
6
92
178
125
number-city
number-city
50
150
150.0
1
1
NIL
HORIZONTAL

SLIDER
5
131
177
164
number-village
number-village
50
120
120.0
1
1
NIL
HORIZONTAL

SLIDER
6
211
178
244
number-town
number-town
50
90
90.0
1
1
NIL
HORIZONTAL

BUTTON
8
12
71
45
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
5
54
177
87
number-metropolis
number-metropolis
50
225
225.0
1
1
NIL
HORIZONTAL

SLIDER
7
170
179
203
number-thorpe
number-thorpe
0
15
15.0
1
1
NIL
HORIZONTAL

SLIDER
6
251
178
284
number-abode
number-abode
3
7
7.0
1
1
NIL
HORIZONTAL

BUTTON
93
14
156
47
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

SLIDER
5
294
177
327
wall-distance-x
wall-distance-x
0
5
5.0
1
1
NIL
HORIZONTAL

SLIDER
7
333
179
366
wall-distance-y
wall-distance-y
0
5
3.0
1
1
NIL
HORIZONTAL

SLIDER
7
372
179
405
explosion-radius
explosion-radius
0
20
3.0
1
1
NIL
HORIZONTAL

SWITCH
192
116
295
149
fire
fire
0
1
-1000

MONITOR
196
454
279
499
Turtles Alive
count turtles with [shape = \"person\"]
17
1
11

SLIDER
0
414
182
447
fire-growth-rate
fire-growth-rate
0
0.1
0.02
0.01
1
NIL
HORIZONTAL

BUTTON
354
64
444
98
create-fire
create-fire
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
189
58
328
103
fire-spread-here
fire-spread-here
"metropolis" "city" "village" "thorpe" "town" "abode"
5

MONITOR
294
456
379
501
Turtles killed 
number-metropolis + number-city + number-village + number-thorpe + number-town + number-abode - count turtles with [shape = \"person\"]
17
1
11

PLOT
191
293
391
443
plot 1
Killed
Alive
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot count turtles"
"pen-1" 1.0 0 -11783835 true "" "plot number-metropolis + number-city + number-town + number-village + number-thorpe + number-abode - count turtles"

TEXTBOX
1123
441
1273
459
NIL
11
0.0
1

MONITOR
184
175
261
220
Metropolis Alive
count turtles with [color = yellow]
17
1
11

MONITOR
268
176
333
221
City Alive
count turtles with [color = red]
17
1
11

MONITOR
342
175
420
220
Village Alive
count turtles with [color = green]
17
1
11

MONITOR
182
229
255
274
Town Alive
count turtles with [color = pink]
17
1
11

MONITOR
265
232
347
277
Thorpe Alive
count turtles with [color = white]
17
1
11

MONITOR
354
232
433
277
Abode Alive
count turtles with [color = orange]
17
1
11

BUTTON
1034
140
1097
173
up
move-up
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
1

BUTTON
1034
173
1097
206
down
move-down
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
1096
159
1159
192
right
move-right
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

BUTTON
971
160
1034
193
left
move-left
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
1

@#$#@#$#@
# Modeling the Evacuation Process in different Regions/Situations

## Overview

###  Purpose
The purpose of the model is to simulate the number of citizens that can be saved in times of accidents. This model can also be applied to the number of forest animals that can be alive if we set the forest on fire. Our model shows that the number of lives that can be saved depends on the density of the population and is inversely proportional.

### Patterns
Initially, citizens are set up randomly in their respective areas. After we run the model, citizens keep visiting/moving to different places through the paths between walls. If we close the paths between different places, citizens of each place remain there moving randomly.
Citizens try to move away from the fire to save their lives. Unfortunately, some citizens that are away from the fire might also lose their lives due to their random behaviour. We can consider these citizens as asthma patients dying from low oxygen levels due to fire. In the simulation, it is shown as citizens close to the fire moving into it and dying.
	citizens that are in the exit or outside the environment under study are safe and cannot be killed unless the observer wants to bring them inside the environment. We have plotted the number of citizens killed and citizens that are alive against ticks. We can see that both the curves converge and then diverge.

### Process overview and scheduling

Each tick ,the following processes are processed:
Citizens move randomly. The while loop in the stroll procedure checks if there is a wall ahead of the Citizen and turns the citizen by 90 degrees so that the person doesn’t bump into the wall. If the observer creates fire at some place, the citizens that are in the fire region die according to the fire-strength of the patch. The citizens that are too close to the fire will also die if they go into the red patch following their random behaviour

## Design concepts

### Basic principle
citizens keep moving randomly wherever there is a path unless there is fire. If there is a fire then according to the behaviour of each citizen, the citizen gets escaped from the fire i.e they will just move away from the patch radius where fire is present.

### Emergence
citizens move away from fire to save their lives. In case of congestion, some citizens move into the fire and die. 
In case of higher emergence, the observer can operate the car using buttons i.e (up, down, left, right) or using actions i.e (w, s, a, d) to make citizens follow the car till they come out of the environment. Hence, this will save some citizens.

### Adaptation
citizens choose if they should follow the stroll movements or follow the evacuation movements according to if there is fire or not in the patch ahead of the citizen.
  
### Objectives 
The citizens turn 90 degrees if there is a patch with blue color ahead of it which avoids collision. The turles try not to go into the fire following evacuation protocol and save their lives.

### Prediction 
The citizen checks the color of the patch ahead of it and behaves accordingly.

### Sensing
The citizen can sense if there is a car in a radius of 2 and follow it.

### Interaction 
There is interaction between walls and turtles( agent to environment).
There is interaction between fire and turtles(agent to environment).
There is interaction between cars and turtles(Agent to Agent).

### Stochasticity 
The speed of the turtle is randomly generated using a variable fast. We are trying to reproduce the observed behaviours in the real world such as not bumping into the wall, not going into the fire etc

### Collectives
The observer can control the car and affect the movement of citizens.


### Observation
Currently, if we spread the fire without pausing, all the turtles will die. We need to solve this problem by updating the evacuation protocol.

## Details
### Initialization 
Before we start the simulation, turtles alive will be equal to the total number of turtles in the shape of a person.
Fast is a turtle variable which will be initiated randomly when turtles are created.
Fire-strength is a patch variable initiated to 1.



### Input data

**Monitors**
Turtles Alive - counts the total number of turtles that are alive.
Turtles killed - counts the total number of turtles that could not be saved(killed).
Metropolis Alive - counts the number of metropolis citizens that are alive.
City Alive - counts the number of city citizens that are alive.
Village Alive - counts the number of village citizens that are alive.
Town Alive - counts the number of town citizens that are alive.
Thorpe Alive - counts the number of thorpe citizens that are alive.
Abode Alive - counts the number of abode citizens that are alive.

**Sliders**
number-metropolis : Choosing the number of turtles that must present in metropolis area.
number-city : Choosing the number of turtles that must present in city area.
number-village : Choosing the number of turtles that must present in village area.
number-town : Choosing the number of turtles that must present in town area.
number-thorpe : Choosing the number of turtles that must present in thorpe area.
number-abode : Choosing the number of turtles that must present in abode area.
wall-distance-x : Choosing the width of exit for walls parallel to X-axis.
wall-distance-y : Choosing the width of exit for walls parallel to Y-axis.
explosion-radius : Choosing the radius in which fire should spread.
fire-growth-rate : chooses the rate at which fire strength should grow.

**Buttons**
setup : To setup walls-exits and turtles.
go : To move turtles, spread fire and kill turtles.
create-fire : This will create fire accordingly.

**Choosers**
fire-spread-here : In this chooser we have six options and they are Metropolis, village, city, town, thorpe, abode. when we choose any one the area from the above then the fire will be spread randomly in the selected area.

**Plot**
X axis label - killed 
Y axis label - Alive

This will plot a grap between total number of turtles alive vs total number of turtles killed.

### Submodels 
No submodels used

## Results 
By this simulation, we can save the citizens by two methods. The first method is, when fire produces randomly in different positions, based on the behaviour of the citizens they will act in the environment accordingly and save their life.

The second method is for the observer, the observer can control the car to evacuate the people from various locations. 

Hence, by using these two methods we are saving the lives of the citizens.




@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment for wall distance 3 and 5" repetitions="4" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>ticks = 300</exitCondition>
    <metric>count turtles with [shape = "person"]</metric>
    <metric>number-metropolis + number-city + number-village + number-thorpe + number-town + number-abode - count turtles with [shape = "person"]</metric>
    <enumeratedValueSet variable="number-abode">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wall-distance-y">
      <value value="3"/>
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-metropolis">
      <value value="102"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-city">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-thorpe">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-village">
      <value value="53"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="explosion-radius">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wall-distance-x">
      <value value="3"/>
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire-growth-rate">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-town">
      <value value="50"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment for maximium change with wall distance 1 3 5" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>ticks = 300</exitCondition>
    <metric>count turtles with [shape = "person"]</metric>
    <metric>number-metropolis + number-city + number-village + number-thorpe + number-town + number-abode - count turtles with [shape = "person"]</metric>
    <enumeratedValueSet variable="number-abode">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wall-distance-y">
      <value value="1"/>
      <value value="3"/>
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-metropolis">
      <value value="225"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-city">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire-spread-here">
      <value value="&quot;city&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-thorpe">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-village">
      <value value="120"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="explosion-radius">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wall-distance-x">
      <value value="1"/>
      <value value="3"/>
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire-growth-rate">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-town">
      <value value="90"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>ticks = 300</exitCondition>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="number-abode">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wall-distance-y">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-metropolis">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-city">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-thorpe">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-village">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="explosion-radius">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wall-distance-x">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire-growth-rate">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-town">
      <value value="50"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>ticks = 300</exitCondition>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="number-abode">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wall-distance-y">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-metropolis">
      <value value="102"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-city">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire-spread-here">
      <value value="&quot;abode&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-thorpe">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-village">
      <value value="53"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="explosion-radius">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wall-distance-x">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire-growth-rate">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-town">
      <value value="50"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>ticks = 400</exitCondition>
    <metric>count turtles with [shape = "person"]</metric>
    <metric>number-metropolis + number-city + number-village + number-thorpe + number-town + number-abode - count turtles with [shape = "person"]</metric>
    <enumeratedValueSet variable="number-abode">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-town">
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-metropolis">
      <value value="225"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-city">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-thorpe">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="explosion-radius">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-village">
      <value value="120"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wall-distance-x">
      <value value="1"/>
      <value value="2"/>
      <value value="3"/>
      <value value="4"/>
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fire-growth-rate">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wall-distance-y">
      <value value="1"/>
      <value value="2"/>
      <value value="3"/>
      <value value="4"/>
      <value value="5"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
