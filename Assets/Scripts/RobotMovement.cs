using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class RobotMovement : MonoBehaviour
{
    private Transform targetObjectTransform = null;
    private NavMeshAgent agent;
    private float timer = 0;
    private float timerMax = 1;
    private FollowObject followObject;

    private void Awake()
    {
        agent = GetComponent<NavMeshAgent>();
    }

    private void Update()
    {
        if (agent == null) Debug.LogError("No Agent Added In Robot");
        if (targetObjectTransform == null) return;

       

        if (followObject == FollowObject.Truck && agent.isActiveAndEnabled && !agent.pathPending)
        {
            timer += Time.deltaTime;

            if (timer > timerMax)
            {
                agent.SetDestination(targetObjectTransform.position);
                timer = 0;
            }

            if (agent.remainingDistance < 2f)
            {
                Debug.Log("target Object Reached");
                SetReachedTargetAction(targetObjectTransform.GetComponent<TruckInteraction>());
                targetObjectTransform = null;
            }
        }

        if(followObject == FollowObject.Player && agent.isActiveAndEnabled && !agent.pathPending)
        {
            timer += Time.deltaTime;

            if (timer > timerMax)
            {
                agent.SetDestination(targetObjectTransform.position);
                timer = 0;
            }

            if (agent.remainingDistance < 0.1f)
            {
                Debug.Log("Player Reached");
            }
        }
    }


    private void SetReachedTargetAction(TruckInteraction truckInteraction)
    {
        if(truckInteraction != null)
        {
            agent.enabled = false;
            transform.SetParent(truckInteraction.GetTruckTopStandPos());
            transform.localPosition = Vector3.zero;
        }
    }

    [ContextMenu("Test Follow Player")]
    public void SetPlayerAsTargetToRobot()
    {
        targetObjectTransform = FindObjectOfType<FirstPersonController>().transform;
        agent.enabled = true;
        agent.SetDestination(targetObjectTransform.position);
        followObject = FollowObject.Player;
    }

    [ContextMenu("Test Follow Truck")]
    public void SetTruckAsTargetToRobot()
    {
        targetObjectTransform = FindObjectOfType<TruckInteraction>().transform;
        agent.SetDestination(targetObjectTransform.position);
        followObject = FollowObject.Truck;
    }

    [ContextMenu("Test Follow Null")]
    public void SetTargetNull()
    {
        targetObjectTransform = transform;
        agent.SetDestination(targetObjectTransform.position);
        followObject = FollowObject.Null;
    }
}

public enum FollowObject { 
    Player,Truck,Null
}
