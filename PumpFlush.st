PROGRAM PumpFlush
VAR
    startButton : BOOL := FALSE;
    stopButton  : BOOL := FALSE;
    prevStart   : BOOL := FALSE;
    phase       : INT := 0;
    pumpRunning : BOOL := FALSE;
    runTimer    : TON1s;
    pauseTimer  : TON1s;
END_VAR

(* Фаза 0 — зупинка, 1 — промивання, 2 — пауза. *)
IF stopButton THEN
    phase := 0;
ELSIF startButton AND NOT prevStart AND (phase = 0) THEN
    phase := 1;
END_IF;
prevStart := startButton;

runTimer(phase = 1, 5);
IF (phase = 1) AND runTimer.Q THEN
    phase := 2;
END_IF;

pauseTimer(phase = 2, 3);
IF (phase = 2) AND pauseTimer.Q THEN
    phase := 1;
END_IF;

pumpRunning := phase = 1;
