import smidig.runtime : Engine;
import smidig.util : render_string;

import std.stdio : writefln;

void main() {

	//track allocs yes
	import trackallocs;
	auto tracker = allocsTracker();

	Game game;
	auto result = Game.create(game);

	final switch (result) with (Game.Error) {
		case EngineInitFailed:
			writefln("[Game] Initializing Game Failed: %s", result);
			return;
		case Success:
			break;
	}

	// starts the game loop
	game.run();

} //main

struct Game {

	enum Error {
		EngineInitFailed,
		Success
	} //Error

	Engine engine_;

	static Error create(ref Game game) {

		with (game) {

			auto result = Engine.create(engine_, "Project Blindfire", &update, &draw, &lastDraw);

			final switch (result) with (Engine.Error) {
				case WindowInitFailed, SoundInitFailed, NetInitFailed:
					writefln("[Game] Initializing Engine Failed: %s", result);
					return Error.EngineInitFailed;
				case Success:
					break;
			}

			// set new update rate
			engine_.update_rate = 60;

			return Error.Success;

		}

	} //create

	void update() {

	} //update

	void draw(double last_draw_time) {

		auto s_w = engine_.window_.width;
		auto s_h = engine_.window_.height;

		import smidig.math : Vec2i;
		auto offset = Vec2i(s_w / 2, s_h / 2);
		engine_.atlas.render_string!("offset: (%d, %d)")(engine_.view, offset, offset.x, offset.y);

	} //draw

	void lastDraw(double last_draw_time) {

	} //lastDraw

	void run() {

		engine_.run();

	} //run

} //Game
