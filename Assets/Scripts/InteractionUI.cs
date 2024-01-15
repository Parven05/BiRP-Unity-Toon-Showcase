using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InteractionUI : MonoBehaviour
{
    [SerializeField] private Image interactIndigator;

    public void Show()
    {
        interactIndigator.gameObject.SetActive(true);
    }

    public void Hide()
    {
        interactIndigator.gameObject.SetActive(false);
    }
}
