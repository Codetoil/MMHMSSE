namespace Game5;

using Godot;

public partial class Main : Node
{
	private XRInterface _xrInterface;
	private IPlayer _player;
	
	public override void _Ready()
	{
		_xrInterface = XRServer.FindInterface("OpenXR");
		if(_xrInterface != null && _xrInterface.IsInitialized())
		{
			GD.Print("OpenXR initialized successfully");

			// Turn off v-sync!
			DisplayServer.WindowSetVsyncMode(DisplayServer.VSyncMode.Disabled);

			// Change our main viewport to output to the HMD
			GetViewport().UseXR = true;
			
			_player = CreateXrPlayer();
		}
		else
		{
			GD.Print("OpenXR not initialized, please check if your headset is connected");

			_player = CreatePlayer();
		}
	}

	public override void _Process(double delta)
	{
	}
	
	public XrPlayer CreateXrPlayer()
	{
		var playerScene = (PackedScene) ResourceLoader.Load("res://XrPlayer.tscn");
		var xrPlayer = (XrPlayer) playerScene.Instantiate();
		xrPlayer.Position = new Vector3(0, 6, 0);
		xrPlayer.Controller = new XrPlayerController(xrPlayer);
		AddChild(xrPlayer);
		return xrPlayer;
	}
	
	public Player CreatePlayer()
	{
		var playerScene = (PackedScene) ResourceLoader.Load("res://Player.tscn");
		var player = (Player) playerScene.Instantiate();
		player.Position = new Vector3(0, 6, 0);
		player.Controller = new PlayerController(player);
		AddChild(player);
		return player;
	}
}
