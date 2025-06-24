import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class Enemy extends FlxSprite
{
	var player:Player;
	var speed:Float = 50;
	var chaseDistance:Float = 150;
	var attackDistance:Float = 30;

	public function new(x:Float = 0, y:Float = 0, player:Player)
	{
		super(x, y);
		this.player = player;

		// Create a simple red square for the enemy
		makeGraphic(16, 16, FlxColor.RED);

		// Set physics properties
		acceleration.y = 400; // Gravity
		maxVelocity.set(speed, 400);
		drag.x = 200;
	}

	override function update(elapsed:Float)
	{
		// Calculate distance to player
		var distanceToPlayer = FlxMath.distanceBetween(this, player);

		// Only chase if player is within chase distance
		if (distanceToPlayer <= chaseDistance)
		{
			// Calculate direction to player
			var directionX = player.x > x ? 1 : -1;

			// If player is close enough for attack, slow down
			if (distanceToPlayer <= attackDistance)
			{
				velocity.x = directionX * speed * 0.3;
			}
			else
			{
				// Chase the player
				velocity.x = directionX * speed;
			}

			// Simple jumping AI - jump if player is above and we're on the ground
			if (player.y < y - 20 && isTouching(FLOOR) && Math.abs(player.x - x) < 50)
			{
				velocity.y = -200;
			}
		}
		else
		{
			// Stop moving if player is too far away
			velocity.x = 0;
		}

		super.update(elapsed);
	}
}
