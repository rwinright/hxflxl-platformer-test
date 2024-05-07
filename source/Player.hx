import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class Player extends FlxSprite
{
	var moveDir:Int;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		// makeGraphic(16, 16, FlxColor.BLUE);
		var texture = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.player_sprites_0__png, AssetPaths.player_sprites_0__json);
		frames = texture;
		animation.addByPrefix("idle", "player-idle-", 8);
		animation.addByPrefix("run", "player-run-", 8);
		animation.addByPrefix("jump", "player-jump-", 0);
	}

	override function update(elapsed:Float)
	{
		velocity.y += 10;
		var left = FlxG.keys.anyPressed([LEFT, A]) ? 1 : 0;
		var right = FlxG.keys.anyPressed([RIGHT, D]) ? 1 : 0;
		moveDir = right - left;

		flipX = moveDir < 0 ? true : moveDir > 0 ? false : flipX;

		velocity.x = moveDir * 100;

		if (FlxG.keys.anyJustPressed([UP, W, SPACE]) && isTouching(FLOOR))
			velocity.y = -250;
		if (velocity.x == 0 && isTouching(FLOOR))
			animation.play("idle");
		else if (isTouching(FLOOR))
			animation.play("run");
		else if (!isTouching(FLOOR))
			animation.play("jump");
		super.update(elapsed);
	}
}
