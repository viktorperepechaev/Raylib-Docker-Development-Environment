#include "raylib.h"

extern "C" {
#include "raylib.h"
}

int main(void) {
  const int screenWidth = 800;
  const int screenHeight = 600;

  InitWindow(screenWidth, screenHeight, "Raylib Keyboard Test");

  Vector2 ballPosition = {(float)screenWidth / 2, (float)screenHeight / 2};
  float moveSpeed = 5.0f;

  SetTargetFPS(60);

  while (!WindowShouldClose()) {
    if (IsKeyDown(KEY_RIGHT)) ballPosition.x += moveSpeed;
    if (IsKeyDown(KEY_LEFT)) ballPosition.x -= moveSpeed;
    if (IsKeyDown(KEY_UP)) ballPosition.y -= moveSpeed;
    if (IsKeyDown(KEY_DOWN)) ballPosition.y += moveSpeed;

    BeginDrawing();

    ClearBackground(DARKGRAY);

    DrawText("Use the arrow keys to move the ball", 10, 10, 20, RAYWHITE);
    DrawText("If the ball moves, it's working! Hurray", 10, 40, 20, LIGHTGRAY);

    DrawCircleV(ballPosition, 50, BLACK);

    EndDrawing();
  }

  CloseWindow();

  return 0;
}
