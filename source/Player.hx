import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;

class Player extends FlxSprite
{
	var moveDir:Int;
	var bullets:FlxGroup;
	var shootCooldown:Float = 0;

	public function new(x:Float = 0, y:Float = 0, bullets:FlxGroup)
	{
		super(x, y);
		this.bullets = bullets;
		// makeGraphic(16, 16, FlxColor.BLUE);
		var texture = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.player_sprites_0__png, AssetPaths.player_sprites_0__json);
		frames = texture;
		animation.addByPrefix("idle", "player-idle-", 8);
		animation.addByPrefix("run", "player-run-", 8);
		animation.addByPrefix("jump", "player-jump-", 0);
	}

	override function update(elapsed:Float)
	{
		// Update shoot cooldown
		if (shootCooldown > 0)
			shootCooldown -= elapsed;

		velocity.y += 10;
		var left = FlxG.keys.anyPressed([LEFT, A]) ? 1 : 0;
		var right = FlxG.keys.anyPressed([RIGHT, D]) ? 1 : 0;
		moveDir = right - left;

		flipX = moveDir < 0 ? true : moveDir > 0 ? false : flipX;

		velocity.x = moveDir * 100;

		if (FlxG.keys.anyJustPressed([UP, W, SPACE]) && isTouching(FLOOR))
			velocity.y = -250;

		// Shooting with X key
		if (FlxG.keys.anyJustPressed([X]) && shootCooldown <= 0)
		{
			shoot();
			shootCooldown = 0.6; // 600ms cooldown for shotgun
		}

		if (velocity.x == 0 && isTouching(FLOOR))
			animation.play("idle");
		else if (isTouching(FLOOR))
			animation.play("run");
		else if (!isTouching(FLOOR))
			animation.play("jump");
		super.update(elapsed);
	}

	function shoot()
	{
		var bulletDirection = flipX ? -1 : 1;
		var bulletX = flipX ? x - 5 : x + width + 5;
		var baseY = y + height / 2;

		// Fire 5 pellets with spread for shotgun effect
		for (i in 0...5)
		{
			var spreadY = (i - 2) * 30; // Vertical spread: -60, -30, 0, 30, 60
			var bullet = new Bullet(bulletX, baseY, bulletDirection, spreadY);
			bullets.add(bullet);
		}
	}
}
