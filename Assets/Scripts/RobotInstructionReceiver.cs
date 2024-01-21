using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RobotInstructionReceiver : MonoBehaviour
{
    private RobotMovement robotMovement;

    private void Awake()
    {
        robotMovement = GetComponent<RobotMovement>();
    }

    private void Start()
    {
        RemoteButton.OnAnyRemoteButtonClicked += RemoteButton_OnAnyRemoteButtonClicked;
        RemoteButton.OnAnyRemoteButtonClickedWithError += RemoteButton_OnAnyRemoteButtonClickedWithError;

    }
    private void OnDisable()
    {
        RemoteButton.OnAnyRemoteButtonClicked -= RemoteButton_OnAnyRemoteButtonClicked;
        RemoteButton.OnAnyRemoteButtonClickedWithError -= RemoteButton_OnAnyRemoteButtonClickedWithError;
    }

    private void RemoteButton_OnAnyRemoteButtonClickedWithError(string buttonName)
    {
        switch (buttonName)
        {
            case "Follow Me":
                FollowMe(false);
                break;
            case "Get In Truck":
                GetInTruck(false);
                break;
            case "Defence Truck":
                DefenceTruck(false);
                break;
            case "Stop Move":
                StopMove(false);
                break;
        }
    }

    private void RemoteButton_OnAnyRemoteButtonClicked(string buttonName)
    {
        switch (buttonName)
        {
            case "Follow Me":
                FollowMe(true);
                break;
            case "Get In Truck":
                GetInTruck(true);
                break;
            case "Defence Truck":
                DefenceTruck(true);
                break;
            case "Stop Move":
                StopMove(true);
                break;
        }
    }

    private void DefenceTruck(bool inRadiusStatus)
    {
        if (inRadiusStatus) robotMovement.SetTargetTruckGunPosition();
        else Debug.Log("OOps Robot Cant Perfom DEFENCE TRUCK Not In Range");
    }
    private void FollowMe(bool inRadiusStatus)
    {
        if (inRadiusStatus) robotMovement.SetPlayerAsTargetToRobot();
        else Debug.Log("OOps Robot Cant Perfom FOLLOW ME Not In Range");
    }
    private void GetInTruck(bool inRadiusStatus)
    {
        if (inRadiusStatus) robotMovement.SetTruckAsTargetToRobot();
        else Debug.Log("OOps Robot Cant Perfom GET IN TRUCK Not In Range");
    }
    private void StopMove(bool inRadiusStatus)
    {
        if (inRadiusStatus)
        {
            Debug.Log("Ok Im Stay Here ");
            robotMovement.SetTargetNull();
        }
        else
        {
            Debug.Log("OOps Robot Cant Perfom STOP MOVE Not In Range");
        }
    }

}
