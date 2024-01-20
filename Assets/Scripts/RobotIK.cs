using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RobotIK : MonoBehaviour
{
    private Transform leftRoboIkTarget;
    private Transform rightRoboIkTarget;

    private void Awake()
    {
        leftRoboIkTarget = GameObject.FindGameObjectWithTag("RoboLeftHandIK").transform;
        rightRoboIkTarget = GameObject.FindGameObjectWithTag("RoboRightHandIK").transform;
    }
    public void SetInteractHandsTo(Transform leftTarget, Transform rightTarget)
    {
        leftRoboIkTarget.SetPositionAndRotation(leftTarget.position, leftTarget.rotation);

        rightRoboIkTarget.SetPositionAndRotation(rightTarget.position, rightTarget.rotation);
    }
}
