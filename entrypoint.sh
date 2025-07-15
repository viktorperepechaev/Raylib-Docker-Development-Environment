#!/bin/sh

trap "echo 'Shutting down...'; kill 0; exit" INT TERM

start_application() {
  echo 'Compiling application...'
  cd /app/src
  g++ main.cpp -o main -lraylib -lGL -lm -lpthread -ldl -lrt -lX11
  
  echo 'Stopping previous XPRA instance...'
  pkill -f "xpra start" || true
  sleep 0.5
  
  echo 'Launching application via XPRA...'

  xpra start --bind-tcp=0.0.0.0:$XPRA_PORT --start-child="/app/src/main" --exit-with-children --daemon=no --no-mdns --keyboard-layout=us --dpi=96 --log-file=/dev/stdout &
}

start_application

while true; do
  echo "Watching for changes in *.cpp and *.h files in $WATCH_DIR..."
  
  inotifywait -q -e modify,create,delete -r $WATCH_DIR --include '\.(cpp|h)$'
  start_application
done
