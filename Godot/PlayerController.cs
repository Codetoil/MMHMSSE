using Godot;

namespace Game5;

public class PlayerController
{
    private const float Speed = 5.0f;
    private const float JumpImpulse = 5.0f;
    private const float MouseSensitivity = 0.01f;
    private const float RollSensitivity = 0.01f;
    private readonly Player _player;

    public PlayerController(Player player)
    {
        _player = player;
    }
    
    public void ProcessMovementControls()
    {
        var velocity = _player.Velocity;
        var cameraPivot = _player.GetNode<Marker3D>("CameraPivot");

        var inputDir = Input.GetVector("move_left", "move_right", 
            "move_forward", "move_back");
        var yMovement = _player.IsMaterialized() ? 0 : Input.GetAxis("move_down", "move_up");
        var direction = (_player.Transform.Basis * new Vector3(inputDir.X, yMovement, inputDir.Y)).Normalized();
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
        if (_player.IsMaterialized() && _player.IsOnFloor() && Input.IsActionJustPressed("move_up"))
        {
            velocity.Y = JumpImpulse;
        }

        _player.Velocity = velocity;

        var cameraX = Input.GetAxis("look_down", "look_up");
        var cameraY = Input.GetAxis("look_left", "look_right");
        var cameraZ = Input.GetAxis("roll_left", "roll_right");
        _player.RotateY(-cameraY * MouseSensitivity);
        cameraPivot.RotateX(cameraX * MouseSensitivity);
        cameraPivot.RotateZ(-cameraZ * RollSensitivity);
    }

    public void ProcessMouseControls(InputEvent @event)
    {
        
        if (((!_player.IsMaterialized() && Input.IsActionPressed("holding_right_mouse_button"))
             || (_player.IsMaterialized() && Input.MouseMode == Input.MouseModeEnum.Captured))
            && @event is InputEventMouseMotion eventMouseMotion)
        {
            _player.RotateY(-eventMouseMotion.Relative.X * MouseSensitivity);
            _player.GetNode<Marker3D>("CameraPivot")
                .RotateX(-eventMouseMotion.Relative.Y * MouseSensitivity);
        }

        if (_player.IsMaterialized())
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