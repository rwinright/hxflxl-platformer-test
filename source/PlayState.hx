package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxCollision;

class PlayState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var ground:FlxTilemap;
	var background_layer:FlxTilemap;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.Untitled__ogmo, AssetPaths.Level1__json);
		ground = map.loadTilemap("assets/images/micrometroidvania0x72.v2.png", 'ground');
		// ground.allowCollisions = FlxObject.UP;
		background_layer = map.loadTilemap("assets/images/micrometroidvania0x72.v2.png", 'background_layer');
		add(background_layer);
		add(ground);

		map.loadEntities((entity : EntityData) ->
		{
			player = new Player(entity.x, entity.y - 5);
		}, 'Player');
		add(player);

		camera.follow(player, LOCKON, 5);
		camera.zoom = 2;
		camera.setScrollBoundsRect(0, 0, 640, 480);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(player, ground);
		super.update(elapsed);
	}
}
