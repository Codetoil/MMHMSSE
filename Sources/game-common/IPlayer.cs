namespace Game5;

public interface IPlayer : IMaterializeable
{
    IPlayerController GetController();
}