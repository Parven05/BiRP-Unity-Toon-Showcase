using System;
using UnityEngine;

public class RvInteraction : MonoBehaviour,IInteractable
{
    public static RvInteraction Instance { get; private set; }

    [SerializeField] private Transform topLandingTransform;

    public event Action OnPlayerInteractedWithTruck;
    private void Awake()
    {
        Instance = this;
    }
    public void Interact()
    {
        Debug.Log("Truck Interacted");
        OnPlayerInteractedWithTruck?.Invoke();
    }

    public Transform GetTruckStandPos()
    {
        return topLandingTransform;
    }

   
}
