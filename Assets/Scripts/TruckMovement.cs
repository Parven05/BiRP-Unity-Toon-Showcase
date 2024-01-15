using System;
using UnityEngine;
using UnityEngine.AI;

public class TruckMovement : MonoBehaviour
{
    //[SerializeField] private List<Transform> labTransformsList;
    private Transform targetLabTransform = null;
    private NavMeshAgent agent;
    private bool isMoving;
    //private bool hasReachedDestination = false;

    public static event Action OnTruckReachedTargetLab;

    private void Awake()
    {
        agent = GetComponent<NavMeshAgent>();
    }
    private void Start()
    {
        MapUI.Instance.OnPlayerSelectedLab += MapUI_Instance_OnPlayerSelectedLab;
        MapUI.Instance.OnPlayerMadeStopRequest += MapUI_Instance_OnPlayerMadeStopRequest;
    }

    private void MapUI_Instance_OnPlayerMadeStopRequest()
    {
        Debug.Log("Based Request Van Stopped");
        targetLabTransform = null;
        agent.SetDestination(agent.transform.position);
        OnTruckReachedTargetLab?.Invoke();
        isMoving = false;  // Set isMoving back to false since the truck has reached the destination
    }

    private void OnDisable()
    {
        MapUI.Instance.OnPlayerSelectedLab -= MapUI_Instance_OnPlayerSelectedLab;
        MapUI.Instance.OnPlayerMadeStopRequest -= MapUI_Instance_OnPlayerMadeStopRequest;
    }

    private void MapUI_Instance_OnPlayerSelectedLab(LabAddress labAddress,Transform interactor)
    {
        this.targetLabTransform = labAddress.labLocatedPosition;
        interactor.transform.SetParent(this.transform);
        interactor.localPosition = Vector3.zero + Vector3.up * 0.9f;
    }

    private void Update()
    {
        if (agent == null)
            Debug.LogError("No Agent Added In Truck");

        if (!isMoving && targetLabTransform != null)
        {
            if (NavMesh.SamplePosition(targetLabTransform.position, out NavMeshHit hit, 1f, NavMesh.AllAreas))
            {
                agent.SetDestination(hit.position);
                isMoving = true;
            }
        }

        //if (!hasReachedDestination && !agent.pathPending && targetLabTransform != null)
        //{
        //    targetLabTransform = null;
        //    Debug.Log("Lab Reached");
        //    OnTruckReachedTargetLab?.Invoke();
        //    hasReachedDestination = true;
        //}

        if (isMoving && !agent.pathPending && targetLabTransform != null && agent.remainingDistance < 0.1f)
        {
            // Assuming 0.1f as a small threshold distance to consider as "reached"
            targetLabTransform = null;
            Debug.Log("Lab Reached");
            OnTruckReachedTargetLab?.Invoke();
            isMoving = false;  // Set isMoving back to false since the truck has reached the destination
        }
    }
}
