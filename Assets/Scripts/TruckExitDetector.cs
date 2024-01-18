using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TruckExitDetector : MonoBehaviour
{
    private void OnTriggerExit(Collider other)
    {
        if(other.gameObject.TryGetComponent(out FirstPersonController fpsController))
        {
            if(fpsController.transform.parent == this.transform)
            {
                fpsController.transform.SetParent(null);
            }
        }

        if (other.gameObject.TryGetComponent(out RobotMovement robot))
        {
            if (robot.transform.parent == this.transform)
            {
                robot.transform.SetParent(null);
            }
        }
    }
}
