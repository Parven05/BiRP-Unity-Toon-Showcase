using UnityEngine;
using UnityEngine.AI;

public abstract class BaseEntity : MonoBehaviour
{
    [SerializeField] protected EntityDataSO entityDataSO;
    [SerializeField] protected NavMeshAgent agent;
    [SerializeField] protected float sightRadius;
    [SerializeField] protected float attackRadius;
    [SerializeField] protected LayerMask attackablesLayer;
    protected bool attackablesInSightRange;
    protected bool attackablesInAttackRange;
    protected Collider[] attckableObjColliders = new Collider[20];
    protected int gatheredColloderCount;
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
