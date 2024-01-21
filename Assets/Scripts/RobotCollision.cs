using System;
using UnityEngine;

public class RobotCollision : MonoBehaviour,IDamagable
{
    public event EventHandler OnRobotGetShot;

    public void TakeDamage(float damageAmount)
    {
        Debug.Log("Dont Shoot Me");
        OnRobotGetShot?.Invoke(this, EventArgs.Empty);
    }
}
