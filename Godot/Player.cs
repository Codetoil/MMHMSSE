namespace Game5;

using Godot;

public partial class Player : CharacterBody3D, IMaterializeable, IPlayer
{
	private const float FallAcceleration = 9.8f;
	public PlayerController Controller;
	private Mesh _mesh;
	private bool _materialized = true;

	/*
	public override void _Ready()
	{
		base._Ready();
		Dematerialize();
	}
	*/

	public override void _Process(double delta)
	{
		base._Process(delta);
		Controller.ProcessMovementControls();
	}

	public override void _PhysicsProcess(double delta)
	{
		var velocity = Velocity;
		
		if (_materialized && !IsOnFloor())
		{
			velocity.Y -= FallAcceleration * (float)delta;
		}

		Velocity = velocity;
		
		MoveAndSlide();
	}

	public override void _Input(InputEvent @event)
	{
		base._Input(@event);
		Controller.ProcessMouseControls(@event);
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

	public bool IsMaterialized()
	{
		return _materialized;
	}
}
