using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class BaseEntity : MonoBehaviour
{
    [SerializeField] private EntityDataSO entityDataSO;
    protected StateMachine stateMachine;

    protected virtual void Start()
    {
        InitializeStateMachine();
    }

    protected abstract void InitializeStateMachine();
    protected void Update()
    {
        stateMachine?.Update();
    }

}
