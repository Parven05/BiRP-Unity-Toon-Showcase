using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EquipHandler : MonoBehaviour
{
    [SerializeField] private Transform pistolTransform;
    [SerializeField] private Transform remoteTransform;

    private void Start()
    {
        pistolTransform.gameObject.SetActive(false);
        remoteTransform.gameObject.SetActive(false);
    }
    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.Q))
        {
            pistolTransform.gameObject.SetActive(!pistolTransform.gameObject.activeSelf);
        }

        if (Input.GetKeyDown(KeyCode.T))
        {
            remoteTransform.gameObject.SetActive(!remoteTransform.gameObject.activeSelf);
        }
    }
}
