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

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.F))
        {
            ToggleTorch();
        }
    }

    private void ToggleTorch()
    {
        // flipping Torch State
        torchLight.SetActive(!torchLight.activeSelf);

        // Simplyfied If Statements
        AudioSource.PlayClipAtPoint(torchLight.activeSelf ? onClip : offClip, torchPos.position, 1f);
    }
}