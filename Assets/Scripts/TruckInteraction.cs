using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TruckInteraction : MonoBehaviour,IInteractable
{
    public static TruckInteraction Instance { get; private set; }

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

   
}
