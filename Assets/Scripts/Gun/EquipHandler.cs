using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EquipHandler : MonoBehaviour
{
    [SerializeField] private Transform pistolTransform;
    [SerializeField] private Transform remoteTransform;
    [SerializeField] private Transform hammerTransform;

    private void Start()
    {
        pistolTransform.gameObject.SetActive(false);
        remoteTransform.gameObject.SetActive(false);
        hammerTransform.gameObject.SetActive(false);
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

        if (Input.GetKeyDown(KeyCode.H))
        {
            hammerTransform.gameObject.SetActive(!hammerTransform.gameObject.activeSelf);
        }
    }
}
