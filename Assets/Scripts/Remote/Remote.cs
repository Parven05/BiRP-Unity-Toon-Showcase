using TMPro;
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
    private bool isInRange;
    [SerializeField] private RemoteButton[] interactableObjects;
    private int selectedIndex;

    private void Awake()
    {
        Instance = this;
        robotTransform = FindObjectOfType<RobotMovement>().transform;
        remoteTransform = FindObjectOfType<FirstPersonController>().transform;
        selectedIndex = 0;
        UpdateOutlineSelected();
    }

    private void Update()
    {
        isInRange = Vector3.Distance(remoteTransform.position, robotTransform.position) <= remoteCoverageRadius;

        if (isInRange)
        {
            if (remoteScreenMaterial.color != Color.green)
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
            textMeshIndigator.text = "Not In Range";
        }

        if (outlineSelected != null)
        {
            outlineSelected.OutlineColor = isInRange ? Color.green : Color.red;
        }

        // Check for keyboard input
        if (isInRange)
        {
            if (Input.GetKeyDown(KeyCode.Q))
            {
                ChangeSelectedIndex(-1);
            }
            else if (Input.GetKeyDown(KeyCode.E))
            {
                ChangeSelectedIndex(1);
            }

            if (Input.GetKeyDown(KeyCode.Return))
            {
                // Simulate a click on the currently selected object
                HandleObjectClick(interactableObjects[selectedIndex].gameObject);
            }
        }
    }



    private void OnDisable()
    {
        Cursor.lockState = CursorLockMode.Locked;
    }

    private void HandleObjectClick(GameObject clickedObject)
    {
        if (isInRange && clickedObject != null)
        {
            ExecuteEvents.Execute(clickedObject, new PointerEventData(EventSystem.current), ExecuteEvents.pointerClickHandler);
            if(clickedObject.TryGetComponent(out RemoteButton remoteButton))
            {
                remoteButton.SetButtonPerformed();
            }
        }
        else
        {
            if (clickedObject.TryGetComponent(out RemoteButton remoteButton))
            {
                remoteButton.SetButtonPerformedWithError();
            }
        }
    }

    private void UpdateOutlineSelected()
    {
        if (interactableObjects.Length > 0)
        {
            outlineSelected = interactableObjects[selectedIndex].GetComponent<Outline>();
            outlineSelected.OutlineColor = Color.green;
        }
    }

    private void ChangeSelectedIndex(int change)
    {
        outlineSelected.OutlineColor = Color.white;
        selectedIndex = (selectedIndex + change + interactableObjects.Length) % interactableObjects.Length;
        UpdateOutlineSelected();
    }
}
