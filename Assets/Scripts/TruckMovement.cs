using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class TruckMovement : MonoBehaviour
{
    [SerializeField] private List<Transform> labTransformsList;
    private NavMeshAgent agent;
    private bool isMoving;

    private void Awake()
    {
        agent = GetComponent<NavMeshAgent>();
    }
    private void Update()
    {
        if(agent != null && !isMoving)
        {
            if(NavMesh.SamplePosition(GetRandomLabPosition(), out NavMeshHit hit,1f,NavMesh.AllAreas))
            {
                agent.SetDestination(hit.position);
                isMoving = true;
            }
        }
    }

    private Vector3 GetRandomLabPosition()
    {
        Transform selectedLabTr = labTransformsList[UnityEngine.Random.Range(0, labTransformsList.Count)];
        return selectedLabTr.position;    
    }
}
