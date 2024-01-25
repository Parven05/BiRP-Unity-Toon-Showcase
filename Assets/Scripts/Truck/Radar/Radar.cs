using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class Radar : MonoBehaviour
{
    [SerializeField] private float radarSpeed = 5f;
    [SerializeField] private Transform radarAnalogeTransform;
    [SerializeField] private LayerMask detectableLayerMask;
    [SerializeField] private float detectionRadius = 20f;
    private Collider[] colliderArray = new Collider[20];

    private void Update()
    {
        transform.eulerAngles -= new Vector3(0, Time.deltaTime * radarSpeed * 5, 0);
        radarAnalogeTransform.eulerAngles -= new Vector3(0, 0, Time.deltaTime * radarSpeed * 5);

        int colliderCount = Physics.OverlapSphereNonAlloc(transform.position, detectionRadius, colliderArray, detectableLayerMask);

        foreach (Collider collider in colliderArray)
        {
        }
        
    }


}
