import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	var moveDir:Int;

	// var facingRight:Bool = false;

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

		if (moveDir < 0)
			flipX = true;
		else if (moveDir > 0)
			flipX = false;

		velocity.x = moveDir * 100;

		if (FlxG.keys.anyJustPressed([UP, W]) && isTouching(FlxObject.FLOOR))
			velocity.y = -250;
		if (velocity.x == 0 && isTouching(FlxObject.FLOOR))
			animation.play("idle");
		else if (isTouching(FlxObject.FLOOR))
			animation.play("run");
		else if (!isTouching(FlxObject.FLOOR))
			animation.play("jump");
		super.update(elapsed);
	}
}
