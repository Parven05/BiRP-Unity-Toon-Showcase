using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EquipHandler : MonoBehaviour
{
    [SerializeField] private Transform pistolTransform;
    [SerializeField] private Transform remoteTransform;
    [SerializeField] private Transform hammerTransform;

    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.Alpha1))
        {
            pistolTransform.gameObject.SetActive(!pistolTransform.gameObject.activeSelf);
        }

        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            remoteTransform.gameObject.SetActive(!remoteTransform.gameObject.activeSelf);
        }

        if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            hammerTransform.gameObject.SetActive(!hammerTransform.gameObject.activeSelf);
        }
    }
}
