using Godot;

namespace Game5;

public partial class WindowPlayer : CharacterBody3D, IPlayer
{
	private const float FallAcceleration = 9.8f;
	private IWindowPlayerController _controller;
	private Mesh _mesh;
	private bool _materialized = true;

	public override void _Ready()
	{
		base._Ready();
		// Dematerialize();
		_controller = new WindowPlayerController(this);
	}

	public override void _Process(double delta)
	{
		base._Process(delta);
		_controller.ProcessMovementControls();
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
		_controller.ProcessMouseControls(@event);
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

	public IPlayerController GetController()
	{
		return _controller;
	}
}
