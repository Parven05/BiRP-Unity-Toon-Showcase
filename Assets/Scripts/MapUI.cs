using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MapUI : MonoBehaviour
{
    public static MapUI Instance {  get; private set; }

    [SerializeField] private List<LabAddress> mapAddressList;
    [SerializeField] private Transform mapButtonsUIParent;
    [SerializeField] private Button stopRequestButton;

    public event Action<LabAddress,Transform> OnPlayerSelectedLab;
    public event Action OnPlayerMadeStopRequest;

    private Transform interactorTransform = null;
    private int movingLabId;
    private void Awake()
    {
        Instance = this;
        stopRequestButton.gameObject.SetActive(false);
    }
    // Referenced by Buttons Events
    public void SetTargetLabId(int labId)
    {
        if(labId == movingLabId)
        {
            return;
        }

        for (int i = 0; i < mapAddressList.Count; i++)
        {
            if (mapAddressList[i].labId == labId)
            {
                mapAddressList[i].UiMapButton.interactable = false;
                OnPlayerSelectedLab?.Invoke(mapAddressList[i],interactorTransform);
                movingLabId = labId;
                stopRequestButton.gameObject.SetActive(true);
                CloseUI();
                break;
            }
        }
        
    }

    public void CloseUI()
    {
        Hide();
        Cursor.lockState = CursorLockMode.Locked;
    }

    public void StopRequest()
    {
        OnPlayerMadeStopRequest?.Invoke();
    }
    private void Start()
    {
        RvInteraction.Instance.OnPlayerInteractedWithTruck += TruckInteraction_OnPlayerInteractedWithTruck;
        TruckMovement.OnTruckReachedTargetLab += TruckMovement_OnTruckReachedTargetLab;
        Hide();
    }
    

    private void TruckMovement_OnTruckReachedTargetLab()
    {
        for (int i = 0; i < mapAddressList.Count; i++)
        {
            mapAddressList[i].UiMapButton.interactable = true;
            movingLabId = 0;
            stopRequestButton.gameObject.SetActive(false);
        }
    }

    private void Update()
    {
        if (mapButtonsUIParent.gameObject.activeSelf)
        {
            Cursor.lockState = CursorLockMode.None;
        }

        if(Interactor.Instance.GetInteractable()  == null)
        {
            Hide();
        }
        
    }
    private void OnDisable()
    {
        RvInteraction.Instance.OnPlayerInteractedWithTruck -= TruckInteraction_OnPlayerInteractedWithTruck;
        TruckMovement.OnTruckReachedTargetLab -= TruckMovement_OnTruckReachedTargetLab;

    }

    private void TruckInteraction_OnPlayerInteractedWithTruck(Transform interactorTransform)
    {
        this.interactorTransform = interactorTransform;
        Show();
    }

    private void Show()
    {
        mapButtonsUIParent.gameObject.SetActive(true);
    }

    private void Hide()
    {
        mapButtonsUIParent.gameObject.SetActive(false);
    }
}
[System.Serializable]
public class LabAddress
{
    public int labId;
    public Button UiMapButton;
    public Transform labLocatedPosition;
}
