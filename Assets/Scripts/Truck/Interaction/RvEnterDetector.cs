using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RvEnterDetector : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.TryGetComponent(out FirstPersonController fpsController))
        {
            if (fpsController.transform.parent != transform.root)
            {
                fpsController.transform.SetParent(transform.root);
            }
        }

        if (other.gameObject.TryGetComponent(out RobotMovement robot))
        {
            if (robot.transform.parent != transform.root)
            {
                robot.transform.SetParent(transform.root);
            }
        }
    }
}
