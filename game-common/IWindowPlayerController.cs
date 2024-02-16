using Godot;

namespace Game5;

public interface IWindowPlayerController : IPlayerController
{
    void ProcessMovementControls();
    void ProcessMouseControls(InputEvent @event);
}