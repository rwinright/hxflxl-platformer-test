import flixel.FlxSprite;
import flixel.util.FlxColor;

class Bullet extends FlxSprite
{
	var speed:Float = 250;
	var direction:Int;
	var maxDistance:Float = 80; // Pellets travel only 80 pixels
	var startX:Float;

	public function new(x:Float = 0, y:Float = 0, direction:Int = 1, velocityY:Float = 0)
	{
		super(x, y);
		this.direction = direction;
		this.startX = x; // Remember starting position

		// Create a smaller pellet for shotgun
		makeGraphic(3, 3, FlxColor.ORANGE);

		// Re-enable physics for bullets
		solid = true;

		// Ensure bullets can collide properly
		width = 3;
		height = 3;

		// Set up collision callback to destroy bullet immediately on impact
		allowCollisions = ANY;

		// Set velocity based on direction with some Y velocity for spread
		velocity.x = direction * speed;
		velocity.y = velocityY;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// Calculate distance traveled from starting position
		var distanceTraveled = Math.abs(x - startX);

		// Remove bullet if it has traveled too far or goes off screen
		if (distanceTraveled >= maxDistance || x < -10 || x > 1000)
		{
			kill();
		}
	}
}
