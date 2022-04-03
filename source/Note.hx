package;

import flixel.addons.effects.FlxSkewedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end
import PlayState;

using StringTools;

class Note extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;

	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var modifiedByLua:Bool = false;
	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var noteType:Int = 0;
	public var noteSinger:Int;

	public var isRing:Bool = PlayState.SONG.isRing;

	public var noteScore:Float = 1;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public var rating:String = "shit";

	// 2. added skin note parameter
	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?noteType:Int = 0, ?noteSinger:Int)
		{
			super();
			
			if (prevNote == null)
				prevNote = this;
			this.noteType = noteType;
			this.prevNote = prevNote;
			this.noteSinger = noteSinger;
			isSustainNote = sustainNote;

			if (isRing)
			{
				swagWidth = 140 * 0.8;
			}
 
			x += 50;
			// MAKE SURE ITS DEFINITELY OFF SCREEN?
			y -= 2000;
			this.strumTime = strumTime;
 
			if (this.strumTime < 0 )
				this.strumTime = 0;
 
			this.noteData = noteData;
 
			var daStage:String = PlayState.curStage;
 
			// 1. Self explainatory
			switch (PlayState.SONG.noteStyle)
			{
				case 'pixel':
					loadGraphic(Paths.image('arrows-pixels','exe'), true, 17, 17);
 
					if (noteType == 2)
						{
							animation.add('greenScroll', [22]);
							animation.add('redScroll', [23]);
							animation.add('blueScroll', [21]);
							animation.add('purpleScroll', [20]);
						}
					else if (noteType == 4)
						{
							animation.add('greenScroll', [22]);
							animation.add('redScroll', [23]);
							animation.add('blueScroll', [21]);
							animation.add('purpleScroll', [20]);
						}
					else
						{
							animation.add('greenScroll', [6]);
							animation.add('redScroll', [7]);
							animation.add('blueScroll', [5]);
							animation.add('purpleScroll', [4]);
						}
 
					if (isSustainNote)
					{
						loadGraphic(Paths.image('arrowEnds','exe'), true, 7, 6);
 
						animation.add('purpleholdend', [4]);
						animation.add('greenholdend', [6]);
						animation.add('redholdend', [7]);
						animation.add('blueholdend', [5]);
 
						animation.add('purplehold', [0]);
						animation.add('greenhold', [2]);
						animation.add('redhold', [3]);
						animation.add('bluehold', [1]);
					}

					setGraphicSize(Std.int(width * 6.5));
					updateHitbox();

				case 'majinNOTES':

					frames = Paths.getSparrowAtlas('Majin_Notes', 'exe');
						var fuckingSussy = Paths.getSparrowAtlas('Majin_Notes', 'exe');
						for(amogus in fuckingSussy.frames)
							{
								this.frames.pushFrame(amogus);
							}
 
						switch(noteType)
						{
							case 2:
							{
								frames = Paths.getSparrowAtlas('Majin_Notes', 'exe');
								animation.addByPrefix('greenScroll', 'green0');
								animation.addByPrefix('redScroll', 'red0');
								animation.addByPrefix('blueScroll', 'blue0');
								animation.addByPrefix('purpleScroll', 'purple0');
 
								animation.addByPrefix('purpleholdend', 'pruple end hold'); //PRUPLE Its not typo in the programming, but it is a typo in adobe animate hence why its in da xml like dat
								animation.addByPrefix('greenholdend', 'green hold end');
								animation.addByPrefix('redholdend', 'red hold end');
								animation.addByPrefix('blueholdend', 'blue hold end');
 
								animation.addByPrefix('purplehold', 'purple hold piece');
								animation.addByPrefix('greenhold', 'green hold piece');
								animation.addByPrefix('redhold', 'red hold piece');
								animation.addByPrefix('bluehold', 'blue hold piece');
 
								setGraphicSize(Std.int(width * 0.7));
								
								updateHitbox();
								antialiasing = true;
							}
							default:
							{
								frames = Paths.getSparrowAtlas('Majin_Notes', 'exe');
								animation.addByPrefix('greenScroll', 'green0');
								animation.addByPrefix('redScroll', 'red0');
								animation.addByPrefix('blueScroll', 'blue0');
								animation.addByPrefix('purpleScroll', 'purple0');
	
 
								animation.addByPrefix('purpleholdend', 'pruple end hold'); //PRUPLE Its not typo in the programming, but it is a typo in adobe animate hence why its in da xml like dat
								animation.addByPrefix('greenholdend', 'green hold end');
								animation.addByPrefix('redholdend', 'red hold end');
								animation.addByPrefix('blueholdend', 'blue hold end');
								
 
								animation.addByPrefix('purplehold', 'purple hold piece');
								animation.addByPrefix('greenhold', 'green hold piece');
								animation.addByPrefix('redhold', 'red hold piece');
								animation.addByPrefix('bluehold', 'blue hold piece');
								
 
								setGraphicSize(Std.int(width * 0.7));
								updateHitbox();
								antialiasing = true;
							}
						}


				default:
						frames = Paths.getSparrowAtlas('NOTE_assets');
						var fuckingSussy = Paths.getSparrowAtlas('staticNotes');
						for(amogus in fuckingSussy.frames)
							{
								this.frames.pushFrame(amogus);
							}
 
						switch(noteType)
						{
							case 4:
							{
								loadGraphic(Paths.image('arrows-pixels','exe'), true, 17, 17);
								animation.add('greenGhost', [22]);
								animation.add('redGhost', [23]);
								animation.add('blueGhost', [21]);
								animation.add('purpleGhost', [20]);
	
								setGraphicSize(Std.int(width * 6.5));
								
								updateHitbox();
							}

							case 3:
							{
								frames = Paths.getSparrowAtlas('PhantomNote');
								animation.addByPrefix('greenScroll', 'green withered');
								animation.addByPrefix('redScroll', 'red withered');
								animation.addByPrefix('blueScroll', 'blue withered');
								animation.addByPrefix('purpleScroll', 'purple withered');
	
								setGraphicSize(Std.int(width * 0.7));
									
								updateHitbox();
								antialiasing = true;
							}

							case 2:
							{
								frames = Paths.getSparrowAtlas('staticNotes');
								animation.addByPrefix('greenScroll', 'green static');
								animation.addByPrefix('redScroll', 'red static');
								animation.addByPrefix('blueScroll', 'blue static');
								animation.addByPrefix('purpleScroll', 'purple static');
 
								animation.addByPrefix('purpleholdend', 'pruple end hold');
								animation.addByPrefix('greenholdend', 'green hold end');
								animation.addByPrefix('redholdend', 'red hold end');
								animation.addByPrefix('blueholdend', 'blue hold end');
 
								animation.addByPrefix('purplehold', 'purple hold piece');
								animation.addByPrefix('greenhold', 'green hold piece');
								animation.addByPrefix('redhold', 'red hold piece');
								animation.addByPrefix('bluehold', 'blue hold piece');
 
								setGraphicSize(Std.int(width * 0.7));
								
								updateHitbox();
								antialiasing = true;
							}
							default:
							{
								frames = Paths.getSparrowAtlas('NOTE_assets');
								animation.addByPrefix('greenScroll', 'green0');
								animation.addByPrefix('redScroll', 'red0');
								animation.addByPrefix('blueScroll', 'blue0');
								animation.addByPrefix('purpleScroll', 'purple0');
								if (isRing) animation.addByPrefix('goldScroll', 'gold0');
 
								animation.addByPrefix('purpleholdend', 'pruple end hold');
								animation.addByPrefix('greenholdend', 'green hold end');
								animation.addByPrefix('redholdend', 'red hold end');
								animation.addByPrefix('blueholdend', 'blue hold end');
								if (isRing) animation.addByPrefix('goldholdend', 'red hold end');
 
								animation.addByPrefix('purplehold', 'purple hold piece');
								animation.addByPrefix('greenhold', 'green hold piece');
								animation.addByPrefix('redhold', 'red hold piece');
								animation.addByPrefix('bluehold', 'blue hold piece');
								if (isRing) animation.addByPrefix('goldhold', 'red hold piece');
 
								setGraphicSize(Std.int(width * 0.7));
								updateHitbox();
								antialiasing = true;
							}
						}
			}

		switch (noteData)
		{
			case 0:
				x += swagWidth * 0;
				animation.play('purpleScroll');
			case 1:
				x += swagWidth * 1;
				animation.play('blueScroll');
			 case 2:
				if (isRing)
				{
					x += swagWidth * 2;
					animation.play('goldScroll');
				}
				else
				{
					x += swagWidth * 2;
					animation.play('greenScroll');
				}
			case 3:
				if (isRing)
				{
					x += swagWidth * 3;
					animation.play('greenScroll');
				}
				else
				{
					x += swagWidth * 3;
					animation.play('redScroll');
				}
			case 4:
				if(isRing)
				{
					x += swagWidth * 4;
					animation.play('redScroll');
				}
				
		}

		// trace(prevNote);

		// we make sure its downscroll and its a SUSTAIN NOTE (aka a trail, not a note)
		// and flip it so it doesn't look weird.
		// THIS DOESN'T FUCKING FLIP THE NOTE, CONTRIBUTERS DON'T JUST COMMENT THIS OUT JESUS
		if (FlxG.save.data.downscroll && sustainNote) 
			flipY = true;

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;


			if (!isRing)
			{
				switch (noteData)
				{
					case 3:
						animation.play('redholdend');	
					case 2:
						animation.play('greenholdend');
					case 1:
						animation.play('blueholdend');
					case 0:
						animation.play('purpleholdend');
				}
			}
			else
			{
				switch (noteData)
				{
					case 3:
						animation.play('greenholdend');
					case 4:
						animation.play('redholdend');
					case 2:
						animation.play('goldholdend');
					case 1:
						animation.play('blueholdend');
					case 0:
						animation.play('purpleholdend');
				}
			}	

			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;

			if (prevNote.isSustainNote)
			{
				if (!isRing)
				{
					switch (prevNote.noteData)
					{
						case 0:
							prevNote.animation.play('purplehold');
						case 1:
							prevNote.animation.play('bluehold');
						case 3:
							prevNote.animation.play('redhold');
						case 2:
							prevNote.animation.play('greenhold');
					}
				}
				else
				{
					switch (prevNote.noteData)
					{
						case 0:
							prevNote.animation.play('purplehold');
						case 1:
							prevNote.animation.play('bluehold');
						case 3:
							prevNote.animation.play('greenhold');
						case 2:
							prevNote.animation.play('goldhold');
						case 4:
							prevNote.animation.play('redhold');
					}
				}


				if(FlxG.save.data.scrollSpeed != 1)
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * FlxG.save.data.scrollSpeed;
				else
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (mustPress)
			{
				// The * 0.5 is so that it's easier to hit them too late, instead of too early
				if (noteType != 2)
				{
					if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
						&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
						canBeHit = true;
					else
						canBeHit = false;
				}
				else
				{
						if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.6)
							&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.4)) // also they're almost impossible to hit late!
							canBeHit = true;
						else
							canBeHit = false;
				}
				if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
					tooLate = true;
			}
			else
			{
				canBeHit = false;
	
				if (strumTime <= Conductor.songPosition)
					wasGoodHit = true;
			}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}							
}