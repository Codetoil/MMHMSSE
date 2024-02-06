namespace Game5;

using Godot;

public partial class XrPlayer : Node3D, IMaterializeable, IPlayer
{
	private const float FallAcceleration = 9.8f;
	public XrPlayerController Controller;
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
		Controller.ProcessControls();
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
}
