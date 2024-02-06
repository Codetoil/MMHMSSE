using Godot;

namespace Game5;

public partial class XrPlayer : Node3D, IPlayer
{
	private const float FallAcceleration = 9.8f;
	private IXrPlayerController _controller;
	private Mesh _mesh;
	private bool _materialized = true;

	public override void _Ready()
	{
		base._Ready();
		// Dematerialize();
		_controller = new XrPlayerController(this);
	}

	public override void _Process(double delta)
	{
		base._Process(delta);
		_controller.ProcessControls();
	}

	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);
		var playerBody = GetNode<CharacterBody3D>("XROrigin3D/PlayerBody");
		var velocity = playerBody.Velocity;
		
		if (_materialized && !playerBody.IsOnFloor())
		{
			velocity.Y -= FallAcceleration * (float)delta;
		}

		playerBody.Velocity = velocity;
		
		playerBody.MoveAndSlide();
	}

	public void Materialize()
	{
		_materialized = true;
		GetNode<CollisionShape3D>("XROrigin3D/PlayerBody/CollisionShape3D").Disabled = false;
		GetNode<MeshInstance3D>("XROrigin3D/PlayerBody/Pivot/MeshInstance3D").Mesh = _mesh;
	}
	
	public void Dematerialize()
	{
		_materialized = false;
		GetNode<CollisionShape3D>("XROrigin3D/PlayerBody/CollisionShape3D").Disabled = true;
		_mesh = GetNode<MeshInstance3D>("XROrigin3D/PlayerBody/Pivot/MeshInstance3D").Mesh;
		GetNode<MeshInstance3D>("XROrigin3D/PlayerBody/Pivot/MeshInstance3D").Mesh = null;
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
