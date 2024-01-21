using TMPro;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.EventSystems;

public class Remote : MonoBehaviour
{
    public static Remote Instance { get; private set; }

    [SerializeField] private LayerMask remoteInteractableLayer;
    [SerializeField] private Material remoteScreenMaterial;
    [SerializeField] private float remoteCoverageRadius;
    private Transform remoteTransform;
    private Transform robotTransform;
    [SerializeField] private TextMeshPro textMeshIndigator;

    private Outline outlineSelected;
    private bool hasClicked;
    private bool isInRange;

    private void Awake()
    {
        Instance = this;
        robotTransform = FindObjectOfType<RobotMovement>().transform;
        remoteTransform = FindObjectOfType<FirstPersonController>().transform;
    }

    private void Update()
    {
        Cursor.lockState = CursorLockMode.None;

        isInRange = Vector3.Distance(remoteTransform.position, robotTransform.position) <= remoteCoverageRadius;
        if (isInRange)
        {
            if(remoteScreenMaterial.color != Color.green)
            {
               remoteScreenMaterial.color = Color.green;
            }
            textMeshIndigator.text = "In Range";
        }
        else
        {
            if (remoteScreenMaterial.color != Color.red)
            {
                remoteScreenMaterial.color = Color.red;
            }
            textMeshIndigator.text = "Not InRange";
        }

        if(outlineSelected != null)
        {
            outlineSelected.OutlineColor = isInRange ? Color.green : Color.red;
        }

    }

    private void OnDisable()
    {
        Cursor.lockState = CursorLockMode.Locked;
    }

    private void HandleObjectClick(GameObject clickedObject)
    {
        if(isInRange)
        {
            clickedObject.GetComponent<RemoteButton>().SetButtonPerformed();
        }
        else
        {
            clickedObject.GetComponent<RemoteButton>().SetButtonPerformedWithError();
        }
            
    }

    private void FixedUpdate()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        if (Physics.Raycast(ray, out RaycastHit hitInfo, 3f, remoteInteractableLayer))
        {
            if (hitInfo.collider != null)
            {
                if (outlineSelected == null)
                {
                    outlineSelected = hitInfo.collider.gameObject.GetComponent<Outline>();
                }
             
                // Check if the object implements the IPointerClickHandler interface
                if (hitInfo.collider.gameObject.GetComponent<IPointerClickHandler>() != null)
                {
                    // Execute the OnPointerDown method when the object is clicked
                    if (Input.GetMouseButtonDown(0) && !hasClicked)
                    {
                        ExecuteEvents.Execute(hitInfo.collider.gameObject, new PointerEventData(EventSystem.current), ExecuteEvents.pointerDownHandler);
                        HandleObjectClick(hitInfo.collider.gameObject);
                        hasClicked = true;
                    }
                }
            }
 
        }
        else
        {
            if (outlineSelected != null)
            {
                outlineSelected.OutlineColor = Color.white;
                outlineSelected = null;
            }

            // Reset the hasClicked flag when not over an interactable object
            hasClicked = false;
        }
    }
}
