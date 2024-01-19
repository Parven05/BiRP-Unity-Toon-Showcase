using System;
using UnityEngine;

public class RobotCollision : MonoBehaviour, IInteractable,IDamagable
{
    public event EventHandler OnRobotGetShot;
    [SerializeField] private RobotCommandUI commandUI;
    public void Interact(Transform interactor)
    {
        Debug.Log("Robot Interacted");
        commandUI.Show();
    }

    public void TakeDamage(float damageAmount)
    {
        Debug.Log("Dont Shoot Me");
        OnRobotGetShot?.Invoke(this, EventArgs.Empty);
    }
}
