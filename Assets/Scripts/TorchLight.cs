using System;
using UnityEngine;

public class TorchLight : MonoBehaviour
{
    [Header("Light")]
    [SerializeField] private GameObject torchLight;
    [SerializeField] private Transform torchPos;
    
    [Header("Audio")]
    [SerializeField] private AudioClip onClip;
    [SerializeField] private AudioClip offClip;

    private bool isTorchOn = false;

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.F))
        {
            ToggleTorch();
        }
    }

    void ToggleTorch()
    {
        isTorchOn = !isTorchOn;

        if (isTorchOn)
        {
            torchLight.SetActive(true);
            AudioSource.PlayClipAtPoint(onClip, torchPos.position, 1f);
        }
        else
        {
            torchLight.SetActive(false);
            AudioSource.PlayClipAtPoint(offClip, torchPos.position, 1f);
        }
    }
}