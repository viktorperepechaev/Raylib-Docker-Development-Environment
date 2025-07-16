#!/bin/sh

trap "echo 'Shutting down...'; kill 0; exit" INT TERM

start_application() {
  echo 'Compiling application...'
  cd /app/src
  g++ main.cpp -o main -lraylib -lX11
  
  if pkill -f "xpra start"; then
    echo 'Stopping previous XPRA instance...'
    sleep 0.3
  fi
  
  echo 'Launching application via XPRA...'

  xpra start --bind-tcp=0.0.0.0:$XPRA_PORT \
             --start-child="/app/src/main" \
             --exit-with-children \
             --daemon=no \
             --no-mdns \
             --log-file=/dev/stdout &
}

start_application

while true; do
  echo "Watching for changes in *.cpp and *.h files in $WATCH_DIR..."
  
  inotifywait -q -e modify,create,delete -r $WATCH_DIR --include '\.(cpp|h)$'
  start_application
done
