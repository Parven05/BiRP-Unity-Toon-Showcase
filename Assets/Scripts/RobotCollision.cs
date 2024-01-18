using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RobotCollision : MonoBehaviour, IInteractable
{
    [SerializeField] private RobotCommandUI commandUI;
    public void Interact(Transform interactor)
    {
        Debug.Log("Robot Interacted");
        commandUI.Show();
    }
}
