using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RobotRecharger : MonoBehaviour
{
    [SerializeField] private float rechargeSpeed = 0.5f;
    [SerializeField] private Transform rechargeStandPosTransform;
    public Transform GetRechargeStandTransform()
    {
        return rechargeStandPosTransform;
    }

    private void OnTriggerStay(Collider other)
    {
        if(other.TryGetComponent(out RobotHealth robotHealth))
        {
            robotHealth.AddHealth(Time.deltaTime * rechargeSpeed);
        }
    }
}
