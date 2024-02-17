using Godot;

namespace Game5;

public class XrPlayerController : IXrPlayerController
{
	private const float Speed = 5.0f;
	private const float JumpImpulse = 5.0f;
	private readonly XrPlayer _player;

	public XrPlayerController(XrPlayer player)
	{
		_player = player;
	}
	
	public void ProcessControls()
	{
		var playerBody = _player.GetNode<CharacterBody3D>("XROrigin3D/PlayerBody");
		var xrCameraPivot = _player.GetNode<XRCamera3D>("XROrigin3D/XRCamera3D");

		var xMovement = Input.GetJoyAxis(0, JoyAxis.LeftX);
		var yMovement = _player.IsMaterialized() ? 0 : 
			Input.GetAxis("move_down", "move_up");
		var zMovement = Input.GetJoyAxis(0, JoyAxis.LeftY);
		var direction = (xrCameraPivot.Transform.Basis * 
						 new Vector3(xMovement, yMovement, zMovement)).Normalized();
		var velocity = playerBody.Velocity;
		if (direction != Vector3.Zero)
		{
			velocity.X = direction.X * Speed;
			velocity.Z = direction.Z * Speed;
			if (!_player.IsMaterialized())
			{
				velocity.Y = direction.Y * Speed;
			}
		}
		else
		{
			velocity.X = Mathf.MoveToward(velocity.X, 0, Speed);
			velocity.Z = Mathf.MoveToward(velocity.Z, 0, Speed);
			if (!_player.IsMaterialized())
			{
				velocity.Y = Mathf.MoveToward(velocity.Y, 0, Speed);
			}
		}
		if (_player.IsMaterialized() && playerBody.IsOnFloor() && Input.IsActionJustPressed("move_up"))
		{
			velocity.Y = JumpImpulse;
		}
		playerBody.Velocity = velocity;
	}
}
