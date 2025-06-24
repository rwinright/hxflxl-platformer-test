package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var ground:FlxTilemap;
	var background_layer:FlxTilemap;
	var enemies:FlxGroup;
	var bullets:FlxGroup;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.Untitled__ogmo, AssetPaths.Level1__json);
		ground = map.loadTilemap("assets/images/micrometroidvania0x72.v2.png", 'ground');
		background_layer = map.loadTilemap("assets/images/micrometroidvania0x72.v2.png", 'background_layer');
		add(background_layer);
		add(ground);

		// Create bullets group
		bullets = new FlxGroup();
		add(bullets);

		map.loadEntities((entity:EntityData) ->
		{
			player = new Player(entity.x, entity.y - 5, bullets);
		}, 'Player');
		add(player);

		// Create enemies group
		enemies = new FlxGroup();

		// Add some enemies at various positions
		var enemy1 = new Enemy(200, 300, player);
		var enemy2 = new Enemy(400, 200, player);
		var enemy3 = new Enemy(100, 150, player);

		enemies.add(enemy1);
		enemies.add(enemy2);
		enemies.add(enemy3);
		add(enemies);

		camera.follow(player, LOCKON, 0.1);
		camera.zoom = 2;
		camera.setScrollBoundsRect(0, 0, 640, 480);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		inline FlxG.collide(player, ground);
		inline FlxG.collide(enemies, ground);

		// Use collision callback to destroy bullets immediately on wall impact
		FlxG.collide(bullets, ground, onBulletHitWall);

		// Check bullet-enemy collisions
		FlxG.overlap(bullets, enemies, onBulletHitEnemy);

		super.update(elapsed);
	}

	function onBulletHitWall(bullet:FlxObject, wall:FlxObject)
	{
		bullet.kill();
	}

	function onBulletHitEnemy(bullet:FlxObject, enemy:FlxObject)
	{
		bullet.kill();
		enemy.kill();
	}
}
