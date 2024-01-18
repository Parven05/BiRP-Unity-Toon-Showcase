using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Interactor : MonoBehaviour
{
    public static Interactor Instance { get; private set; }

    [SerializeField] private Transform cameraTransform;
    [SerializeField] private Image crossHairImage;
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
        HandleOverlapSphereInteract();
        HandleCursorInteractVisual();

    }

    private void CastRay()
    {

        if (!Physics.Raycast(cameraTransform.position, cameraTransform.forward, out RaycastHit hit, interactRadius, interactableLayerMask)) return;

        if (hit.collider != null)
        {
            if (hit.collider.TryGetComponent(out IInteractable interactable))
            {
                interactable.Interact(transform);
            }
        }
    }

    private void HandleCursorInteractVisual()
    {
        if (!Physics.Raycast(cameraTransform.position, cameraTransform.forward, out RaycastHit hit, interactRadius, interactableLayerMask))
        {
            Debug.DrawRay(cameraTransform.position, cameraTransform.forward * interactRadius, Color.green);
            if (crossHairImage.color != Color.white)
                crossHairImage.color = Color.white;
            return;
        }

        if (hit.collider != null)
        {
            crossHairImage.color = Color.red;
            Debug.DrawRay(cameraTransform.position, cameraTransform.forward * interactRadius, Color.red);
        }
    }

    private void HandleOverlapSphereInteract()
    {
        int colliderCount = Physics.OverlapSphereNonAlloc(transform.position, interactRadius, colliderArray, interactableLayerMask);
        if (colliderCount > 0)
        {
            Collider collider = colliderArray[0]; //First Interacted Object Collider
            if (collider != null)
            {
                if (collider.gameObject.TryGetComponent(out IInteractable interactable))
                {
                    currentInteractable = interactable;
                    if(currentInteractable is TruckInteraction) interactUI.Show();
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

        if (Input.GetKeyDown(KeyCode.Mouse0))
        {
            CastRay();
        }
    }

    public IInteractable GetInteractable()
    {
        return currentInteractable;
    }
}
