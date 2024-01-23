using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GiantRat : BaseEntity
{
    protected override void InitializeStateMachine()
    {
        stateMachine = new StateMachine();
        stateMachine.SetState(new IdleState(this));
    }

    private class IdleState : IState
    {
        private GiantRat owner;
        public IdleState(GiantRat owner)
        {
            this.owner = owner;
        }
        public void Enter()
        {
            Debug.Log("Idle State");
        }
        public void Update()
        {

        }

        public void Exit()
        {
            
        }
    }

    private class PatrolState : IState
    {
        private GiantRat owner;
        public PatrolState(GiantRat owner)
        {
            this.owner = owner;
        }
        public void Enter()
        {
            Debug.Log("Idle State");
        }
        public void Update()
        {

        }

        public void Exit()
        {

        }
    }

    private class ChasingState : IState
    {
        private GiantRat owner;
        public ChasingState(GiantRat owner)
        {
            this.owner = owner;
        }
        public void Enter()
        {
            Debug.Log("Idle State");
        }
        public void Update()
        {

        }

        public void Exit()
        {

        }
    }
}
