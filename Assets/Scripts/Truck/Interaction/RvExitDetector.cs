using UnityEngine;

public class RvExitDetector : MonoBehaviour
{
    private void OnTriggerExit(Collider other)
    {
        if(other.gameObject.TryGetComponent(out FirstPersonController fpsController))
        {
            if(fpsController.transform.parent == this.transform.root)
            {
                fpsController.transform.SetParent(null);
            }
        }

        if (other.gameObject.TryGetComponent(out RobotMovement robot))
        {
            if (robot.transform.parent == this.transform.root)
            {
                robot.transform.SetParent(null);
            }
        }
    }
}
