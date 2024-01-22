using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectionSensor : MonoBehaviour
{
    [SerializeField] private int detectedEntityAmount;
    [SerializeField] private float detectionRadius = 20f;
    [SerializeField] private LayerMask entityLayerMask;
    private Collider[] detectedColliderArray = new Collider[30];

    private Vector3 entityLocation;
    private bool canReturnPlayer = false;

    [SerializeField] private Light indigator;
    private void FixedUpdate()
    {
        if (canReturnPlayer) return;

        int detectedEntityCount = Physics.OverlapSphereNonAlloc(transform.position, detectionRadius, detectedColliderArray,entityLayerMask);
        this.detectedEntityAmount = detectedEntityCount;
        if (detectedEntityCount > 0 )
        {
            if(detectedColliderArray[0].gameObject.TryGetComponent<BaseEntity>(out var entity))
            {
                Debug.Log($"Entity Founded {this.detectedEntityAmount}");
                entityLocation = entity.transform.position;
                canReturnPlayer = true;
                GetComponent<RobotMovement>().SetPlayerAsTargetToRobotAndStop();
                indigator.color = Color.red;
            }
           
        }
    }
}
