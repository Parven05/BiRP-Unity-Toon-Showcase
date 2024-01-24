using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RvInteraction : MonoBehaviour,IInteractable
{
    public static RvInteraction Instance { get; private set; }

    [SerializeField] private Transform topLandingTransform;

    public event Action<Transform> OnPlayerInteractedWithTruck;
    private void Awake()
    {
        Instance = this;
    }
    public void Interact(Transform interactor)
    {
        Debug.Log("Truck Interacted");
        OnPlayerInteractedWithTruck?.Invoke(interactor);
    }

    public Transform GetTruckStandPos()
    {
        return topLandingTransform;
    }

   
}
