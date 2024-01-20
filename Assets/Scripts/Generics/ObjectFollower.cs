using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectFollower : MonoBehaviour
{
    [SerializeField] private GameObject toFollowObject;
    [SerializeField] private Vector3 offset;
    // Update is called once per frame
    void Update()
    {
        transform.position = toFollowObject.transform.position + offset;
    }
}
