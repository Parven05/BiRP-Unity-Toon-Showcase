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
    }
}
