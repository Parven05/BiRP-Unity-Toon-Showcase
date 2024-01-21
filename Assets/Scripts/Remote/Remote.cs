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

    private void Awake()
    {
        Instance = this;
        robotTransform = FindObjectOfType<RobotMovement>().transform;
        remoteTransform = FindObjectOfType<FirstPersonController>().transform;
    }

    private void Update()
    {
        Cursor.lockState = CursorLockMode.None;

        Color targetColor = Vector3.Distance(remoteTransform.position, robotTransform.position) <= remoteCoverageRadius
            ? Color.green
            : Color.red;

        textMeshIndigator.text = targetColor == Color.green ? "In Range" : "Not InRange";

        if (remoteScreenMaterial.GetColor("_Color") == targetColor) return;
        remoteScreenMaterial.SetColor("_Color", targetColor);


    }

    private void OnDisable()
    {
        Cursor.lockState = CursorLockMode.Locked;
    }

    private void HandleObjectClick(GameObject clickedObject)
    {
        Debug.Log($"Clicked {clickedObject.name}");
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
                    outlineSelected.OutlineColor = Color.green;
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
