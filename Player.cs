using System.Linq;
using Godot;

public partial class Player : CharacterBody3D
{
	private const float Speed = 5.0f;
	private const float JumpImpulse = 5.0f;
	private const float MouseSensitivity = 0.01f;
	private const float RollSensitivity = 0.01f;
	private const float RightJoystickSensitivity = 0.1f;
	private const float FallAcceleration = 9.8f;
	private Mesh _mesh;
	private bool _materialized = true;

	public override void _Ready()
	{
		base._Ready();
		// Dematerialize();
	}
	
	public override void _PhysicsProcess(double delta)
	{
		var velocity = Velocity;

		var inputDir = Input.GetVector("move_left", "move_right", 
			"move_forward", "move_back");
		var yMovement = _materialized ? 0 : Input.GetAxis("move_down", "move_up");
		var direction = (Transform.Basis * new Vector3(inputDir.X, yMovement, inputDir.Y)).Normalized();
		if (direction != Vector3.Zero)
		{
			velocity.X = direction.X * Speed;
			velocity.Z = direction.Z * Speed;
			if (!_materialized)
			{
				velocity.Y = direction.Y * Speed;
			}
		}
		else
		{
			velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
			velocity.Z = Mathf.MoveToward(Velocity.Z, 0, Speed);
			if (!_materialized)
			{
				velocity.Y = Mathf.MoveToward(Velocity.Y, 0, Speed);
			}
		}
		if (_materialized && !IsOnFloor())
		{
			velocity.Y -= FallAcceleration * (float)delta;
		}
		if (_materialized && IsOnFloor() && Input.IsActionJustPressed("move_up"))
		{
			velocity.Y = JumpImpulse;
		}

		Velocity = velocity;


		var cameraX = Input.GetAxis("look_down", "look_up");
		var cameraY = Input.GetAxis("look_left", "look_right");
		var cameraZ = Input.GetAxis("roll_left", "roll_right");
		RotateY(-cameraY * RightJoystickSensitivity);
		var cameraPivot = GetNode<Marker3D>("CameraPivot");
		cameraPivot.RotateX(cameraX * RightJoystickSensitivity);
		cameraPivot.RotateZ(-cameraZ * RollSensitivity);
		
		MoveAndSlide();
	}

	public override void _Input(InputEvent @event)
	{
		base._Input(@event);
		if (((!_materialized && Input.IsActionPressed("holding_right_mouse_button"))
			|| (_materialized && Input.MouseMode == Input.MouseModeEnum.Captured))
			&& @event is InputEventMouseMotion eventMouseMotion)
		{
			RotateY(-eventMouseMotion.Relative.X * MouseSensitivity);
			GetNode<Marker3D>("CameraPivot").RotateX(-eventMouseMotion.Relative.Y * MouseSensitivity);
		}

		if (_materialized)
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

	public void Materialize()
	{
		_materialized = true;
		GetNode<CollisionShape3D>("CollisionShape3D").Disabled = false;
		GetNode<MeshInstance3D>("Pivot/MeshInstance3D").Mesh = _mesh;
		Input.MouseMode = Input.MouseModeEnum.Captured;
	}
	
	public void Dematerialize()
	{
		_materialized = false;
		GetNode<CollisionShape3D>("CollisionShape3D").Disabled = true;
		_mesh = GetNode<MeshInstance3D>("Pivot/MeshInstance3D").Mesh;
		GetNode<MeshInstance3D>("Pivot/MeshInstance3D").Mesh = null;
		Input.MouseMode = Input.MouseModeEnum.Visible;
	}
}
