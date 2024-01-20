using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EquipHandler : MonoBehaviour
{
    [SerializeField] private Transform pistolTransform;

    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.Q))
        {
            pistolTransform.gameObject.SetActive(!pistolTransform.gameObject.activeSelf);
        }
    }
}
