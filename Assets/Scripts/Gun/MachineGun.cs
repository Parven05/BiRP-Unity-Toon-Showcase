using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MachineGun : MonoBehaviour
{
    public static MachineGun Instance { get; private set; }


    [SerializeField] private Transform leftHandIkPoint, rightHandIkPoint, operatorStandPoint;

    private void Awake()
    {
        Instance = this;
    }


    public Transform GetLeftHandIkPoint() => leftHandIkPoint; 
    public Transform GetRightHandIkPoint() => rightHandIkPoint;
    public Transform GetOperatorStandPoint() => operatorStandPoint;
}
