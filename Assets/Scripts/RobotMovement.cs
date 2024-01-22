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
    private RobotIK robotIK;
    private Rigidbody rb;
    private bool isCollapsed;

    private void Awake()
    {
        agent = GetComponent<NavMeshAgent>();
        robotCollision = GetComponent<RobotCollision>();
        robotIK = GetComponent<RobotIK>();
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
        transform.DORotate(new Vector3(0, 0, 0), 2f).SetEase(Ease.InBounce).OnComplete(() =>
        {
            agent.enabled = true;
            isCollapsed = false;
            rb.isKinematic = true;
            rb.freezeRotation = true;
        });
    }

    private Vector3 GetNearPoint(Transform orginPoint,float radius)
    {
        if(NavMesh.SamplePosition(orginPoint.position,out NavMeshHit hit,radius,NavMesh.AllAreas))
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

        float agentSpeed = agent.velocity.magnitude;
        if (agentSpeed > 0)
        {
            if (!movementDustPartcle.gameObject.activeSelf)
            {
                movementDustPartcle.gameObject.SetActive(true);
            }
        }
        else
        {
            if (movementDustPartcle.gameObject.activeSelf)
            {
                movementDustPartcle.gameObject.SetActive(false);
            }
        }

        if (targetObjectTransform == null) return;

        

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

        if (followObject == FollowObject.TruckGun && agent.isActiveAndEnabled && !agent.pathPending)
        {
            timer += Time.deltaTime;

            if (timer > timerMax)
            {
                agent.SetDestination(targetObjectTransform.position);
                timer = 0;
            }
            //Debug.Log($"Player Reached Gun to Robo Dis {agent.remainingDistance}");
            if (agent.remainingDistance < 3.8f)
            {
                Debug.Log("Player Reached Gun");
                robotIK.SetInteractHandsTo(MachineGun.Instance.GetLeftHandIkPoint(),MachineGun.Instance.GetRightHandIkPoint());
                transform.localEulerAngles = new Vector3(0,223f,0);
            }
        }
    }


    private void SetReachedTargetAction(TruckInteraction truckInteraction)
    {
        if(truckInteraction != null)
        {
            agent.enabled = false;
            transform.SetParent(truckInteraction.GetTruckStandPos());
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

    public void SetTargetTruckGunPosition()
    {
        targetObjectTransform = FindObjectOfType<TruckInteraction>().transform;
        agent.SetDestination(targetObjectTransform.position);
        followObject = FollowObject.TruckGun;
    }
}

public enum FollowObject { 
    Player,Truck,TruckGun,Null
}
