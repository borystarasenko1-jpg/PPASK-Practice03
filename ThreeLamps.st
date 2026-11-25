PROGRAM ThreeLamps
VAR
    startButton : BOOL := FALSE;
    stopButton  : BOOL := FALSE;
    prevStart   : BOOL := FALSE;
    active      : BOOL := FALSE;
    lamp1       : BOOL := FALSE;
    lamp2       : BOOL := FALSE;
    lamp3       : BOOL := FALSE;
    delayLamp2  : TON1s;
    delayLamp3  : TON1s;
END_VAR

(* Стоп гасить усі лампи та скидає таймери. *)
IF stopButton THEN
    active := FALSE;
ELSIF startButton AND NOT prevStart THEN
    active := TRUE;
END_IF;
prevStart := startButton;

lamp1 := active;
delayLamp2(lamp1, 2);
lamp2 := active AND delayLamp2.Q;
delayLamp3(lamp2, 2);
lamp3 := active AND delayLamp3.Q;
