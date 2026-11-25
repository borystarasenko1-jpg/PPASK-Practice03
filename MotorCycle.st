PROGRAM MotorCycle
VAR
    startButton   : BOOL := FALSE;
    stopButton    : BOOL := FALSE;
    prevStart     : BOOL := FALSE;
    processActive : BOOL := FALSE;
    motorRunning  : BOOL := FALSE;
    signalLamp    : BOOL := FALSE;
    startDelay    : TON1s;
    runTimer      : TON1s;
    blinkTimer    : TON100ms;
END_VAR

(* Стоп має пріоритет. Пуск спрацьовує лише за переднім фронтом. *)
IF stopButton THEN
    processActive := FALSE;
ELSIF startButton AND NOT prevStart THEN
    processActive := TRUE;
END_IF;
prevStart := startButton;

startDelay(processActive, 3);
runTimer(processActive AND startDelay.Q, 10);
IF runTimer.Q THEN
    processActive := FALSE;
END_IF;

motorRunning := processActive AND startDelay.Q;

(* 5 одиниць по 100 мс дають 0,5 с між перемиканнями. *)
blinkTimer(processActive AND NOT blinkTimer.Q, 5);
IF NOT processActive THEN
    signalLamp := FALSE;
ELSIF blinkTimer.Q THEN
    signalLamp := NOT signalLamp;
END_IF;
