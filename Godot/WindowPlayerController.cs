using Godot;

namespace Game5;

public class WindowPlayerController : IWindowPlayerController
{
	private const float Speed = 5.0f;
	private const float JumpImpulse = 5.0f;
	private const float MouseSensitivity = 0.01f;
	private const float RollSensitivity = 0.01f;
	private readonly WindowPlayer _windowPlayer;

	public WindowPlayerController(WindowPlayer windowPlayer)
	{
		_windowPlayer = windowPlayer;
	}
	
	public void ProcessMovementControls()
	{
		var velocity = _windowPlayer.Velocity;
		var cameraPivot = _windowPlayer.GetNode<Marker3D>("CameraPivot");

		var inputDir = Input.GetVector("move_left", "move_right", 
			"move_forward", "move_back");
		var yMovement = _windowPlayer.IsMaterialized() ? 0 : 
			Input.GetAxis("move_down", "move_up");
		var direction = (_windowPlayer.Transform.Basis * 
						 new Vector3(inputDir.X, yMovement, inputDir.Y)).Normalized();
		if (direction != Vector3.Zero)
		{
			velocity.X = direction.X * Speed;
			velocity.Z = direction.Z * Speed;
			if (!_windowPlayer.IsMaterialized())
			{
				velocity.Y = direction.Y * Speed;
			}
		}
		else
		{
			velocity.X = Mathf.MoveToward(velocity.X, 0, Speed);
			velocity.Z = Mathf.MoveToward(velocity.Z, 0, Speed);
			if (!_windowPlayer.IsMaterialized())
			{
				velocity.Y = Mathf.MoveToward(velocity.Y, 0, Speed);
			}
		}
		if (_windowPlayer.IsMaterialized() && _windowPlayer.IsOnFloor() && Input.IsActionJustPressed("move_up"))
		{
			velocity.Y = JumpImpulse;
		}

		_windowPlayer.Velocity = velocity;

		var cameraX = Input.GetAxis("look_down", "look_up");
		var cameraY = Input.GetAxis("look_left", "look_right");
		var cameraZ = Input.GetAxis("roll_left", "roll_right");
		_windowPlayer.RotateY(-cameraY * MouseSensitivity);
		cameraPivot.RotateX(cameraX * MouseSensitivity);
		cameraPivot.RotateZ(-cameraZ * RollSensitivity);
	}

	public void ProcessMouseControls(InputEvent @event)
	{
		
		if (((!_windowPlayer.IsMaterialized() && Input.IsActionPressed("holding_right_mouse_button"))
			 || (_windowPlayer.IsMaterialized() && Input.MouseMode == Input.MouseModeEnum.Captured))
			&& @event is InputEventMouseMotion eventMouseMotion)
		{
			_windowPlayer.RotateY(-eventMouseMotion.Relative.X * MouseSensitivity);
			_windowPlayer.GetNode<Marker3D>("CameraPivot")
				.RotateX(-eventMouseMotion.Relative.Y * MouseSensitivity);
		}

		if (_windowPlayer.IsMaterialized())
		{
			if (Input.IsActionPressed("click") && Input.MouseMode == Input.MouseModeEnum.Visible)
			{
				Input.MouseMode = Input.MouseModeEnum.Captured;
			}

			if (Input.IsActionPressed("ui_cancel"))
			{
				Input.MouseMode = Input.MouseModeEnum.Visible;
			}
		}
	}
}
