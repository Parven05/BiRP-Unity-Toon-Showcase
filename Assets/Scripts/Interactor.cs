using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Interactor : MonoBehaviour
{
    public static Interactor Instance { get; private set; }

    [SerializeField] private LayerMask interactableLayerMask;
    [SerializeField] private float interactRadius = 5f;
    private Collider[] colliderArray;
    private IInteractable currentInteractable;

    [SerializeField] private InteractionUI interactUI;
    private void Awake()
    {
        Instance = this;
        colliderArray = new Collider[10];
    }

    private void FixedUpdate()
    {
        int colliderCount = Physics.OverlapSphereNonAlloc(transform.position, interactRadius, colliderArray,interactableLayerMask);
        if(colliderCount > 0)
        {
            Collider collider = colliderArray[0]; //First Interacted Object Collider
            if( collider != null )
            {
                if(collider.gameObject.TryGetComponent(out IInteractable interactable))
                {
                    currentInteractable = interactable;
                    interactUI.Show();
                }
            }
        }
        else
        {
            currentInteractable = null;
            interactUI.Hide();
        }
       
    }

    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.E))
        {
            if (currentInteractable != null)
            {
                currentInteractable.Interact(transform);
            }
        }
    }

    public IInteractable GetInteractable()
    {
        return currentInteractable;
    }
}
