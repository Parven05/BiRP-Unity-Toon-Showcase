using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TruckInteraction : MonoBehaviour,IInteractable
{
    public static TruckInteraction Instance { get; private set; }

    public event EventHandler OnPlayerInteractedWithTruck;
    private void Awake()
    {
        Instance = this;
    }
    public void Interact()
    {
        Debug.Log("Truck Interacted");
        OnPlayerInteractedWithTruck?.Invoke(this, EventArgs.Empty);
    }

   
}
