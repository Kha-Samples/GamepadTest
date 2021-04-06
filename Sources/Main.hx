package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.System;
import kha.input.Gamepad;

class Main {
	static var axes:Array<Float> = [];
	static var buttons:Array<Float> = [];

	static function render(frames:Array<Framebuffer>):Void {
		final fb = frames[0];
		final g = fb.g2;
		g.begin(true, Color.fromBytes(0, 95, 106));

		g.color = Color.Black;
		g.drawRect(100 + 0 * 120, 100, 100, 100, 2);
		g.color = Color.Red;
		g.fillRect(100 + 0 * 120 + 50 + axes[0] * 50 - 5, 100 + 50 + axes[1] * 50 - 5, 10, 10);

		g.color = Color.Black;
		g.drawRect(100 + 1 * 120, 100, 100, 100, 2);
		g.color = Color.Red;
		g.fillRect(100 + 1 * 120 + 50 + axes[2] * 50 - 5, 100 + 50 + axes[3] * 50 - 5, 10, 10);

		for (i in 4...axes.length) {
			g.color = Color.Black;
			g.drawRect(100 + 2 * 120 + (i - 4) * 60, 100, 50, 100, 2);
			g.color = Color.Red;
			g.fillRect(100 + 2 * 120 + (i - 4) * 60, 100 + 100 - axes[i] * 100, 50, axes[i] * 100);
		}

		for (i in 0...buttons.length) {
			var x = i * 60;
			var y = 250;
			while (x >= 600) {
				y += 100;
				x -= 600;
				trace(x);
			}

			if (buttons[i] > 0.5) {
				g.color = Color.Red;
				g.fillRect(100 + x, y, 50, 50);
			} else {
				g.color = Color.Black;
				g.drawRect(100 + x, y, 50, 50, 2);
			}
		}

		g.end();
	}

	static function axis(axis:Int, value:Float):Void {
		if (axis >= axes.length) {
			axes.resize(axes.length);
		}
		axes[axis] = value;
	}

	static function button(button:Int, value:Float) {
		if (button >= buttons.length) {
			buttons.resize(buttons.length);
		}
		buttons[button] = value;
	}

	public static function main() {
		System.start({title: "GamepadTest", width: 1024, height: 768}, function(_) {
			Assets.loadEverything(function() {
				Gamepad.get().notify(axis, button);
				System.notifyOnFrames(render);
			});
		});
	}
}
