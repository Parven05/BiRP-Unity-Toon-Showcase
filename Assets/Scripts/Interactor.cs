using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Interactor : MonoBehaviour
{
    [SerializeField] private LayerMask interactableLayerMask;
    [SerializeField] private float interactRadius = 5f;
    private Collider[] colliderArray;
    private bool isInteractWithSomthing;
    private IInteractable currentInteractable;

    [SerializeField] private InteractionUI interactUI;
    private void Awake()
    {
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
                currentInteractable.Interact();
            }
        }
    }
}
