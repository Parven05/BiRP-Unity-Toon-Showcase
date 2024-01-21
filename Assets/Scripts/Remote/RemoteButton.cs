using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class RemoteButton : MonoBehaviour,IPointerClickHandler
{
    public static event Action<string> OnAnyRemoteButtonClicked;
    public static event Action<string> OnAnyRemoteButtonClickedWithError;
    [SerializeField] string buttonName;
    public void OnPointerClick(PointerEventData eventData)
    {
    }

    public void SetButtonPerformed()
    {
        OnAnyRemoteButtonClicked?.Invoke(buttonName);
    }

    public void SetButtonPerformedWithError()
    {
        OnAnyRemoteButtonClickedWithError?.Invoke(buttonName);
    }
}
