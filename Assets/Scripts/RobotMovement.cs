using DG.Tweening;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class RobotMovement : MonoBehaviour
{
    [SerializeField] private ParticleSystem movementDustPartcle;
    private Transform targetObjectTransform = null;
    private NavMeshAgent agent;
    private float timer = 0;
    private float timerMax = 0.5f;
    private FollowObject followObject;
    private RobotCollision robotCollision;
    private Rigidbody rb;
    private bool isCollapsed;

    private void Awake()
    {
        agent = GetComponent<NavMeshAgent>();
        robotCollision = GetComponent<RobotCollision>();
        rb = GetComponent<Rigidbody>();
    }
    private void Start()
    {
        robotCollision.OnRobotGetShot += RobotCollision_OnRobotGetShot;
    }
    private void OnDisable()
    {
        robotCollision.OnRobotGetShot -= RobotCollision_OnRobotGetShot;
    }

    private void RobotCollision_OnRobotGetShot(object sender, EventArgs e)
    {
        //Vector3 targetToMove = GetNearDistance();
        //agent.SetDestination(targetToMove);
        if (!isCollapsed)
        {
            agent.enabled = false;
            rb.isKinematic = false;
            Vector3 direction = transform.position - FindObjectOfType<FirstPersonController>().transform.position;
            rb.AddForce(direction * 0.5f + Vector3.up * 5f,ForceMode.Impulse);
            rb.freezeRotation = false;
            isCollapsed = true;

            Invoke(nameof(Recovery), 2f);
        }
        //SetPlayerAsTargetToRobot();
    }

    private void Recovery()
    {
        rb.isKinematic = true;
        rb.freezeRotation = true;
        transform.DORotate(new Vector3(0, 87.65f, 0), 2f).SetEase(Ease.InBounce).OnComplete(() =>
        {
            agent.enabled = true;
            isCollapsed = false;
        });
    }

    private Vector3 GetNearDistance()
    {
        if(NavMesh.SamplePosition(transform.position,out NavMeshHit hit,10f,NavMesh.AllAreas))
        {
            return hit.position;
        }
        else
        {
            Debug.LogError("No Point Found");
            return Vector3.zero;
        }
        
    }

    private void Update()
    {
        if (agent == null) Debug.LogError("No Agent Added In Robot");
        if (targetObjectTransform == null) return;

        float agentSpeed = agent.velocity.magnitude;
        if (agentSpeed > 0)
        {
            if (!movementDustPartcle.isPlaying)
            {
                movementDustPartcle.Play();
            }
        }
        else
        {
            if (movementDustPartcle.isPlaying)
            {
                movementDustPartcle.Stop();
            }
        }

        if (followObject == FollowObject.Truck && agent.isActiveAndEnabled && !agent.pathPending)
        {
            timer += Time.deltaTime;

            if (timer > timerMax)
            {
                agent.SetDestination(targetObjectTransform.position);
                timer = 0;
            }

            if (agent.remainingDistance < 3f)
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
